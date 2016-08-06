module Poke
  module API
    module Geometry
      class S2Point
        attr_reader :x, :y, :z

        def initialize(x, y, z)
          @x = x
          @y = y
          @z = z
        end

        def abs
          [@x.abs, @y.abs, @z.abs]
        end

        def largest_abs_component
          temp = abs

          if temp[0] > temp[1]
            temp[0] > temp[2] ? 0 : 2
          else
            temp[1] > temp[2] ? 1 : 2
          end
        end

        def dot_prod(o)
          @x * o.x + @y * o.y + @z * o.z
        end
      end
    end
  end
end
