require 'gpsoauth'

module Poke
  module API
    module Auth
      class GOOGLE
        include Logging
        attr_reader :access_token, :provider

        GOOGLE_LOGIN_ANDROID_ID = '9774d56d682e549c'
        GOOGLE_LOGIN_SERVICE    = 'audience:server:client_id:848232511240-7so421jotr' \
                                  '2609rmqakceuu1luuq0ptb.apps.googleusercontent.com'
        GOOGLE_LOGIN_APP        = 'com.nianticlabs.pokemongo'
        GOOGLE_LOGIN_CLIENT_SIG = '321187995bc7cdc2b5fc91b11a96e2baa8602c62'

        def initialize(username, password)
          @username = username
          @password = password
          @provider = 'google'
        end

        def connect
          logger.debug '[>] Fetching Google access token'

          token_request = perform_request('Token') do
            Gpsoauth::Auth.performMasterLogin(@username, @password, GOOGLE_LOGIN_ANDROID_ID)
          end

          auth_request = perform_request('Auth') do
            Gpsoauth::Auth.performOAuth(@username, token_request['Token'], GOOGLE_LOGIN_ANDROID_ID,
                                        GOOGLE_LOGIN_SERVICE, GOOGLE_LOGIN_APP, GOOGLE_LOGIN_CLIENT_SIG)
          end

          @access_token = auth_request['Auth']
        end

        private

        def perform_request(method)
          response = yield

          if response['Error'] == 'NeedsBrowser'
            raise Errors::GoogleTwoFactorAuthenticationFailure.new(response)
          else
            unless response['Token'] || response['Auth']
              raise Errors::GoogleAuthenticationFailure.new(method, response)
            end
          end

          response
        end
      end
    end
  end
end
