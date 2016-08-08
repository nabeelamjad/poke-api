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

      def self.create_signature(req, client)
        signature = POGOProtos::Networking::Envelopes::Signature.new(
          location_hash1: Helpers.generate_location_one(req.auth_ticket.to_proto, client.position),
          location_hash2: Helpers.generate_location_two(client.position),
          unknown22: SecureRandom.random_bytes(32),
          timestamp: Helpers.fetch_time,
          timestamp_since_start: Helpers.fetch_time - client.start_time
        )

        add_requests(req, signature)

        logger.debug "[+] Generated Signature \r\n#{signature.to_proto.inspect}"
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

      private_class_method :add_requests, :add_unknown6
    end
  end
end
