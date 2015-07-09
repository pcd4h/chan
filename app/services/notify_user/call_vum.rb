require "net/http"
require "uri"

class NotifyUser
  class CallVum

    def self.build
      new
    end

    def call(callparams)
      uri = URI.parse(callparams[:uri])
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Put.new(uri.request_uri)
      request.basic_auth callparams[:user], callparams[:token]
      request.body = callparams[:payload]

      response = http.request(request)

      #todo: error handling
    end

  end
end
