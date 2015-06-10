class CreateEnumValues < ActiveRecord::Migration
  def change
    create_table :enum_values do |t|
      t.string :enumvalid
      t.string :name
      t.references :form_property, index: true

      t.timestamps
    end
  end
end
