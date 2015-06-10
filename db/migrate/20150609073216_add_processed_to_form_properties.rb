class AddProcessedToFormProperties < ActiveRecord::Migration
  def change
    add_column :form_properties, :processed, :boolean, :default => false
  end
end
