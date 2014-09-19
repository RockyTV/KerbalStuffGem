KerbalStuff API Wrapper for Ruby
==============

A simple Ruby API Wrapper for KerbalStuff


## Gem Status
[![Gem Version](https://badge.fury.io/rb/KerbalStuff.png)](http://badge.fury.io/rb/KerbalStuff)


## Install

You can install the gem like this:

    gem install kerbalstuff
  
    
## Examples

Here are some examples of how you can use the wrapper.

```ruby
require 'kerbalstuff' # Require the Gem
```

```ruby
ks = KerbalStuff # Initialize the wrapper

ks.SearchMod(string) # will return a hash containing the search results
ks.SearchUser(string)
ks.User(string) # will return a hash containing information about the specified user
ks.Mod(integer) # will return a hash containing information about the specified mod
ks.GetLatestVersion(integer) # will return a hash containing information about the last version released for the specified mod.
ks.GetBasicModInfo(integer) # will return a hash containing basic information about the mod - name, author, downloads, url, latest version
ks.GetBasicUserInfo(integer) # will return a hash containing basic information about the user - name, mods, irc nick, forum nick.
```

## Documentation
For a *slightly* more detailed version of the gem's methods, take a look [here](http://rubydoc.info/gems/KerbalStuff/0.1.2/frames).


## License

licensed under MIT License Copyright (c) 2008  Scott Chacon. See LICENSE for further details.


## Contributing

If you want to contribute, feel free to do so! 
Just fork the repo, make your changes, and then submit the pull-request.
