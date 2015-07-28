class AddWriteableToFormProperties < ActiveRecord::Migration
  def change
    add_column :form_properties, :writeable, :boolean, :default => true
  end
end
