class RewardPages::TasksController < ApplicationController
  def new
    @task = current_reward_page.tasks.build
  end

  def create
    @task = current_reward_page.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to reward_page_path(current_reward_page.identifier) }
        format.js { }
      else
        format.html { render action: "new" }
        format.js { }
      end
    end
  end

  def destroy
    @task = current_reward_page.tasks.find(task_id_param)
    @task.destroy
    redirect_to reward_page_path(id: current_reward_page.identifier) unless request.xhr?
  end

  private

  def task_id_param
    params.require(:id)
  end

  def task_params
    params.require(:task).permit(:description, :points, :title)
  end
end
