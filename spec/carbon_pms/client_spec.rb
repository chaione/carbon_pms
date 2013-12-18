require 'spec_helper'

describe CarbonPms::Client do
  context 'initialization' do
    let(:host) { 'example.com' }
    let(:auth_token) { nil }
    let(:version) { nil }
    let(:client) { CarbonPms::Client.new(host, auth_token, version) }

    context 'defaults' do
      it 'should default to ssl when given a hostname' do
        client.class.base_uri.should == 'https://example.com/api'
      end

      it 'should not have the authorization header set' do
        client.class.headers.should_not have_key('Authorization')
      end

      it 'should not have the version header set' do
        client.class.headers.should_not have_key('Accept')
      end
    end

    context 'custom' do
      let(:host) { 'http://example.com:5000' }
      let(:auth_token) { 'abcdef' }
      let(:version) { 42 }

      it 'should use http if explicitly defined' do
        client.class.base_uri.should == 'http://example.com:5000/api'
      end

      it 'should set the authorization header if given an auth token' do
        client.class.headers['Authorization'].should eq 'token abcdef'
      end

      it 'should set the version header if given a version' do
        client.class.headers['Accept'].should eq 'application/vnd.carbon.pms.v42'
      end
    end
  end
end