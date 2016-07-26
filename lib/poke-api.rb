# Load Poke-API related classes
require 'poke-api/logging'
require 'poke-api/client'
require 'poke-api/helpers'
require 'poke-api/request_builder'
require 'poke-api/response'
require 'poke-api/errors'
require 'poke-api/version'
require 'poke-api/auth/ptc'
require 'poke-api/auth/google'

# Load Google Generated POGOProtos
require 'poke-api/POGOProtos/Networking/Envelopes/RequestEnvelope'
require 'poke-api/POGOProtos/Networking/Envelopes/ResponseEnvelope'
