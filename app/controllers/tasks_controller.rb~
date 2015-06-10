class TasksController < ApplicationController

  before_action :authenticate_user!

  def index
    @tasks = Task.all.order("created_at DESC")
  end

  def show
    @task = Task.includes(form_properties: [:enum_values]).find(params[:id])
  end

end
