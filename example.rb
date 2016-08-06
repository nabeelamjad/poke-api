require 'poke-api'
require 'pp'

# Instantiate the client
client = Poke::API::Client.new

# Use Google auth with 'username@gmail.com', 'password', 'google'
client.store_location('New York')
client.login('username', 'password', 'ptc')

# Helper method to get cell ids, pass in your
# coordinates and an optional radius (default 10)
def get_cells(lat, lng, radius = 10)
  s2_point = Poke::API::Geometry::S2LatLon.new(lat, lng).to_point
  s2_cell  = Poke::API::Geometry::S2CellId.from_point(s2_point).parent(15)

  next_cell = s2_cell.next
  prev_cell = s2_cell.prev

  radius.times.reduce([s2_cell.id]) do |acc, _|
    acc += [next_cell.id, prev_cell.id]
    next_cell = next_cell.next
    prev_cell = prev_cell.prev
    acc
  end.sort
end

# Get cells
cell_ids = get_cells(client.lat, client.lng)

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
