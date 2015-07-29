class SendSms
  
  def self.build
    new
  end

  def call(params)
    content = params[:description].to_s + " - Please dial " + VUM_USSD_CHANNEL
    uri = VUM_API_URL_BEGIN + VUM_SMS_CONVERSATION_KEY + VUM_API_URL_END
    
    callparams = {uri: uri,
      user: VUM_USER_ACCOUNT,
      token: VUM_SMS_API_TOKEN,
      in_reply_to: "",
      to_addr: params[:assignee],
      to_addr_type: "msisdn",
      content: content,
      transport_type: "sms"}

    #todo: error handling
    VumCall.new(callparams).callout    
  end

end



