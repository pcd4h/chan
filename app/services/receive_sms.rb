class ReceiveSms

  def self.build
    new
  end

  def call(params)
    return true if params[:transport_type] != "sms"
    
    callparams = {from_addr: params[:from_addr],
      procdefkey: params[:content]}
    
    ActCall.new(callparams).startprocinst
  end

end
