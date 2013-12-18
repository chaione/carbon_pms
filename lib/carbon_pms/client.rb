require 'httparty'

module CarbonPms
  class Client
    include HTTParty
    format :json

    def initialize(host=CarbonPms.host, auth_token=CarbonPms.auth_token, version=CarbonPms.version)
      if host.downcase.start_with?('http://', 'https://')
        self.class.base_uri "#{host}/api"
      else
        self.class.base_uri "https://#{host}/api"
      end
      self.class.headers('Authorization' => %Q[Token token="#{auth_token}"]) if auth_token
      self.class.headers('Accept' => "application/vnd.carbon.pms.v#{version}") if version
    end

    # Creates either a GCM or APNS app to receive push messages. You must create an app
    # before you can send push notifications.
    #
    # @param [Hash] options hash to construct an app.
    #   Must include :name and (:certificate or :auth_key)
    # @option options [String] :name A name for this app. The name must be unique within the environment and app type
    # @option options [String] :environment can be one of the following:
    #   * _production_
    #   * _development_
    #   * _sandbox_
    #   Defaults to _development_
    # @option options [String] :auth_key Setting this key will create a GCM app. Your Google API key goes here. This option is mutually exclusive with :certificate
    # @option options [String] :certificate Setting this key will create an APNS app. Your certificate needs to be in _pem_ format. This option is mutually exclusive with :auth_key
    # @option options [String] :password The password to decrypt the certificate if it was encrypted.
    # @raise [ArgumentError] if anything is amiss
    # @return [HTTParty::Response] The response from the server. The following properties may be interesting:
    #   * *body* : the parsed response body
    #   * *code* : the status code
    #   * *message* : the status message
    #   * *headers* : the response headers
    def create_app(options={})
      raise ArguementError, 'You must provide an app name' unless options[:name]
      options[:environment] = 'development' unless %w{production sandbox}.include? options[:environment]
      return post('/app/apns', body: options) if options.has_key? :certificate
      return post('/app/gcm', body: options) if options.has_key? :auth_key
      raise ArguementError, 'You must provide a :certificate or :auth_key'
    end

    # Sends a push notification to the APNS
    #
    # @param [Hash] options hash to construct a notification
    # @option options [String] :device_token the device token to receive this push notification
    # @option options [String] :app the name of the app
    # @option options [String] :environment the environment this app is running in _(production, development, sandbox)_
    # @option options [String] :alert the message to send
    # @option options [Hash] :data any custom attributes to send
    # @option options [Integer] :badge sets the badge number to the specified number
    # @option options [String] :sound play the specified sound when the notification is received.
    # @option options [Integer] :content_available notify the device that new content is available
    def apns_notificaton(options={})
      return post '/push/apns', query: options
    end

    # Sends a push notification to GCM
    #
    # @param [Hash] options hash to construct a notification
    # @option options [String] :registration_ids array of registration ids to receive this notification. You can send up to 1000 at once.
    # @option options [String] :app the name of the app
    # @option options [String] :environment the environment this app is running in _(production, development, sandbox)_
    # @option options [Hash] :data any custom attributes to send
    # @option options [String] :collapse_key signifies that this is a send-to-sync message. You can use up to 4 different collapse_keys at a time
    # @option options [Integer] :expiry set the time to live of the message. Can be from 0 to 2,419,200 seconds.
    def gcm_notification(options={})
      return post '/push/gcm', query: options
    end

    private

    def post(path, options={})
      self.class.post path, options
    end
  end
end