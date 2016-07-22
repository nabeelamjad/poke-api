require 'json'
require 'httpclient'

module Poke
  module API
    module Auth
      class PTC
        include Logging
        attr_reader :access_token, :provider

        PTC_LOGIN_URL = 'https://sso.pokemon.com/sso/login?service=https%3A%2F%2Fsso.pokemon.com' \
                        '%2Fsso%2Foauth2.0%2FcallbackAuthorize'
        PTC_LOGIN_OAUTH = 'https://sso.pokemon.com/sso/oauth2.0/accessToken'
        PTC_LOGIN_CLIENT_SECRET = 'w8ScCUXJQc6kXKw8FiOhd8Fixzht18Dq3PEVkUCP5ZPxtgyWsbTvWHFLm2wNY0JR'

        def initialize(username, password)
          @username = username
          @password = password
          @provider = 'ptc'
          @client   = HTTPClient.new(agent_name: 'PokeAPI/0.0.1')
        end

        def connect
          resp = @client.get_content(PTC_LOGIN_URL)
          parsed_resp = JSON.parse(resp)

          data = {
            username: @username,
            password: @password,
            _eventId: 'submit',
            lt: parsed_resp['lt'],
            execution: parsed_resp['execution']
          }

          fetch_ticket(data)
        end

        private

        def fetch_ticket(data)
          logger.debug '[>] Fetching PTC ticket'

          ticket = begin
            @client.post_content(PTC_LOGIN_URL, data)
          rescue StandardError => ex
            ex.res.http_header.request_uri.to_s.match(/ticket=(.*)/)[1]
          end

          fetch_access_token(ticket)
        end

        def fetch_access_token(ticket)
          logger.debug '[>] Fetching PTC access token'

          data = {
            client_id: 'mobile-app_pokemon-go',
            redirect_uri: 'https://www.nianticlabs.com/pokemongo/error',
            client_secret: PTC_LOGIN_CLIENT_SECRET,
            grant_type: 'refresh_token',
            code: ticket
          }

          @access_token = @client.post(PTC_LOGIN_OAUTH, data).body
                                 .match(/access_token=(.*)&expires/)[1]
        end
      end
    end
  end
end
