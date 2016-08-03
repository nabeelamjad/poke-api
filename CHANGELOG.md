Changelog
------------------

0.0.8 (03-08-2016)
------------------
* **Fix** - Ensure the endpoint is constantly updated if a new one is provided

0.0.7 (01-08-2016)
------------------
* **Fix** - Fix an issue whereby the @endpoint address was overwritten to an empty string on a failed login attempt
* **Feature** - A new function ``store_lat_lng`` is provided to store a latitude and longitude directly (without requiring Geocoder to look up)

0.0.6 (31-07-2016)
------------------
* **Fix** - Merged [PR](https://github.com/nabeelamjad/poke-api/pull/19) to fix upcase! and add additional error handling for Google

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
