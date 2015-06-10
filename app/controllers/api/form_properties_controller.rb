module Api
  class FormPropertiesController < ApplicationController
    respond_to :json
    before_action :authenticate_token!

    def index
      @form_properties = FormProperty.all
      respond_with @form_properties
    end

    def create
      debugger
      @form_property = FormProperty.create(form_property_params)
      respond_with @form_property
    end
    
    private
    
    def form_property_params
      params.require(:form_property).permit(:formpropid, :name, :formproptype, :value, :task_id)
    end

  end
end
