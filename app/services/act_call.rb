require "net/http"
require "uri"

class ActCall

  def initialize(params)
    @inparams = params
  end

  def startprocinst
    @uristr = ACT_REST_URL + ACT_PATH_PROC_INST
    @payload = {"processDefinitionKey" => @inparams[:procdefkey],
      "variables" => [{"name" => "initphone",
                        "value" => @inparams[:from_addr]}]}.to_json

    post
  end

  def submitformdata
    @uristr = ACT_REST_URL + ACT_PATH_TASK
    @payload = @inparams[:payload]
    post
  end

  def post
    uri = URI.parse(@uristr)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
    request.basic_auth ACT_REST_USER, ACT_REST_PASSWORD
    request.body = @payload

    #todo: error handling
    response = http.request(request)

    @result = JSON.parse(response.body)

    puts "Response #{response.code} #{response.message}: #{response.body}"
  end

end

