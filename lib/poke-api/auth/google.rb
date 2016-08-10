require 'gpsoauth'

module Poke
  module API
    module Auth
      class GOOGLE
        include Logging
        attr_reader :access_token, :provider, :expiry

        GOOGLE_LOGIN_ANDROID_ID = '9774d56d682e549c'.freeze
        GOOGLE_LOGIN_SERVICE    = 'audience:server:client_id:848232511240-7so421jotr' \
                                  '2609rmqakceuu1luuq0ptb.apps.googleusercontent.com'.freeze
        GOOGLE_LOGIN_APP        = 'com.nianticlabs.pokemongo'.freeze
        GOOGLE_LOGIN_CLIENT_SIG = '321187995bc7cdc2b5fc91b11a96e2baa8602c62'.freeze

        def initialize(username, password, refresh_token)
          @refresh_token = refresh_token
          @username      = username
          @password      = password
          @provider      = 'google'
          @expiry        = 0
        end

        def connect
          return access_token_from_refresh_token if @refresh_token
          logger.debug '[>] Fetching Google access token'

          token_request = perform_request('Token') do
            Gpsoauth::Auth.performMasterLogin(@username, @password, GOOGLE_LOGIN_ANDROID_ID)
          end

          auth_request = perform_request('Auth') do
            Gpsoauth::Auth.performOAuth(@username, token_request['Token'], GOOGLE_LOGIN_ANDROID_ID,
                                        GOOGLE_LOGIN_SERVICE, GOOGLE_LOGIN_APP, GOOGLE_LOGIN_CLIENT_SIG)
          end

          @expiry = auth_request['Expiry'].to_i
          @access_token = auth_request['Auth']
        end

        private

        def access_token_from_refresh_token
          logger.info '[>] Fetching Google access token from refresh token'

          body = {
            grant_type: 'refresh_token',
            redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
            refresh_token: @refresh_token,
            scope: 'email',
            client_secret: 'NCjF1TLi2CcY6t5mt0ZveuL7',
            client_id: '848232511240-73ri3t7plvk96pj4f85uj8otdat2alem.apps.googleusercontent.com',
          }

          resp = HTTPClient.new.post('https://accounts.google.com/o/oauth2/token', body).body
          data = JSON.parse(resp)

          @access_token = data['id_token']
          @expiry = data['expires_in'].to_i + Helpers.fetch_time(ms: false)

          raise 'Invalid refresh token' unless data['id_token']
        end

        def perform_request(method)
          response = yield

          if response['Error'] == 'NeedsBrowser'
            raise Errors::GoogleTwoFactorAuthenticationFailure
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
