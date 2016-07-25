require 'poke-api'
require 'pp'

client = Poke::API::Client.new

# use Google auth with 'username@gmail.com', 'password', 'google'
client.login('username', 'password', 'ptc')
client.store_location('New York')

# Please see [this comment](https://github.com/nabeelamjad/poke-api/issues/2#issuecomment-234742928) 
# on how to obtain cell_ids for a given location and optionally 
# enter a radius (defaults to 10 to your given location).
client.get_map_objects(
  latitude: client.lat,
  longitude: client.lng,
  since_timestamp_ms: [0],
  cell_id: [9926595610352287744]
)

client.get_player
client.get_inventory

pp client.call
