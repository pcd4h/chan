class VMessagesController < ApplicationController
  before_action :set_v_message, only: [:show, :edit, :update, :destroy]

  # GET /v_messages
  # GET /v_messages.json
  def index
    @v_messages = VMessage.all
  end

  # GET /v_messages/1
  # GET /v_messages/1.json
  def show
  end

  # GET /v_messages/new
  def new
    @v_message = VMessage.new
  end

  # GET /v_messages/1/edit
  def edit
  end

  # POST /v_messages
  # POST /v_messages.json
  def create
    @v_message = VMessage.new(v_message_params)

    respond_to do |format|
      if @v_message.save
        format.html { redirect_to @v_message, notice: 'V message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @v_message }
      else
        format.html { render action: 'new' }
        format.json { render json: @v_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /v_messages/1
  # PATCH/PUT /v_messages/1.json
  def update
    respond_to do |format|
      if @v_message.update(v_message_params)
        format.html { redirect_to @v_message, notice: 'V message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @v_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /v_messages/1
  # DELETE /v_messages/1.json
  def destroy
    @v_message.destroy
    respond_to do |format|
      format.html { redirect_to v_messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v_message
      @v_message = VMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def v_message_params
      params.require(:v_message).permit(:message_id, :in_reply_to, :content, :session_event, :to_addr, :to_addr_type, :from_addr, :from_addr_type, :transport_name, :transport_type)
    end
end
