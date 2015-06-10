class CreateFormProperties < ActiveRecord::Migration
  def change
    create_table :form_properties do |t|
      t.string :formpropid
      t.string :name
      t.string :type
      t.text :value
      t.references :task, index: true

      t.timestamps
    end
  end
end
