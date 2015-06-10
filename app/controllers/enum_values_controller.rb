class EnumValuesController < ApplicationController

  def create
    @enum_value = EnumValue.create(enum_value_params)
    respond_with @enum_value
  end

  private

  def enum_value_params
    params.require(:enum_value).permit(:enumvalid, :name, :form_property_id, :enum_values_attributes => [:enumvalid, :name])
  end
end
