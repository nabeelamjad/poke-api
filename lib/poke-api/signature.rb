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

        output.to_str
      end
    end
  end
end
