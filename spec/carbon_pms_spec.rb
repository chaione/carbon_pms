require 'spec_helper'

describe CarbonPms do
  it 'should have a version number' do
    CarbonPms::VERSION.should_not be_nil
  end

  it 'should be able to set its attributes via a configuration block' do
    CarbonPms.configure do |config|
      config.host = 'example.com'
      config.auth_token = 'abcdef'
      config.version = 42
    end
    CarbonPms.host.should == 'example.com'
    CarbonPms.auth_token.should == 'abcdef'
    CarbonPms.version.should == 42
  end
end
