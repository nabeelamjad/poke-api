require 'pp'
require 'poke-api'

def generate_spiral(starting_lat, starting_lng, step_size, step_limit)
  coords = [{ lat: starting_lat, lng: starting_lng }]
  steps = 1
  x = 0
  y = 0
  d = 1
  m = 1
  rlow = 0.0
  rhigh = 0.0005

  while steps < step_limit
    while 2 * x * d < m && steps < step_limit
      x += d
      steps += 1
      lat = x * step_size + starting_lat + rand * ((rlow - rhigh) + rlow)
      lng = y * step_size + starting_lng + rand * ((rlow - rhigh) + rlow)
      coords << { lat: lat, lng: lng }
    end
    while 2 * y * d < m && steps < step_limit
      y += d
      steps += 1
      lat = x * step_size + starting_lat + rand * ((rlow - rhigh) + rlow)
      lng = y * step_size + starting_lng + rand * ((rlow - rhigh) + rlow)
      coords << { lat: lat, lng: lng }
    end

    d = -1 * d
    m += 1
  end

  coords
end

def print_google_maps_path(coords)
  url_string = 'http://maps.googleapis.com/maps/api/staticmap?size=400x400&path='
  coords.each { |c| url_string += "#{c[:lat]},#{c[:lng]}|" }

  path = HTTPClient.new.get("http://tinyurl.com/api-create.php?url=#{url_string[0..-2]}").body
  puts "Spiral path on Google Maps: #{path}"
end

def find_poi(client, lat, lng)
  step_size = 0.0015
  step_limit = 49

  coords = generate_spiral(lat, lng, step_size, step_limit)
  print_google_maps_path(coords)

  pokemon_data = {}

  coords.each do |coord|
    lat = coord[:lat]
    lng = coord[:lng]
    client.store_lat_lng(lat, lng)

    cell_ids = Poke::API::Helpers.get_cells(lat, lng)

    client.get_map_objects(
      latitude: client.lat,
      longitude: client.lng,
      since_timestamp_ms: [0] * cell_ids.length,
      cell_id: cell_ids
    )

    resp = client.call
    puts "\nSearching at lat: #{lat} lng: #{lng}"

    if resp.response[:GET_MAP_OBJECTS] && resp.response[:GET_MAP_OBJECTS][:map_cells]
      wild_pokemons = resp.response[:GET_MAP_OBJECTS][:map_cells].map { |x| x[:wild_pokemons] }.flatten
      wild_pokemons.each do |pokemon|
        poke_data = {
          'name' => pokemon[:pokemon_data][:pokemon_id],
          'lat' => pokemon[:latitude],
          'lng' => pokemon[:longitude],
          'time_stamp' => pokemon[:last_modified_timestamp_ms],
          'time_left' => pokemon[:time_till_hidden_ms] / 1000
        }

        # Don't show the same pokemon again
        unless pokemon_data[pokemon[:encounter_id]]
          puts ''
          pp poke_data
        end

        pokemon_data[pokemon[:encounter_id]] = poke_data
      end
    end

    # Save our data somewhere
    File.open('pokemon_data.json', 'w') { |f| f.write JSON.pretty_generate(pokemon_data) }
    sleep 5
  end
end

# Disable logging as it'll just be spammy
Poke::API::Logging.log_level = :UNKNOWN

# Instatiate our client
client = Poke::API::Client.new

# Set our location
client.store_location('New York')

# Login
client.login('username', 'password', 'ptc')

# Active signature as required for map_objects
client.activate_signature('/path/to/encrypt/file')

# Start spiral search
find_poi(client, client.lat, client.lng)

# You can implement your own logic to split each iteration of
#  coords into its own thread using multiple logins with multi
#  threading. You would need to utilize Mutex to ensure the data
#  is thread-safe. A database can also be implemented instead of
#  using a file to read/write from.
