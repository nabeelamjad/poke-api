module Poke
  module API
    class Client
      include Logging
      attr_accessor :endpoint, :sig_loaded, :refresh_token,
                    :lat, :lng, :alt, :http_client, :ticket,
                    :android_gps_info, :sensor_info, :device_info,
                    :activity_status, :location_fix
      attr_reader   :sig_path, :auth

      def initialize
        @endpoint   = 'https://pgorelease.nianticlabs.com/plfe/rpc'
        @reqs       = []
        @lat        = 0
        @lng        = 0
        @alt        = rand(1..9)
        @ticket     = Auth::Ticket.new
        @sig_loaded = false
      end

      def login(username, password, provider)
        @username, @password, @provider = username, password, provider.upcase
        raise Errors::InvalidProvider, provider unless %w(PTC GOOGLE).include?(@provider)

        begin
          @auth = Auth.const_get(@provider).new(@username, @password, @refresh_token)
          @auth.connect
        rescue StandardError => ex
          raise Errors::LoginFailure.new(@provider, ex)
        end

        initialize_ticket
        logger.info "[+] Login with #{@provider} Successful"
      end

      def call
        raise Errors::LoginRequired unless @auth
        raise Errors::NoRequests if @reqs.empty?

        check_expiry
        req = RequestBuilder.new(@auth, [@lat, @lng, @alt], @endpoint, @http_client)

        begin
          resp = req.request(@reqs, self)
        rescue StandardError => ex
          error(ex)
        ensure
          @reqs = []
          logger.info '[+] Cleaning up RPC requests'
        end

        resp
      end

      def activate_signature(file_path)
        if File.exist?(file_path)
          logger.info "[+] File #{file_path} has been set for signature generation"
          @sig_path = file_path
        else
          raise Errors::InvalidSignatureFilePath, file_path
        end
      end

      def store_location(loc)
        pos = Poke::API::Helpers.get_position(loc).first
        logger.info "[+] Given location: #{pos.address}"

        logger.info "[+] Lat/Long/Alt: #{pos.latitude}, #{pos.longitude}"
        @lat, @lng = pos.latitude, pos.longitude
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

      def initialize_ticket
        get_hatched_eggs
        call
      end

      def check_expiry
        unless @ticket.has_ticket?
          now = Helpers.fetch_time(ms: false)

          if now < (@auth.expiry - 30)
            duration = format('%02d:%02d:%02d', *Helpers.format_time_diff(now, @auth.expiry, false))
            logger.info "[+] Provider access token is valid for #{duration}"
            return
          end

          logger.info "[+] Refreshing access token as it is no longer valid"
          login(@username, @password, @provider)
        end
      end

      def error(ex)
        if Poke::API::Errors.constants.include?(ex.class.to_s.split('::').last.to_sym)
          raise ex.class
        end

        raise Errors::UnknownProtoFault, ex
      end

      def method_missing(method, *args)
        POGOProtos::Networking::Requests::RequestType.const_get(method.upcase)
        @reqs << (args.empty? ? method.to_sym.upcase : { method.to_sym.upcase => args.first })
      rescue NameError
        super
      end
    end
  end
end
