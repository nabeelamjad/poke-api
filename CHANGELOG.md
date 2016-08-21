Changelog
------------------
0.2.1 (21-08-2016)
------------------
* **Revert** - Initial ticket is reverted back to ``get_hatched_eggs`` as Niantic may detect someone constantly accepting TOS whereas this is only possible once in game. Accepting TOS is out of bounds for the API client (however it is possible to add the request for TOS before logging in as per usual methods)

0.2.0 (21-08-2016)
------------------
* **Fix** - Fixed an issue whereby ``to_h`` was called causing Ruby 2.0.0 to not work. 
* **Change** - The initial ticket will always request to mark tutorial as complete (this supports new PTC accounts out of the box without accepting TOS)
* **Feature** - You can now provide the following optional information in the client constructor: ``:android_gps_info``, ``:sensor_info``, ``:device_info``,``:activity_status`` and ``:location_fix``

0.1.7 (10-08-2016)
------------------
* **Feature** - You can now provide a ``HTTPClient`` instantation for proxy purposes 
* **Feature** - A Google refresh token can now be set using ``refresh_token`` setter method (i.e. ``client.refresh_token = 'my_refresh_token'``). The refresh token will always be used first (you can leave out the username and password as empty strings)

0.1.5 (09-08-2016)
------------------
* **Feature** - Access tokens and authentication tickets will automatically refresh upon expiry
* **Feature** - S2 Geometry cell has been added to the helper method ``Poke::API::Helpers.get_cells(...)``
* **New Protobufs** - Protocol Buffers have been updated to the latest version and minified as possible

0.1.1 (08-08-2016)
------------------
* **Fix** - Fixed an issue whereby path was incorrectly referenced as a variable
* **Change** - FFI is no longer required, built-in Ruby's Fiddle is used instead (and appears more reliable)

0.1.0 (07-08-2016)
------------------
* **Fix** - Include the new signature generation, requires your own encrypt file (dll/so)
* **Feature** - Classes have been added to generate S2 Cell Ids in native Ruby (no external libraries), this covers the base S2 features and may not include advanced methods yet.

0.0.8 (03-08-2016)
------------------
* **Fix** - Ensure the endpoint is constantly updated if a new one is provided

0.0.7 (01-08-2016)
------------------
* **Fix** - Fix an issue whereby the @endpoint address was overwritten to an empty string on a failed login attempt
* **Feature** - A new function ``store_lat_lng`` is provided to store a latitude and longitude directly (without requiring Geocoder to look up)

0.0.6 (31-07-2016)
------------------
* **Fix** - Merged [PR](https://github.com/nabeelamjad/poke-api/pull/19) to fix upcase! and added additional error handling for Google

0.0.5 (30-07-2016)
------------------
* **Fix** - An issue with upcase! was resolved as described by [this PR](https://github.com/nabeelamjad/poke-api/pull/18)

0.0.4 (27-07-2016)
------------------
* **Fix** - GPSOAuth has been updated so that older versions of Ruby do not break when using Google login
* **Feature** - Response now returns two additional messages for ``status_code`` and ``error`
  * *status_code*: indicates the response status code 
  * *error*: returns the error or an empty string

0.0.3 (27-07-2016)
------------------
* **New Protobufs** - Protobufs have been updated to commit [`b2c48b17b`](https://github.com/AeonLucid/POGOProtos/tree/b2c48b17b560dc3d259d50a8afa1ef4199170bc4)

0.0.2 (25-07-2016)
------------------

* **Feature** - Google Login is now supported 
* **GetMapObjects** - A workaround has been added to README on how to obtain these using Ruby and Python together and it also documented in [**`example.rb`**](example.rb).


0.0.1 (22-07-2016)
------------------

* Initial release of an API library gem for Pokémon GO.
