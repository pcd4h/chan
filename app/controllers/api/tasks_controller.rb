module Api
  class TasksController < ApplicationController
    respond_to :json
    #before_action :authenticate_token!

    def index
      @tasks = Task.all
      respond_with @tasks
    end

    def create
      @task = Task.create(task_params)

      SendSms.build.call(task_params)
      
      respond_with @task
    end

    private
    
    def task_params
      params.require(:task).permit(:taskid, :url, :assignee, :name, :description, :in_progress, :form_properties_attributes => [:formpropid, :name, :formproptype, :value, :writeable, :enum_values_attributes => [:enumvalid, :name]])
    end
  end
end
