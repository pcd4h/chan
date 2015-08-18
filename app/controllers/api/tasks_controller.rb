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

      #SendSms.build.call(task_params)
      
      respond_with @task
    end

    def update_by_taskid
      @task = Task.find_by_taskid(task_params[:taskid])
      @task.update_attributes!(task_params)
      respond_with @task
    end

    def task_by_taskid
      @task = Task.find_by_taskid(task_params[:taskid])
      respond_with @task
    end

    def show
    byebug
      @task = Task.find(params[:id])
      respond_with @task
    end

    private
    
    def task_params
      params.require(:task).permit(:taskid, :url, :assignee, :name, :description, :processed, :in_progress, :form_properties_attributes => [:formpropid, :name, :formproptype, :value, :writeable, :enum_values_attributes => [:enumvalid, :name]])
    end
  end
end
