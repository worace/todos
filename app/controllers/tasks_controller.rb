class TasksController < ApplicationController
  before_action :load_list
  def create
    @list.tasks.create(task_params)
    redirect_to :back
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to list_path(@task.list)
    else
      render :edit
    end
  end

  def task_params
    params.require(:task).permit(:description, :due_date)
  end

  def load_list
    @list = List.find(params[:list_id])
    redirect_to root_path unless @list
  end

  def task_params
    params.require(:task).permit(:description, :due_date)
  end
end
