module Poke
  module API
    class RequestBuilder
      include Logging

      def initialize(auth, pos, endpoint)
        @access_token = auth.access_token
        @provider     = auth.provider
        @endpoint     = endpoint
        @position     = pos
        @client       = HTTPClient.new(agent_name: 'PokeAPI/0.0.1')
      end

      def request(reqs)
        logger.debug '[+] Creating new request'
        request_proto = build_main_request(reqs)

        logger.info '[+] Executing RPC request'
        resp = execute_rpc_request(request_proto)

        resp = Response.new(resp.body, reqs)
        resp.decode_response

        resp
      end

      private

      def build_main_request(sub_reqs)
        req = RpcEnvelope::Request.new(
          direction: RpcEnum::RpcDirection.const_get(:REQUEST),
          rpc_id: 814_580_613_288_820_746_0,
          unknown12: 989
        )

        req.latitude, req.longitude, req.altitude = @position

        token = RpcEnvelope::Request::AuthInfo::JWT.new(contents: @access_token, unknown13: 59)
        req.auth = RpcEnvelope::Request::AuthInfo.new(provider: @provider, token: token)

        build_sub_request(req, sub_reqs)

        logger.debug "[+] Generated RPC protobuf request \r\n#{req.inspect}"

        req.to_proto
      end

      def build_sub_request(req, sub_reqs)
        sub_reqs.each do |sub_req|
          if sub_req.is_a?(Fixnum)
            append_int_request(req, sub_req)
          elsif sub_req.is_a?(Hash)
            append_hash_request(req, sub_req)
          else
            raise Errors::InvalidRequestEntry.new(sub_req)
          end
        end
      end

      def append_int_request(req, sub_req)
        int_req = RpcEnvelope::Request::Requests.new(type: sub_req)

        req.requests << int_req
        logger.info "[+] Adding '#{int_req.type}' to RPC request"
      end

      def append_hash_request(req, sub_req)
        entry_id    = sub_req.keys.first
        entry_name  = RpcEnum::RequestMethod.lookup(entry_id)

        logger.info "[+] Adding '#{entry_name}' to RPC request with arguments"

        proto_class = fetch_proto_request_class(sub_req, entry_id, entry_name)

        req.requests << RpcEnvelope::Request::Requests.new(
          type: entry_id,
          parameters: proto_class.to_proto
        )
      end

      def fetch_proto_request_class(sub_req, entry_id, entry_name)
        entry_content = sub_req[entry_id]
        logger.debug "[+] #{entry_name}: #{entry_content}"

        proto_name    = Poke::API::Helpers.camel_case_lower(entry_name) + 'Request'

        RpcSub.const_get(proto_name).new(entry_content)
      end

      def execute_rpc_request(request)
        @client.post(@endpoint, request)
      end
    end
  end
end
