class ConverseUssd

  def self.build
    new
  end

  def call(params)
    #todo: cater for readable attribute
    
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

      #distinction writeable: non-writeable fields (values) as information to the user
      if fp_upd.writeable?
        if fp_upd.formproptype == "string" or fp_upd.formproptype == "long"
          upd_f = FormProperty.where(id: fp_upd.id).update_all({value: params[:content]})
        elsif fp_upd.formproptype == "enum"
          #todo: check for valid number
          val = fp_upd.enum_values.order(id: :asc)[Integer(params[:content]) - 1].name
          upd_f = FormProperty.where(id: fp_upd.id).update_all({value: val})
        end #? todo: cater for date
      else
        
      end
     
      upd_f = FormProperty.where(id: fp_upd.id).update_all({processed: true})
    end

    formprop = FormProperty.where(task_id: currtask.id, processed: false)
      .order(id: :asc)
      .limit(1)
      .first

    if formprop.nil?
      #notify act
      a_callparams = {:payload => buildSubmitTaskFormData(currtask.id)}
      ActCall.new(a_callparams).submitformdata

      callparams[:content] = "Values submitted. Please press 'Cancel'. Thank you."
      currtask.update({processed: true, in_progress: false})
    else
      if formprop.formproptype == "enum"   
        i = 0
        content = formprop.name + " - Please select:\n"
        
        formprop.enum_values.order(id: :asc).each do |enum_val|
          i = i + 1
          content = content + i.to_s + ": " + enum_val.name + "\n"
        end
        
        callparams[:content] = content
        
      else #formproptype = string or long or date...
        if formprop.writeable?
          callparams[:content] = formprop.name
        else
          #display value as info to user
          callparams[:content] = formprop.name + " - " + formprop.value.to_s
        end
      end
    end
    
    vmsgid = VumCall.new(callparams).callout
  end

  def buildSubmitTaskFormData(taskid)
    properties = []

    FormProperty.where(task_id: taskid, processed: true, writeable: true).order(id: :asc).each do |fp|
      properties.append({:id => fp.formpropid, :value => fp.value})
    end

    return {:taskId => taskid, :properties => properties}.to_json

  end

end
