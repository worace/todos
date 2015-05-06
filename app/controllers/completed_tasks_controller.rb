class CompletedTasksController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    task.complete! if task
    if task && task.completed?
      render json: {success: true}
    else
      render json: {success: false}, status: 422
    end
  end
end
