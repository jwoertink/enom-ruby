require 'httparty'

module EnomRuby

  class Client
    include HTTParty

    class << self
      attr_accessor :username, :password, :test_mode
      alias_method :test?, :test_mode

      def configure
        yield self
        self
      end

      # All requests must contain the UID, PW, and ResponseType query parameters
      def default_params
        { "UID" => self.username, "PW" => self.password, "ResponseType" => "xml" }
      end

      # Enom has a test platform and a production platform.  Both are configured to use
      # HTTPS at all times. Don't forget to configure permitted IPs (in both environments)
      # or you'll get InterfaceErrors.
      def base_uri
        subdomain = test? ? 'resellertest' : 'reseller'
        "https://#{subdomain}.enom.com/interface.asp"
      end

      # All requests to Enom are GET requests, even when we're changing data.  Unfortunately,
      # Enom also does not provide HTTP status codes to alert for authentication failures
      # or other helpful statuses -- everything comes back as a 200.
      def request(params = {})
        response = get(base_uri, query: params.merge(default_params))
        if Integer(response["interface_response"]["ErrCount"]).zero?
          return response["interface_response"]
        else
          raise response["interface_response"]["errors"].values.join(", ")
        end
      end
    end
  end
end
