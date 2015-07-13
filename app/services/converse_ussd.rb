class ConverseUssd

  def self.build
    new
  end

  def call(params)
    #check ussd
    return true if params[:transport_type] != "ussd"
    
    from_addr = params[:from_addr]

    currtask = Task.where("assignee = ? AND processed = ?", from_addr, false)
      .order(created_at: :desc)
      .limit(1)
      .first

    if currtask.nil?
      #msg: no open tasks
    else
      
    end

    #experimental
    content = "response to " + params[:message_id]
    
    uri = VUM_API_URL_BEGIN + VUM_USSD_CONVERSATION_KEY + VUM_API_URL_END
    callparams = {usi: uri,
      user: VUM_USER_ACCOUNT,
      token: VUM_USSD_API_TOKEN,
      in_reply_to: params[:message_id],
      to_addr: params[:from_addr],
      to_addr_type: "ussd",
      content: content,
      transport_type: "ussd"}

    VumCall.new(callparams).callout

    #in_reply_to empty
    #session_event 'new'?
    #get oldest incomplete task for user
    #get first form_element

    #in_reply_to not empty
  end

end
