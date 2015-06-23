class CreateVMessages < ActiveRecord::Migration
  def change
    create_table :v_messages do |t|
      t.string :message_id
      t.string :in_reply_to
      t.text :content
      t.string :session_event
      t.string :to_addr
      t.string :to_addr_type
      t.string :from_addr
      t.string :from_addr_type
      t.string :transport_name
      t.string :transport_type

      t.timestamps
    end
  end
end
