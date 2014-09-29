KerbalStuff API Wrapper for Ruby
==============

A simple Ruby API Wrapper for KerbalStuff


## Gem Status
[![Gem Version](https://badge.fury.io/rb/KerbalStuff.png)](http://badge.fury.io/rb/KerbalStuff)


## Install

You can install the gem like this:

    gem install kerbalstuff
  
    
## Updating

When a new update is released, you can update your gem like this:

    gem update kerbalstuff
    
    
## Examples

Here are some examples of how you can use the wrapper.

```ruby
require 'kerbalstuff' # Require the Gem
```

```ruby
ks = KerbalStuff # Initialize the wrapper

ks.search_mod(string) # returns an array containing Mod objects.
ks.search_user(string) # returns an array containing User objects.

ks.get_mod(integer) # returns a Mod object containing the information about the mod.
ks.get_user(string) # returns a User object containing the information about the user.

ks.get_latest_mod_version(integer) # retuns a ModVersion object containing information about the version.

```

## Documentation
For a *slightly* more detailed version of the gem's methods, take a look [here](http://rubydoc.info/gems/KerbalStuff/).


## License

licensed under MIT License Copyright (c) 2014 Alexandre Oliveira. See LICENSE for further details.


## Contributing

If you want to contribute, feel free to do so! 
Just fork the repo, make your changes, and then submit the pull-request.
