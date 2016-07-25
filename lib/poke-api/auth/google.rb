require 'gpsoauth'

module Poke
  module API
    module Auth
      class GOOGLE
        include Logging
        attr_reader :access_token, :provider

        GOOGLE_LOGIN_ANDROID_ID = '9774d56d682e549c'
        GOOGLE_LOGIN_SERVICE    = 'audience:server:client_id:848232511240-7so421jotr2609rmqakceuu1luuq0ptb.apps.googleusercontent.com'
        GOOGLE_LOGIN_APP        = 'com.nianticlabs.pokemongo'
        GOOGLE_LOGIN_CLIENT_SIG = '321187995bc7cdc2b5fc91b11a96e2baa8602c62'

        def initialize(username, password)
          @username = username
          @password = password
          @provider = 'google'
        end

        def connect
          logger.debug '[>] Fetching Google access token'
          login = Gpsoauth::Auth.performMasterLogin(@username, @password, GOOGLE_LOGIN_ANDROID_ID)
          login = Gpsoauth::Auth.performOAuth(@username, login['Token'], GOOGLE_LOGIN_ANDROID_ID, GOOGLE_LOGIN_SERVICE, GOOGLE_LOGIN_APP, GOOGLE_LOGIN_CLIENT_SIG)
          @access_token = login['Auth']
          if !@access_token then raise ::StandardError else logger.debug @access_token end
        end
      end
    end
  end
end
