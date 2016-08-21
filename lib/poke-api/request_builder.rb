require 'securerandom'

module Poke
  module API
    class RequestBuilder
      include Logging
      attr_reader :position, :start_time

      def initialize(auth, pos, endpoint, http_client)
        @access_token = auth.access_token
        @provider     = auth.provider
        @endpoint     = endpoint
        @position     = pos
        @client       = http_client ? http_client : HTTPClient.new
        @start_time   = Helpers.fetch_time
      end

      def request(reqs, client)
        logger.debug '[+] Creating new request'
        request_proto = build_main_request(reqs, client)

        logger.debug "[+] Generated RPC protobuf encoded request \r\n#{request_proto.inspect}"
        logger.info '[+] Executing RPC request'

        resp = execute_rpc_request(request_proto)
        resp = Response.new(resp.body, reqs)

        resp.decode(client)
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
          use_auth_ticket(req, client)
        else
          logger.info '[+] Using provider access token'
          token = request_envelope::AuthInfo::JWT.new(contents: @access_token, unknown2: 59)
          req.auth_info = request_envelope::AuthInfo.new(provider: @provider, token: token)
        end
      end

      def use_auth_ticket(req, client)
        req.auth_ticket = POGOProtos::Networking::Envelopes::AuthTicket.new(
          start: client.ticket.start, end: client.ticket.ends,
          expire_timestamp_ms: client.ticket.expire
        )

        Signature.load_signature(client) if client.sig_path
        Signature.create_signature(req, self, client) if client.sig_loaded
      end

      def build_sub_request(req, sub_reqs)
        sub_reqs.each do |sub_req|
          if sub_req.is_a?(Symbol)
            append_int_request(req, sub_req)
          elsif sub_req.is_a?(Hash)
            append_hash_request(req, sub_req)
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

        POGOProtos::Networking::Requests::Messages.const_get(proto_name).new(entry_content)
      end

      def execute_rpc_request(request)
        resp = @client.post(@endpoint, request)
        raise Errors::ForbiddenAccess if resp.status == 403

        resp
      end
    end
  end
end
