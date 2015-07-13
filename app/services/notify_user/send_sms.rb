class NotifyUser
  class SendSms

    def self.build
      new
    end

    def call(params)
      content = params[:description] + " - Please dial " + VUM_USSD_CHANNEL

      payload = {"in_reply_to" => "",
        "to_addr" => params[:assignee],
        "to_addr_type" => "msisdn",
        "content" => content}.to_json

      uri = VUM_API_URL_BEGIN + VUM_SMS_CONVERSATION_KEY + VUM_API_URL_END
    
      callparams = {uri: uri,
        user: VUM_USER_ACCOUNT,
        token: VUM_SMS_API_TOKEN,
        payload: payload}

      #todo: error handling
      VumCall.new(callparams).callout
    end

  end
end
