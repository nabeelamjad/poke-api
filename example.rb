require 'poke-api'
require 'pp'

# Instantiate the client
client = Poke::API::Client.new

# Use Google auth with 'username@gmail.com', 'password', 'google'
client.store_location('New York')
client.login('username', 'password', 'ptc')

# Activate the encryption method to generate a signature
# Where path is the path to your encrypt .so/.dll
client.activate_signature('lib/poke-api/encrypt64bit.dll')

# Get cells
cell_ids = Poke::API::Helpers.get_cells(client.lat, client.lng)

# Construct map objects call
client.get_map_objects(
  latitude: client.lat,
  longitude: client.lng,
  since_timestamp_ms: [0] * cell_ids.length,
  cell_id: cell_ids
)

# Add more calls
client.get_player
client.get_inventory

# Call and view response
resp = client.call
pp resp
