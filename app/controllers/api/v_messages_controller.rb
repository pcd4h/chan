module Api
  class VMessagesController < ApplicationController
    respond_to :json
    #before_action :authenticate_token!

    def index
      @v_messages = VMessage.all
      respond_with @v_messages
    end

    def create
      vmsg_params = v_message_params
      vmsg_params[:direction] = "in"

      if vmsg_params[:content].nil? vmsg_params[:content] = ""

      @v_message = VMessage.create(vmsg_params)
      
      if vmsg_params[:transport_type] == "ussd"
        ConverseUssd.build.call(vmsg_params)
      elsif vmsg_params[:transport_type] == "sms"
        ReceiveSms.build.call(vmsg_params)
      end

      respond_with @v_message
    end

    private

    def v_message_params
      params.require(:v_message).permit(:message_id, :in_reply_to, :content, :session_event, :to_addr, :to_addr_type, :from_addr, :from_addr_type, :transport_name, :transport_type, :direction)
    end

  end
end
