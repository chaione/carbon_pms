require 'carbon_pms/version'
require 'carbon_pms/client'

module CarbonPms
  class << self
    attr_accessor :host, :auth_token, :version

    # config/initializers/carbon_pms.rb (for instance)
    #
    # CarbonPms.configure do |config|
    #   config.host = 'example.com'
    #   config.auth_token = 'abcdef'
    #   config.version = '42'
    # end
    #
    # elsewhere
    #
    # client = CarbonPms::Client.new
    def configure
      yield self
      true
    end
  end
end
