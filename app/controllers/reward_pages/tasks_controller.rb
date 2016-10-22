class RewardPages::TasksController < ApplicationController
  def new
    @task = current_reward_page.tasks.build
  end

  def create
    @task = current_reward_page.tasks.build(task_params)
    if @task.save
      redirect_to reward_page_path(id: current_reward_page.identifier)
    else
      render "new"
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :points)
  end
end
