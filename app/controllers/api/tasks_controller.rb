module Api
  class TasksController < ApplicationController
    respond_to :json
    before_action :authenticate_token!

    def index
      @tasks = Task.all
      respond_with @tasks
    end

    def create
      @task = Task.create(task_params)

      #notify user
      #controller example:
      #https://github.com/adamniedzielski/service-objects-example/blob/master/app/controllers/comments_controller.rb
      
      NotifyUser.build.call(task_params)
      
      respond_with @task
    end

    private
    
    def task_params
      params.require(:task).permit(:taskid, :url, :assignee, :name, :description, :form_properties_attributes => [:formpropid, :name, :formproptype, :value, :enum_values_attributes => [:enumvalid, :name]])
      #debugger
    end
  end
end
