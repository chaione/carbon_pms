# CarbonPms

If you're not using a CarbonPMS server, then you don't need this.

## Installation

Add this line to your application's Gemfile:

    gem 'carbon_pms'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carbon_pms

## Usage

    require 'carbon_pms'
    
    client = CarbonPms::Client.new('example.com', 'auth_token', API_VERSION)
    client.create_app(name: 'foo', auth_key: '123123')
    
You can also initialize the client with a configuration block:

    # config/initializers/carbon_pms.rb (for instance)
    CarbonPms.configure do |config|
      config.host = 'example.com'
      config.auth_token = 'abcdef'
      config.version = '42'
    end
    # elsewhere
    client = CarbonPms.Client.new

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
