require "net/http"
require "uri"

class NotifyUser
  
  def self.build
    new(CallVum.build)
  end

  def initialize(call_vum)
    self.call_vum = call_vum
  end

  def call(params)
    message = params[:description] + " - Please dial " + VUM_USSD_CHANNEL

    payload = {"in_reply_to" => "",
      "to_addr" => params[:assignee],
      "to_addr_type" => "msisdn",
      "content" => message}.to_json

    uri = VUM_API_URL_BEGIN + VUM_SMS_CONVERSATION_KEY + VUM_API_URL_END
    
    callparams = {uri: uri,
      user: VUM_USER_ACCOUNT,
      token: VUM_SMS_API_TOKEN,
      payload: payload}

    #todo: error handling
    call_vum.call(callparams)
  end

  private

  attr_reader :task
  attr_accessor :call_vum

end



