Changelog
------------------

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
