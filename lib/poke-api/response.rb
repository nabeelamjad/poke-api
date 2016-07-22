module Poke
  module API
    class Response
      include Logging
      attr_reader :response, :request

      def initialize(response, request)
        @response = response
        @request = request
      end

      def decode_response
        logger.info '[+] Decoding Main RPC responses'
        @response = RpcEnvelope::Response.decode(@response)

        logger.debug "[+] Decoding RPC response \r\n#{@response.inspect}"
        logger.info '[+] Decoding Sub RPC responses'

        decoded_resp = parse_rpc_fields(decode_sub_responses)

        loop do
          break unless decoded_resp.to_s.include?('RpcSub::')
          parse_rpc_fields(decoded_resp)
        end

        decoded_resp[:api_url] = @response.api_url unless @response.api_url.empty?
        @response = decoded_resp

        logger.debug "[+] Returned RPC response \r\n#{@response}"
      end

      private

      def decode_sub_responses
        @response.responses.zip(@request).each_with_object({}) do |(resp, req), memo|
          proto_name, entry_name = fetch_proto_response_metadata(req)

          resp = begin
            RpcSub.const_get(proto_name).decode(resp).to_hash
          rescue StandardError
            logger.error "[+] Protobuf definition mismatch/not found for #{entry_name}"
            'Mismatched/Invalid Protobuf Definition'
          end

          memo[entry_name] = resp
        end
      end

      def fetch_proto_response_metadata(req)
          entry_id   = req.is_a?(Fixnum) ? req : req.keys.first
          entry_name = RpcEnum::RequestMethod.lookup(entry_id)
          proto_name = Poke::API::Helpers.camel_case_lower(entry_name) + 'Response'

          [ proto_name, entry_name ]
      end

      def parse_rpc_fields(responses)
        responses.map! do |x|
          x = x.to_hash if x.class.name =~ /RpcSub/
          x
        end if responses.is_a?(Array)

        responses.each do |k, v|
          parse_rpc_fields(v) if [Hash, Array].include?(v.class)
          parse_rpc_fields(k) if [Hash, Array].include?(k.class)

          responses[k] = v.to_hash if v.class.name =~ /RpcSub/
        end
      end
    end
  end
end
