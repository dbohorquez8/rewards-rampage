class TasksController < ApplicationController
  def create
    @task = current_reward_page.tasks.build
    if @task.save
      redirect_to reward_page_path(current_reward_page)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
    else
    end
  end
end
