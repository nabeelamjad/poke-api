require 'poke-api'
require 'pp'

client = Poke::API::Client.new
client.login('username', 'password', 'ptc')
client.store_location('New York')

client.get_map_objects(
  latitude: client.lat,
  longitude: client.lng,
  since_timestamp_ms: [0],
  cell_id: [9926595610352287744]
)

client.get_player
client.get_inventory

pp client.call
