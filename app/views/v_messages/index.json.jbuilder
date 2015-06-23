json.array!(@v_messages) do |v_message|
  json.extract! v_message, :id, :message_id, :in_reply_to, :content, :session_event, :to_addr, :to_addr_type, :from_addr, :from_addr_type, :transport_name, :transport_type
  json.url v_message_url(v_message, format: :json)
end
