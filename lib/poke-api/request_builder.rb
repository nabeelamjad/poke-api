require 'ffi'
require 'securerandom'

module Poke
  module API
    class RequestBuilder
      extend FFI::Library
      include Logging

      def initialize(auth, pos, endpoint)
        @access_token = auth.access_token
        @provider     = auth.provider
        @endpoint     = endpoint
        @position     = pos
        @client       = HTTPClient.new(agent_name: 'PokeAPI/0.0.1')
        @start_time   = (Time.now.to_f * 1000).to_i
        @ffi_enabled  = false
      end

      def request(reqs, client)
        logger.debug '[+] Creating new request'
        request_proto = build_main_request(reqs, client)
        logger.debug "[+] Generated RPC protobuf encoded request \r\n#{request_proto.inspect}"

        logger.info '[+] Executing RPC request'
        resp = execute_rpc_request(request_proto)

        resp = Response.new(resp.body, reqs)
        resp.decode_response(client)

        resp
      end

      private

      def build_main_request(sub_reqs, client)
        request_envelope = POGOProtos::Networking::Envelopes::RequestEnvelope
        req = request_envelope.new(
          status_code: 2,
          request_id: 814_580_613_288_820_746_0,
          unknown12: 989
        )
        req.latitude, req.longitude, req.altitude = @position

        build_sub_request(req, sub_reqs)
        set_authentication(req, client, request_envelope)

        logger.debug "[+] Generated RPC protobuf request \r\n#{req.inspect}"
        req.to_proto
      end

      def set_authentication(req, client, request_envelope)
        if client.ticket.get_ticket
          logger.info '[+] Using Auth ticket'

          req.auth_ticket = POGOProtos::Networking::Envelopes::AuthTicket.new(
            start: client.ticket.start, end: client.ticket.ends,
            expire_timestamp_ms: client.ticket.expire
          )

          load_library(client.sig_path) if client.sig_path && !@ffi_enabled
          set_signature(req, request_envelope) if @ffi_enabled
        else
          logger.info '[+] Using Provider token'
          token = request_envelope::AuthInfo::JWT.new(contents: @access_token, unknown2: 59)
          req.auth_info = request_envelope::AuthInfo.new(provider: @provider, token: token)
        end
      end

      def set_signature(req, _request_envelope)
        signature = Signature.new(
          location_hash1: Helpers.generate_location_one(req.auth_ticket.to_proto, @position),
          location_hash2: Helpers.generate_location_two(@position),
          unk22: SecureRandom.random_bytes(32),
          timestamp: (Time.now.to_f * 1000).to_i,
          timestamp_since_start: (Time.now.to_f * 1000).to_i - @start_time
        )

        req.requests.each do |r|
          signature.request_hash << Helpers.generate_request(req.auth_ticket.to_proto, r.to_proto)
        end

        unknown6 = POGOProtos::Networking::Envelopes::Unknown6

        req.unknown6 = unknown6.new(
          unknown1: 6,
          unknown2: unknown6::Unknown2.new(unknown1: generate_signature(signature.to_proto))
        )

        logger.info '[+] Setting Signature'
      end

      def generate_signature(signature)
        attempts = 5

        begin
          logger.info '[+] Generating Signature'
          output_size = FFI::MemoryPointer.new(:size_t)

          iv = SecureRandom.random_bytes(32)
          RequestBuilder.encrypt(signature, signature.length, iv, 32, nil, output_size)

          output = FFI::MemoryPointer.new(output_size.read_int)
          RequestBuilder.encrypt(signature, signature.length, iv, 32, output, output_size)
        rescue StandardError => ex
          raise ex if (attempts -= 1) == 0
          retry
        end

        output.read_string
      end

      def load_library(path)
        RequestBuilder.ffi_lib(path)
        RequestBuilder.attach_function(
          :encrypt,
          [:string, :size_t, :string, :size_t, :pointer, :pointer],
          :int
        )

        @ffi_enabled = true
      end

      def build_sub_request(req, sub_reqs)
        sub_reqs.each do |sub_req|
          if sub_req.is_a?(Symbol)
            append_int_request(req, sub_req)
          elsif sub_req.is_a?(Hash)
            append_hash_request(req, sub_req)
          else
            raise Errors::InvalidRequestEntry, sub_req
          end
        end
      end

      def append_int_request(req, sub_req)
        entry_id = fetch_request_id(sub_req)
        int_req = POGOProtos::Networking::Requests::Request.new(request_type: entry_id)

        req.requests << int_req
        logger.info "[+] Adding '#{int_req.request_type}' to RPC request"
      end

      def append_hash_request(req, sub_req)
        entry_name = sub_req.keys.first
        entry_id   = fetch_request_id(entry_name)

        logger.info "[+] Adding '#{entry_name}' to RPC request with arguments"
        proto_class = fetch_proto_request_class(sub_req, entry_name)

        req.requests << POGOProtos::Networking::Requests::Request.new(
          request_type: entry_id,
          request_message: proto_class.to_proto
        )
      end

      def fetch_request_id(name)
        POGOProtos::Networking::Requests::RequestType.const_get(name)
      end

      def fetch_proto_request_class(sub_req, entry_name)
        entry_content = sub_req[entry_name]
        proto_name    = Poke::API::Helpers.camel_case_lower(entry_name) + 'Message'
        logger.debug "[+] #{entry_name}: #{entry_content}"

        require "poke-api/POGOProtos/Networking/Requests/Messages/#{proto_name}"
        POGOProtos::Networking::Requests::Messages.const_get(proto_name).new(entry_content)
      end

      def execute_rpc_request(request)
        @client.post(@endpoint, request)
      end
    end
  end
end
