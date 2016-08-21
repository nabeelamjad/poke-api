[![Gem Version](https://badge.fury.io/rb/poke-go-api.svg)](https://badge.fury.io/rb/poke-go-api) [![Code Climate](https://codeclimate.com/github/nabeelamjad/poke-api/badges/gpa.svg)](https://codeclimate.com/github/nabeelamjad/poke-api) [![Issue Count](https://codeclimate.com/github/nabeelamjad/poke-api/badges/issue_count.svg)](https://codeclimate.com/github/nabeelamjad/poke-api)
# Poke API - A Ruby API gem for Pokémon GO.
Poke API is a port for Ruby from [pgoapi](https://github.com/tejado/pgoapi) and also allows for any automatic parsing of a requests and responses.

  * Unofficial, please use at your own RISK.
  * Use a throwaway account if possible.

## Features
  * Supports new SIGNATURE generation!
  * Allows you to set optional signature information for every request (``:android_gps_info``, ``:sensor_info``, ``:device_info``,``:activity_status`` and ``:location_fix``)
  * Proxy support!
  * Automatic access token/ticket refresh upon expiry!
  * S2 Geometry cells are now supported (natively)!
  * PTC & Google Authentication supported (use full e-mail address for Google)
  * Google refresh token support
  * Parses geolocation using Geocoder (parses addresses, postcodes, ip addresses, lat/long, etc)
  * Ability to chain requests and receive response in a single call
  * Logger available, you can also specify your own log formatter and/or log level
  * Lots of RPC calls, they are listed under [`lib/poke-api/pogoprotos/pogoprotos_networking_requests.rb`](lib/poke-api/pogoprotos/pogoprotos_networking_requests.rb)

## Installation
You can use bundler and refer directly to this repository
```
gem 'poke-go-api',
    git: "https://github.com/nabeelamjad/poke-api.git",
    tag: '0.2.1'
```

Or, alternatively you can download the repository and run ``gem build poke-api.gemspec`` followed with ``gem install poke-api-0.2.1.gem``

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
2016-08-09T02:54:03+01:00]: INFO  > Poke::API::Client         --: [+] Given location: New York, NY, USA
2016-08-09T02:54:03+01:00]: INFO  > Poke::API::Client         --: [+] Lat/Long: 40.7127837, -74.0059413
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Client         --: [+] Provider access token is valid for 03:00:00
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_HATCHED_EGGS' to RPC request
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Using provider access token
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Executing RPC request
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Response       --: [+] Decoding Main RPC responses
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Response       --: [+] Using auth ticket instead
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Response       --: [+] Decoding Sub RPC responses
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Client         --: [+] Cleaning up RPC requests
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Client         --: [+] Login with PTC Successful
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Client         --: [+] File <<signature>> has been set for signature generation
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_MAP_OBJECTS' to RPC request with ar ents
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_PLAYER' to RPC request
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Adding 'GET_INVENTORY' to RPC request
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Auth::Ticket   --: [+] Auth ticket is valid for 00:30:01
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Signature      --: [+] Loaded Signature module
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::RequestBuilder --: [+] Executing RPC request
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Response       --: [+] Decoding Main RPC responses
2016-08-09T02:54:06+01:00]: INFO  > Poke::API::Response       --: [+] Decoding Sub RPC responses
2016-08-09T02:54:07+01:00]: INFO  > Poke::API::Client         --: [+] Cleaning up RPC requests
<Poke::API::Response:0x000000032f96a0
@request=
 [{:GET_MAP_OBJECTS=>
    {:latitude=>40.7127837,
     :longitude=>-74.0059413,
     :since_timestamp_ms=>
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
     :cell_id=>
      [9926595610352287744,
       9926595612499771392,
       9926595614647255040,
       9926595616794738688,
       9926595618942222336,
       9926595621089705984,
       9926595623237189632,
       9926595625384673280,
       9926595627532156928,
       9926595629679640576,
       9926595631827124224,
       9926595633974607872,
       9926595636122091520,
       9926595638269575168,
       9926595640417058816,
       9926595642564542464,
       9926595644712026112,
       9926595646859509760,
       9926595649006993408,
       9926595651154477056,
       9926595653301960704]}},
  :GET_PLAYER,
  :GET_INVENTORY],
@response=
 {:GET_MAP_OBJECTS=>
   {:map_cells=>
     [{:s2_cell_id=>9926595631827124224,
       :current_timestamp_ms=>1470707648730,
       :forts=>
        [{:id=>"44a31b1c990547f49537ca74617bf557.12",
          :last_modified_timestamp_ms=>1470707647002,
          :latitude=>40.712891,
          :longitude=>-74.004869,
          :owned_by_team=>:BLUE,
          :guard_pokemon_id=>:GYARADOS,
          :guard_pokemon_cp=>0,
          :enabled=>true,
          :type=>:GYM,
          :gym_points=>1604,
          :is_in_battle=>true,
          :active_fort_modifier=>"",
          :lure_info=>nil,
          :cooldown_complete_timestamp_ms=>0,
          :sponsor=>:UNSET_SPONSOR,
          :rendering_type=>:DEFAULT},
          ...
```

# RPC call requests and responses
An RPC request can be made on its own or with multiple calls, it also provides the ability to specify arguments. You can find all the supported requests in [`lib/poke-api/pogoprotos/pogoprotos_networking_requests.rb`](lib/poke-api/pogoprotos/pogoprotos_networking_requests.rb). Please note that you will need to check if any of these requests require arguments, these can be found in [`lib/poke-api/pogoprotos/pogoprotos_networking_requests_messages.rb`](lib/poke-api/pogoprotos/pogoprotos_networking_requests_messages.rb) using the same naming convention.

**Let's assume we want to delete a few great balls from our inventory**  
If you open [**`Requests`**](lib/poke-api/pogoprotos/pogoprotos_networking_requests.rb) we can see that there's an entry for `:RECYCLE_INVENTORY_ITEM`. We now know that our call is ``recycle_inventory_item``, next we have to find out if there're any arguments to this call. We can find any possible arguments inside [**`Messages`**](lib/poke-api/pogoprotos/pogoprotos_networking_requests_messages.rb) for our call. This shows two argments: ``item_id`` and ``count``. Furthermore we can see that ``item_id`` directly links to [**`POGOProtos.Inventory.Item.ItemId`**](lib/poke-api/pogoprotos/pogoprotos_inventory_item.rb), this is a file you can open as well with the item ids specified inside. In here we can see the Item ID for a great ball is 2.

Our example request could be as follows:
```ruby
require 'poke-api'

# Instantiate our client
client = Poke::API::Client.new

# Both PTC/Google available as authentication provider
client.store_location('New York')
client.login('username@gmail.com', 'password', 'google')

# Activate the encryption method to generate a signature (only required for map objects)
client.activate_signature('/path/to/encrypt/file')

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
# Optional Signature Information
You can specify ``:android_gps_info``, ``:sensor_info``, ``:device_info``,``:activity_status`` and ``:location_fix`` for every request that is made. Here's an example how this is possible:

```ruby
require 'poke-api'

client = Poke::API::Client.new
client.activate_signature('/path/to/encrypt/file')
client.store_location('New York')
client.login('username', 'password', 'ptc')

# Set your optional requests here
client.location_fix = {provider: 'foo'}
client.android_gps_info = {satellites_prn: [1]}
client.sensor_info = {magnetometer_x: 1.2}
client.device_info = {device_model: 'some-device'}
client.activity_status = {cycling: false}

cell_ids = Poke::API::Helpers.get_cells(client.lat, client.lng)

client.get_map_objects(
  latitude: client.lat,
  longitude: client.lng,
  since_timestamp_ms: [0] * cell_ids.length,
  cell_id: cell_ids
)

client.call
```
Please refer to [**`networking_envelopes`**](lib/poke-api/pogoprotos/pogoprotos_networking_envelopes.rb) for more information as to which arguments are supported.
# Google Refresh Token
A Google refresh token can be set on ``Poke::API::Client``, this token will automatically be used first to generate an access token if available. You do not need to pass in any username or password if you provide a refresh token. To support backwards compatibility you will still have to call ``client.login('', '', 'google')``, however, you can leave the username and password as blank strings instead.

```ruby
require 'poke-api'

client = Poke::API::Client.new
client.refresh_token = 'my-refresh-token'
client.login('', '', 'google')
```

In a future revamp release the ``login`` method will change to accept keyword arguments such as ``client.login(provider: 'google')`` allowing you to ignore the rest.

To generate a Google refresh token please have a look at [**this issue**](https://github.com/nabeelamjad/poke-api/issues/26#issuecomment-237404470), a refresh token will last indefinitely.

# Proxy support
If you wish to use a proxy then you can do so by providing your own ``HTTPClient`` instantation with your preferred setup to ``Poke::API::Client`` using ``http_client`` setter/getter.

```ruby
require 'poke-api'

client = Poke::API::Client.new
client.http_client = HTTPClient.new('http://localhost:8080')
client.http_client.set_proxy_auth(user, password)
...
# Proceed as normal
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

client = Poke::API::Client.new
client.store_location('New York')

[2016-08-09T02:52:10+01:00]: INFO  > Poke::API::Client         --: [+] Given location: New York, NY, USA
[2016-08-09T02:52:10+01:00]: INFO  > Poke::API::Client         --: [+] Lat/Long: 40.7127837, -74.0059413

Poke::API::Helpers.get_cells(client.lat, client.lng)
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
