module Poke
  module API
    class Client
      include Logging
      attr_accessor :lat, :lng, :alt

      def initialize
        @auth     = nil
        @endpoint = 'https://pgorelease.nianticlabs.com/plfe/rpc'
        @reqs     = []
        @lat      = 0
        @lng      = 0
        @alt      = 0
      end

      def login(username, password, provider)
        raise Errors::InvalidProvider.new(provider) unless ['PTC', 'GOOGLE'].include?(provider.upcase!)
        logger.info "[+] Logging in user: #{username}"

        begin
          @auth = Auth.const_get(provider).new(username, password)
          @auth.connect
        rescue StandardError => ex
          raise Errors::LoginFailure.new(provider, ex)
        end

        logger.info "[+] Login with #{provider} Successful"
        fetch_endpoint
      end

      def call
        raise Errors::LoginRequired.new unless @auth
        req = RequestBuilder.new(@auth, [@lat, @lng, @alt], @endpoint)

        begin
          resp = req.request(@reqs)
        rescue StandardError => ex
          raise Errors::UnknownProtoFault.new(ex)
        ensure
          @reqs = []
          logger.info '[+] Cleaning up RPC requests'
        end

        resp
      end

      def store_location(loc)
        pos = Poke::API::Helpers.get_position(loc).first
        logger.info "[+] Given location: #{pos.address}"

        @lat, @lng = Poke::API::Helpers.float_to_int([pos.latitude, pos.longitude])
        logger.info "[+] Lat/Long: #{pos.latitude}, #{pos.longitude}"
      end

      def inspect
        "#<#{self.class.name} @auth=#{@auth} @reqs=#{@reqs} " \
        "@lat=#{@lat} @lng=#{@lng} @alt=#{@alt}>"
      end

      private

      def fetch_endpoint
        get_player
        get_hatched_eggs
        get_inventory
        check_awarded_badges
        download_settings(hash: '4a2e9bc330dae60e7b74fc85b98868ab4700802e')

        @endpoint = "https://#{call.response[:api_url]}/rpc"
        logger.debug "[+] Setting endpoint to #{@endpoint}"
      end

      def method_missing(method_name, *arguments)
        name = method_name.upcase

        begin
          if arguments.empty?
            @reqs << RpcEnum::RequestMethod.const_get(name)
          else
            @reqs << { RpcEnum::RequestMethod.const_get(name) => arguments.first }
          end
        rescue NameError
          raise Errors::InvalidRPC.new(name.to_s)
        end
      end
    end
  end
end
