module Poke
  module API
    module Geometry
      class S2CellId
        include S2Base
        attr_reader :id

        def initialize(id)
          @id = id
        end

        def parent(level)
          new_lsb = lsb_for_level(level)
          s2 = S2CellId.new((@id & -new_lsb) | new_lsb)

          raise Errors::InvalidLevel, level unless valid?(s2.id)
          s2
        end

        def prev
          S2CellId.new(@id - (lsb << 1))
        end

        def next
          S2CellId.new(@id + (lsb << 1))
        end

        def level
          return MAX_LEVEL if leaf?

          x = (@id & 0xffffffff)
          level = -1

          if x != 0
            level += 16
          else
            x = ((@id >> 32) & 0xffffffff)
          end

          x &= -x

          level += 8 unless (x & 0x00005555).zero?
          level += 4 unless (x & 0x00550055).zero?
          level += 2 unless (x & 0x05050505).zero?
          level += 1 unless (x & 0x11111111).zero?
          level
        end

        def self.from_point(p)
          face, u, v = xyz_to_face_uv(p)
          i = st_to_ij(uv_to_st(u))
          j = st_to_ij(uv_to_st(v))

          S2CellId.new(from_face_ij(face, i, j))
        end

        def self.from_face_ij(face, i, j)
          n = face << (POS_BITS - 1)
          bits = face & SWAP_MASK

          7.downto(0).each do |k|
            mask = (1 << LOOKUP_BITS) - 1
            bits += (((i >> (k * LOOKUP_BITS)) & mask) << (LOOKUP_BITS + 2))
            bits += (((j >> (k * LOOKUP_BITS)) & mask) << 2)
            bits = LOOKUP_POS[bits]
            n |= (bits >> 2) << (k * 2 * LOOKUP_BITS)
            bits &= (SWAP_MASK | INVERT_MASK)
          end

          @id = (n * 2 + 1)
        end

        def self.xyz_to_face_uv(p)
          face = p.largest_abs_component

          pface = case face
                  when 0 then p.x
                  when 1 then p.y
                  else p.z
                  end

          face += 3 if pface < 0

          u, v = valid_face_xyz_to_uv(face, p)
          [face, u, v]
        end

        def self.uv_to_st(u)
          return 0.5 * Math.sqrt(1 + 3 * u) if u >= 0
          1 - 0.5 * Math.sqrt(1 - 3 * u)
        end

        def self.st_to_ij(s)
          [0, [MAX_SIZE - 1, Integer((MAX_SIZE * s).floor)].min].max
        end

        def self.valid_face_xyz_to_uv(face, p)
          raise unless p.dot_prod(face_uv_to_xyz(face, 0, 0)) > 0

          case face
          when 0 then [p.y / p.x, p.z / p.x]
          when 1 then [-p.x / p.y, p.z / p.y]
          when 2 then [-p.x / p.z, -p.y / p.z]
          when 3 then [p.z / p.x, p.y / p.x]
          when 4 then [p.z / p.y, -p.x / p.y]
          else [-p.y / p.z, -p.x / p.z]
          end
        end

        def self.face_uv_to_xyz(face, u, v)
          case face
          when 0 then S2Point.new(1, u, v)
          when 1 then S2Point.new(-u, 1, v)
          when 2 then S2Point.new(-u, -v, 1)
          when 3 then S2Point.new(-1, -v, -u)
          when 4 then S2Point.new(v, -1, -u)
          else S2Point.new(v, u, -1)
          end
        end

        private_class_method :face_uv_to_xyz, :valid_face_xyz_to_uv, :uv_to_st,
                             :st_to_ij, :xyz_to_face_uv, :from_face_ij

        private

        def leaf?
          @id & 1 != 0
        end

        def valid?(s2_id)
          face = s2_id >> POS_BITS
          lsb = s2_id & -s2_id
          (face < NUM_FACES) && (lsb & 0x1555555555555555) != 0
        end

        def lsb
          @id & -@id
        end

        def lsb_for_level(level)
          1 << (2 * (MAX_LEVEL - level))
        end
      end
    end
  end
end
