require 'geocoder'
require 'ruby-xxhash'

module Poke
  module API
    class Helpers
      class << self
        def get_position(pos)
          Geocoder.search(pos)
        end

        def camel_case_lower(sym)
          sym.to_s.split('_').collect(&:capitalize).join
        end

        def generate_location_one(auth_ticket, pos)
          first_hash = XXhash.xxh32(auth_ticket, 0x1B845238)
          location_bytes = d2h(pos[0]) + d2h(pos[1]) + d2h(pos[2])

          XXhash.xxh32(location_bytes, first_hash)
        end

        def generate_location_two(pos)
          location_bytes = d2h(pos[0]) + d2h(pos[1]) + d2h(pos[2])

          XXhash.xxh32(location_bytes, seed=0x1B845238)
        end 

        def generate_request(auth_ticket, request)
          first_hash = XXhash.xxh64(auth_ticket, 0x1B845238)

          XXhash.xxh64(request, first_hash)
        end

        def d2h(input)
          [input].pack('d').unpack('Q').first.to_s(16).split.pack('H*')
        end
      end
    end
  end
end
