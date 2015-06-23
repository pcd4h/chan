module Api
  class VMessagesController < ApplicationController
    respond_to :json
    #before_action :authenticate_token!

    def index
      @v_messages = VMessage.all
      respond_with @v_messages
    end

    def create
      @v_message = VMessage.create(v_message_params)
      respond_with @v_message
    end

    private

    def v_message_params
      params.require(:v_message).permit(:message_id, :in_reply_to, :content, :session_event, :to_addr, :to_addr_type, :from_addr, :from_addr_type, :transport_name, :transport_type)
    end

  end
end
