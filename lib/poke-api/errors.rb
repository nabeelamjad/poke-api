module Poke
  module API
    class Errors
      class InvalidProvider < StandardError
        def initialize(provider)
          super("Invalid provider #{provider}.")
        end
      end

      class LoginRequired < StandardError
        def initialize
          super('Not logged in currently, please login.')
        end
      end

      class InvalidRequestEntry < StandardError
        def initialize(subreq)
          super("Subrequest entry #{subreq} is invalid.")
        end
      end

      class UnknownProtoFault < StandardError
        def initialize(error)
          super("An unknown proto fault has occured => [#{error} @ #{error.backtrace.first}]")
        end
      end

      class GoogleAuthenticationFailure < StandardError
        def initialize(token, response)
          super("Unable to login to Google, could not find => #{token} in #{response}")
        end
      end

      class LoginFailure < StandardError
        def initialize(provider, error)
          super("Unable to login to #{provider} => [#{error} @ #{error.backtrace.first}]")
        end
      end
    end
  end
end
