require 'fiddle'
require 'fiddle/import'

module Poke
  module API
    module Signature
      extend Fiddle::Importer
      extend Logging

      def self.load_signature(client)
        dlload client.sig_path
        extern "int encrypt(const unsigned char *input, size_t input_size," \
               " const unsigned char* iv, size_t iv_size, unsigned char* " \
               "output, size_t * output_size)"
        logger.info '[+] Loaded Signature module'
        client.sig_loaded = true
      end

      def self.generate_signature(signature)
        output_size = Fiddle::Pointer.malloc(1)

        iv = SecureRandom.random_bytes(32)
        encrypt(signature, signature.length, iv, 32, nil, output_size)

        output = Fiddle::Pointer.malloc(288)
        encrypt(signature, signature.length, iv, 32, output, output_size)

        logger.debug "[+] Generated Encrypted Signature \r\n#{output.to_str.inspect}"

        output.to_str
      end

      def self.create_signature(req, req_client, api_client)
        signature = POGOProtos::Networking::Envelopes::Signature.new(
          location_hash1: Helpers.generate_location_one(req.auth_ticket.to_proto, req_client.position),
          location_hash2: Helpers.generate_location_two(req_client.position),
          unknown25: -8537042734809897855,
          timestamp: Helpers.fetch_time,
          timestamp_since_start: Helpers.fetch_time - req_client.start_time
        )

        add_requests(req, signature)
        add_optional_signature_information(signature, api_client)

        logger.debug "[+] Generated Signature \r\n#{signature.inspect}"
        logger.debug "[+] Generated Protobuf Signature \r\n#{signature.to_proto.inspect}"
        add_unknown6(req, signature)
      end

      def self.add_requests(req, signature)
        req.requests.each do |r|
          signature.request_hash << Helpers.generate_request(req.auth_ticket.to_proto, r.to_proto)
        end
      end

      def self.add_unknown6(req, signature)
        req.unknown6 = POGOProtos::Networking::Envelopes::Unknown6.new(
          request_type: 6,
          unknown2: POGOProtos::Networking::Envelopes::Unknown6::Unknown2.new(
            encrypted_signature: generate_signature(signature.to_proto)
          )
        )
      end

      def self.add_optional_signature_information(sig, api_client)
        %i(android_gps_info sensor_info device_info activity_status location_fix).each do |i|
          name = Helpers.camel_case_lower(i)

          if api_client.send(i)
            message = add_optional_information(name, api_client.send(i))
            i == :location_fix ? (sig.send(i) << message) : sig.send("#{i.to_s}=", message)
          end
        end
      end

      def self.add_optional_information(name, client_info)
        info_class = POGOProtos::Networking::Envelopes::Signature.const_get(name)
        info_class.new(client_info)
      end

      private_class_method :add_requests, :add_unknown6
    end
  end
end
