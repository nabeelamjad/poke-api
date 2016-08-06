[![Gem Version](https://badge.fury.io/rb/poke-go-api.svg)](https://badge.fury.io/rb/poke-go-api) [![Code Climate](https://codeclimate.com/github/nabeelamjad/poke-api/badges/gpa.svg)](https://codeclimate.com/github/nabeelamjad/poke-api) [![Issue Count](https://codeclimate.com/github/nabeelamjad/poke-api/badges/issue_count.svg)](https://codeclimate.com/github/nabeelamjad/poke-api)
# Poke API - A Ruby API gem for Pokémon GO.
Poke API is a port for Ruby from [pgoapi](https://github.com/tejado/pgoapi) and also allows for any automatic parsing of a requests and responses.

  * Unofficial, please use at your own RISK.
  * Use a throwaway account if possible.

## Supports
  * S2 Geometry cells!
  * PTC & Google Authentication supported (use full e-mail address for Google)
  * Parses geolocation using Geocoder (parses addresses, postcodes, ip addresses, lat/long, etc)
  * Ability to chain requests and receive response in a single call
  * Logger available, you can also specify your own log formatter and/or log level
  * Lots of RPC calls, they are listed under [`lib/poke-api/POGOProtos/Networking/Requests/RequestType.rb`](lib/poke-api/POGOProtos/Networking/Requests/RequestType.rb)

## Installation
You can use bundler and refer directly to this repository
```
gem 'poke-go-api',
    git: "https://github.com/nabeelamjad/poke-api.git",
    tag: '0.1.0'
```

Or, alternatively you can download the repository and run ``gem build poke-api.gemspec`` followed with ``gem install poke-api-0.1.0.gem``

The gem is also available by using ``gem install poke-go-api`` (poke-api was taken as a name already).

**NOTE** - This gem relies on header files for Ruby to install the ``google-protobuf`` gem.
  * Windows: You will need the Ruby DevKit applied to your Ruby, please see [RubyInstaller](http://rubyinstaller.org/downloads/)
  * Linux:
     * Debian based: ``sudo apt-get install ruby-dev``
     * RPM based: ``sudo yum install ruby-devel``
     * SuSe based: ``sudo zypper install ruby-devel``

## Example Usage
Running provided ``example.rb`` with your own credentials
```ruby
[2016-07-22T00:06:08+00:00]: INFO  > Poke::API::Client         --: [+] Logging in user: <your_user>
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Client         --: [+] Login Successful
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_PLAYER' to RPC request
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_HATCHED_EGGS' to RPC request
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_INVENTORY' to RPC request
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'CHECK_AWARDED_BADGES' to RPC request
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'DOWNLOAD_SETTINGS' to RPC request with arguments
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Executing RPC request
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Response       --: [+] Decoding Main RPC responses
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Response       --: [+] Decoding Sub RPC responses
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Client         --: [+] Cleaning up RPC requests
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Client         --: [+] Given location: New York, NY, USA
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Client         --: [+] Lat/Long: 40.7127837, -74.0059413
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_MAP_OBJECTS' to RPC request with arguments
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::RequestBuilder --: [+] Executing RPC request
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Response       --: [+] Decoding Main RPC responses
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Response       --: [+] Decoding Sub RPC responses
[2016-07-22T00:06:09+00:00]: INFO  > Poke::API::Client         --: [+] Cleaning up RPC requests
{:GET_MAP_OBJECTS=>
  {:map_cells=>
    [{:s2_cell_id=>9926595610352287744,
      :current_timestamp_ms=>1469145969687,
      :forts=>
       [{:id=>"1a080ce7d62c464da0ab6c7c4f3eb1cb.16",
         :last_modified_timestamp_ms=>1469143005205,
         :latitude=>40.717921,
         :longitude=>-74.015862,
         :owned_by_team=>:NEUTRAL,
         :guard_pokemon_id=>:MISSINGNO,
         :guard_pokemon_cp=>0,
         :enabled=>true,
         :type=>:CHECKPOINT,
         :gym_points=>0,
         :is_in_battle=>false,
         :active_fort_modifier=>"",
         :lure_info=>nil,
         :cooldown_complete_timestamp_ms=>0,
         :sponsor=>:UNSET_SPONSOR,
         :rendering_type=>:DEFAULT}],
      :spawn_points=>
       [{:latitude=>40.71796568193216, :longitude=>-74.01601166049142},
        {:latitude=>40.71791521124943, :longitude=>-74.01674614317368},
        {:latitude=>40.718068159209885, :longitude=>-74.01564441809084}],
      :wild_pokemons=>[],
      :deleted_objects=>[],
      :is_truncated_list=>false,
      :fort_summaries=>[],
      :decimated_spawn_points=>[],
      :catchable_pokemons=>[],
      :nearby_pokemons=>[]}],
   :status=>:SUCCESS}}
```

# RPC call requests and responses
An RPC request can be made on its own or with multiple calls, it also provides the ability to specify arguments. You can find all the supported requests under [`lib/poke-api/POGOProtos/Networking/Requests/RequestType.rb`](lib/poke-api/POGOProtos/Networking/Requests/RequestType.rb). Please note that you will need to check if any of these requests require arguments, these can be found under the folder [`lib/poke-api/POGOProtos/Networking/Requests/Messages`](lib/poke-api/POGOProtos/Networking/Requests/Messages) using the same naming convention.

**Let's assume we want to delete a few great balls from our inventory**  
If you open [**`RequestType.rb`**](lib/poke-api/POGOProtos/Networking/Requests/RequestType.rb) we can see that there's an entry for `:RECYCLE_INVENTORY_ITEM`. We now know that our call is ``recycle_inventory_item``, next we have to find out if there're any arguments to this call. We can find any arguments inside the [**`Messages`**](lib/poke-api/POGOProtos/Networking/Requests/Messages) folder, we see a file named [**`RecycleInventoryItemMessage.rb`**](lib/poke-api/POGOProtos/Networking/Requests/Messages/RecycleInventoryItemMessage.rb) which contains two arguments: ``item_id`` and ``count``. Furthermore we can see that ``item_id`` directly links to [**`POGOProtos.Inventory.Item.ItemId`**](lib/poke-api/POGOProtos/Inventory/Item/ItemId.rb), this is a file you can open as well with the item ids specified inside. In here we can see the Item ID for a great ball is 2.

Our example request could be as follows:
```ruby
require 'poke-api'

# Instantiate our client
client = Poke::API::Client.new

# Both PTC/Google available as authentication provider
client.store_location('New York')
client.login('username@gmail.com', 'password', 'google')

# Add RPC calls
client.recycle_inventory_item(item_id: 2, count: 2)

# You can inspect the client before performing the call
puts client.inspect
=> #<Poke::API::Client @auth=#<Poke::API::Auth::GOOGLE> @reqs=[{:RECYCLE_INVENTORY_ITEM=>{:item_id=>2, :count=>2}}] @lat=4630926632231391130 @lng=13858280158942612615 @alt=0>

# Perform your RPC call
call = client.call

# A <Poke::API::Response> object is returned and decorated with your request and response in a Hash format
# Request
puts call.request.inspect
[
  {
    :RECYCLE_INVENTORY_ITEM => {
      :item_id=>2,
      :count=>2
    }
  }
]

# Response
puts call.response.inspect
{
  :RECYCLE_INVENTORY_ITEM = >{
    :result=>:SUCCESS, 
    :new_count=>14
  },
  :status_code => 1,
  :api_url => "",
  :error => ""
}
```

# Logger settings
If you wish to change the log level you can do so before instantiating the client by using ``Poke::API::Logging.log_level = :INFO`` where ``:INFO`` is the desired level, possible values are: ``:DEBUG``, ``:INFO``, ``:WARN``, ``:FATAL`` and ``UNKNOWN``

The log formatter format can also be customised, a default one is provided. You can provide a ``proc`` to ``Poke::API::Logging.formatter`` to change it. More information can be found at [`Class#Logger`](http://ruby-doc.org/stdlib-2.3.1/libdoc/logger/rdoc/Logger.html)

Example:
```ruby
require 'poke-api'

# Use :DEBUG for extra verbosity if required to troubleshoot
Poke::API::Logging.log_level = :DEBUG
Poke::API::Logging.formatter = proc do |severity, datetime, progname, msg|
  "My custom logger - #{msg}\n"
end

client = Poke::API::Client.new
client.store_location('London')
#=> My custom logger - [+] Given location: London, UK
#=> My custom logger - [+] Lat/Long: 51.5073509, -0.1277583
```

# Generating S2 Cell Ids
You can use this helper method to generate cells, please note that not all S2 Geometry calls are supported as this has been ported over to native Ruby (without binding). Available instance methods on a **``S2CellId``** are ``parent``, ``level``, ``next`` and ``prev``.

#### Example Usage
```ruby
require 'poke-api'

def get_cells(lat, lng, radius = 10)
  s2_point = Poke::API::Geometry::S2LatLon.new(lat, lng).to_point
  s2_cell  = Poke::API::Geometry::S2CellId.from_point(s2_point).parent(15)

  next_cell = s2_cell.next
  prev_cell = s2_cell.prev

  radius.times.reduce([s2_cell.id]) do |acc, el|
    acc += [next_cell.id, prev_cell.id]
    next_cell = next_cell.next
    prev_cell = prev_cell.prev
    acc
  end.sort
end

client = Poke::API::Client.new
client.store_location('New York')

get_cells(client.lat, client.lng)
=> [9926595610352287744, 9926595612499771392, 9926595614647255040,
    9926595616794738688, 9926595618942222336, 9926595621089705984,
    9926595623237189632, 9926595625384673280, 9926595627532156928, 
    9926595629679640576, 9926595631827124224, 9926595633974607872, 
    9926595636122091520, 9926595638269575168, 9926595640417058816, 
    9926595642564542464, 9926595644712026112, 9926595646859509760, 
    9926595649006993408, 9926595651154477056, 9926595653301960704]
```

# Contribution
Any contributions are most welcome, I don't have much time to spend on this project so I appreciate everything.

# Credits
[tejado](https://github.com/tejado/pgoapi) - Pretty much everything as this repository is a direct 'conversion' to the best of my ability  
[AeonLucid](https://github.com/AeonLucid/POGOProtos) - Protobufs  
[xssc](https://github.com/xssc/gpsoauth) - GPSOauth (Google Login)
