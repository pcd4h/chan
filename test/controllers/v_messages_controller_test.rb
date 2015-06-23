require 'test_helper'

class VMessagesControllerTest < ActionController::TestCase
  setup do
    @v_message = v_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:v_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create v_message" do
    assert_difference('VMessage.count') do
      post :create, v_message: { content: @v_message.content, from_addr: @v_message.from_addr, from_addr_type: @v_message.from_addr_type, in_reply_to: @v_message.in_reply_to, message_id: @v_message.message_id, session_event: @v_message.session_event, to_addr: @v_message.to_addr, to_addr_type: @v_message.to_addr_type, transport_name: @v_message.transport_name, transport_type: @v_message.transport_type }
    end

    assert_redirected_to v_message_path(assigns(:v_message))
  end

  test "should show v_message" do
    get :show, id: @v_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @v_message
    assert_response :success
  end

  test "should update v_message" do
    patch :update, id: @v_message, v_message: { content: @v_message.content, from_addr: @v_message.from_addr, from_addr_type: @v_message.from_addr_type, in_reply_to: @v_message.in_reply_to, message_id: @v_message.message_id, session_event: @v_message.session_event, to_addr: @v_message.to_addr, to_addr_type: @v_message.to_addr_type, transport_name: @v_message.transport_name, transport_type: @v_message.transport_type }
    assert_redirected_to v_message_path(assigns(:v_message))
  end

  test "should destroy v_message" do
    assert_difference('VMessage.count', -1) do
      delete :destroy, id: @v_message
    end

    assert_redirected_to v_messages_path
  end
end
