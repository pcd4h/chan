class AddDirectionToVMessage < ActiveRecord::Migration
  def change
    add_column :v_messages, :direction, :string
  end
end
