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
      #if new session, reset all formproperties
      if params[:session_event] == "new"
        upd = FormProperty.where(task_id: currtask.id).update_all({:processed => false})
      elsif params[:session_event] == "resume"
        #update formproperty
        fp_upd = FormProperty.where(task_id: currtask.id, processed: false)
          .order(id: :asc)
          .limit(1)
          .first

        FormProperty.where(id: fp_upd.id).update_all({value: params[:content], processed: true})
      else
        return true
      end
    end

    formprop = FormProperty.where(task_id: currtask.id, processed: false)
      .order(id: :asc)
      .limit(1)
      .first

    if formprop.nil?
      #notify act
      content = "Values submitted. Please press 'Cancel'. Thank you."
      currtask.update({processed: true})
    else
      content = formprop.name
    end
    
    uri = VUM_API_URL_BEGIN + VUM_USSD_CONVERSATION_KEY + VUM_API_URL_END
    callparams = {uri: uri,
      user: VUM_USER_ACCOUNT,
      token: VUM_USSD_API_TOKEN,
      in_reply_to: params[:message_id],
      to_addr: params[:from_addr],
      to_addr_type: "ussd",
      content: content,
      transport_type: "ussd"}

    vmsgid = VumCall.new(callparams).callout

    #in_reply_to empty
    #session_event 'new'?
    #get oldest incomplete task for user
    #get first form_element

    #in_reply_to not empty
  end

end
