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

        def fetch_time(ms: true)
          ms ? (Time.now.to_f * 1000).to_i : Time.now.to_i
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

        def format_time_diff(low, high, ms = true)
          diff = high - low
          m, s = ms ? (diff / 1000).divmod(60) : diff.divmod(60)
          m.divmod(60) + [s]
        end

        def get_cells(lat, lng, radius = 10)
          s2_point = Poke::API::Geometry::S2LatLon.new(lat, lng).to_point
          s2_cell  = Poke::API::Geometry::S2CellId.from_point(s2_point).parent(15)

          next_cell = s2_cell.next
          prev_cell = s2_cell.prev

          radius.times.reduce([s2_cell.id]) do |acc, el|
            acc += [next_cell.id, prev_cell.id]
            next_cell = next_cell.next
            prev_cell = prev_cell.prev
            acc
          end.sort
        end
      end
    end
  end
end
