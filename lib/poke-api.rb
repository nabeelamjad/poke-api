# Load main Poke::API related classes
require 'poke-api/logging'
require 'poke-api/client'
require 'poke-api/helpers'
require 'poke-api/request_builder'
require 'poke-api/response'
require 'poke-api/errors'
require 'poke-api/version'
require 'poke-api/auth/ptc'
require 'poke-api/auth/google'

# Load Geometry libraries (native Ruby)
require 'poke-api/geometry/s2_base'
require 'poke-api/geometry/s2_cell_id'
require 'poke-api/geometry/s2_lat_lon'
require 'poke-api/geometry/s2_point'

# Load Google Generated POGOProtos
require 'poke-api/POGOProtos/Networking/Envelopes/RequestEnvelope'
require 'poke-api/POGOProtos/Networking/Envelopes/ResponseEnvelope'
