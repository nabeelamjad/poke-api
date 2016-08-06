module Poke
  module API
    module Geometry
      class S2LatLon
        def initialize(lat_degrees, lon_degrees)
          @lat = lat_degrees * Math::PI / 180
          @lon = lon_degrees * Math::PI / 180
        end

        def to_point
          phi    = @lat
          theta  = @lon
          cosphi = Math.cos(phi)
          S2Point.new(Math.cos(theta) * cosphi, Math.sin(theta) * cosphi, Math.sin(phi))
        end
      end
    end
  end
end
