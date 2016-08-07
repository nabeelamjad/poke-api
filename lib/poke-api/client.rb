module Poke
  module API
    class Client
      include Logging
      attr_accessor :lat, :lng, :alt, :endpoint, :ticket, :sig_path

      def initialize
        @auth     = nil
        @endpoint = 'https://pgorelease.nianticlabs.com/plfe/rpc'
        @reqs     = []
        @lat      = 0
        @lng      = 0
        @alt      = 8
        @ticket   = Auth::Ticket.new
        @sig_path = nil
      end

      def login(username, password, provider)
        provider = provider.upcase
        raise Errors::InvalidProvider, provider unless %w(PTC GOOGLE).include?(provider)
        logger.info "[+] Logging in user: #{username}"

        begin
          @auth = Auth.const_get(provider).new(username, password)
          @auth.connect
        rescue StandardError => ex
          raise Errors::LoginFailure.new(provider, ex)
        end

        get_hatched_eggs
        call
        logger.info "[+] Login with #{provider} Successful"
      end

      def call
        raise Errors::LoginRequired unless @auth
        raise Errors::NoRequests if @reqs.empty?
        req = RequestBuilder.new(@auth, [@lat, @lng, @alt], @endpoint)

        begin
          resp = req.request(@reqs, self)
        rescue StandardError => ex
          raise Errors::UnknownProtoFault, ex
        ensure
          @reqs = []
          logger.info '[+] Cleaning up RPC requests'
        end

        resp
      end

      def activate_signature(file_path)
        if File.exist?(path)
          logger.info "[+] File #{file_path} has been set for signature generation"
          @sig_path = path
        else
          raise Errors::InvalidSignatureFilePath, file_path
        end
      end

      def store_location(loc)
        pos = Poke::API::Helpers.get_position(loc).first
        logger.info "[+] Given location: #{pos.address}"

        logger.info "[+] Lat/Long: #{pos.latitude}, #{pos.longitude}"
        @lat = pos.latitude
        @lng = pos.longitude
      end

      def store_lat_lng(lat, lng)
        logger.info "[+] Lat/Long: #{lat}, #{lng}"
        @lat, @lng = lat, lng
      end

      def inspect
        "#<#{self.class.name} @auth=#{@auth} @reqs=#{@reqs} " \
        "@lat=#{@lat} @lng=#{@lng} @alt=#{@alt}>"
      end

      private

      def method_missing(method, *args)
        POGOProtos::Networking::Requests::RequestType.const_get(method.upcase)
        @reqs << (args.empty? ? method.to_sym.upcase : { method.to_sym.upcase => args.first })
      rescue NameError
        super
      end
    end
  end
end
