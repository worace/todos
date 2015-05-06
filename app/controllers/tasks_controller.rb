class TasksController < ApplicationController
  before_action :load_list
  def create
    @list.tasks.create(task_params)
    redirect_to :back
  end

  def task_params
    params.require(:task).permit(:description, :due_date)
  end

  def load_list
    @list = List.find(params[:list_id])
    redirect_to root_path unless @list
  end
end
