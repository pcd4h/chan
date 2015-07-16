class ConverseUssd

  def self.build
    new
  end

  def call(params)
    #check ussd

    return true if params[:transport_type] != "ussd"
    
    from_addr = params[:from_addr]

    uri = VUM_API_URL_BEGIN + VUM_USSD_CONVERSATION_KEY + VUM_API_URL_END
    callparams = {uri: uri,
      user: VUM_USER_ACCOUNT,
      token: VUM_USSD_API_TOKEN,
      in_reply_to: params[:message_id],
      to_addr: from_addr,
      to_addr_type: "ussd",
      transport_type: "ussd"}


    #if new session, reset all formproperties
    if params[:session_event] == "new"
      currtask = Task.where("assignee = ? AND processed = ?", from_addr, false)
        .order(in_progress: :desc, created_at: :desc)
        .limit(1)
        .first
      
      if currtask.nil?
        callparams[:content] = "No active Task found. Please press 'Cancel'."
        vmsgid = VumCall.new(callparams).callout
        return vmsgid
      end

      upd_t = Task.where(id: currtask.id).update_all({:in_progress => true})
      upd_f = FormProperty.where(task_id: currtask.id).update_all({:processed => false})
    elsif params[:session_event] == "resume"
      currtask = Task.where("assignee = ? AND processed = ? AND in_progress = ?", from_addr, false, true)
        .order(created_at: :desc)
        .limit(1)
        .first
      
      if currtask.nil?
        callparams[:content] = "No active Task found. Please press 'Cancel'."
        vmsgid = VumCall.new(callparams).callout
        return vmsgid
      end

      #update formproperty
      fp_upd = FormProperty.where(task_id: currtask.id, processed: false)
        .order(id: :asc)
        .limit(1)
        .first

      #upd_t = Task.where(id: currtask_id).update_all({:in_progress => true})
      upd_f = FormProperty.where(id: fp_upd.id).update_all({value: params[:content], processed: true})
    else
      return true
    end

    formprop = FormProperty.where(task_id: currtask.id, processed: false)
      .order(id: :asc)
      .limit(1)
      .first

    if formprop.nil?
      #notify act
      callparams[:content] = "Values submitted. Please press 'Cancel'. Thank you."
      currtask.update({processed: true, in_progress: false})
    else
      if formprop.formproptype == "string"
        callparams[:content] = formprop.name
      elsif formprop.formproptype == "enum"
        
        i = 0
        content = formprop.name + " - Please select:%0A"

        formprop.enum_values.order(id: :asc).each do |enum_val|
          i = i + 1
          content = content + i.to_s + ": " + enum_val.name + "%0A"
        end

        callparams[:content] = content

      else
      end
    end
    
    vmsgid = VumCall.new(callparams).callout
  end

end
