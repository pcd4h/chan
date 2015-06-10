class ChangeColumnNameInFormProp < ActiveRecord::Migration
  def change
    rename_column :form_properties, :type, :formproptype
  end
end
