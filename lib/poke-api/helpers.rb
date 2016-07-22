require 'geocoder'

module Poke
  module API
    class Helpers
      class << self
        def get_position(pos)
          Geocoder.search(pos)
        end

        def float_to_int(floats)
          floats.pack('D*').unpack('Q*')
        end

        def camel_case_lower(sym)
          sym.to_s.split('_').collect(&:capitalize).join
        end
      end
    end
  end
end
