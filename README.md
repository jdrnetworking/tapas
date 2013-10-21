# Tapas

Tapas downloads the latest RubyTapas episode, episodes by number, and episodes matching a given search.

## Installation

    $ gem install tapas

## Usage

    tapas             # Download the latest episode

    tapas -e 100      # Download episode 100

    tapas -e 100-105  # Download episodes 100 through 105

    tapas -t foo      # Download episodes with title containing 'foo'

    tapas -l -t foo   # List (don't download) episodes with title containing 'foo'

    tapas -h          # Show options


## Configuration Options

The default configuration file is `~/.tapas` and is of the format:

    setting: value
    setting: value

The following options are supported (default value):

- username
- password
- feed_url (https://rubytapas.dpdcart.com/feed)
- feed_file # local feed - will override feed_url if set
- destination (.)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

&copy; 2013 jdrNetworking, LLC
