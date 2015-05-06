class CompletedTasksController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    if task
      task.toggle!
      render json: {success: true, task: task}
    else
      render json: {success: false}, status: 404
    end
  end
end
