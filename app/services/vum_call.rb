require "net/http"
require "uri"

class VumCall

  def initialize(params)
    @uri = params[:uri]
    @user = params[:user]
    @token = params[:token]
    @message_id = params[:message_id]
    @in_reply_to = params[:in_reply_to]
    @to_addr = params[:to_addr]
    @to_addr_type = params[:to_addr_type]
    @content = params[:content]
    @transport_type = params[:transport_type]
  end

  def callout
    payload = {"message_id" => "try_msg_01",
      "in_reply_to" => @in_reply_to,
      "to_addr" => @to_addr,
      "to_addr_type" => @to_addr_type,
      "content" => @content}.to_json

    uri = URI.parse(@uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.basic_auth @user, @token
    request.body = payload

    response = http.request(request)

    #todo: error handling, add 'success' indicator to vmessage

    VMessage.create(message_id: @message_id,
                    in_reply_to: @in_reply_to,
                    content: @content,
                    to_addr: @to_addr,
                    to_addr_type: @to_addr_type,
                    transport_type: @transport_type,
                    direction: "out")

  end

end

