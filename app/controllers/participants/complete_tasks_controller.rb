class Participants::CompleteTasksController < ApplicationController
  def create
    @reward_page = current_participant.reward_page
    @task = @reward_page.tasks.find(params[:task_id])
    @task.complete!
  end

  def destroy
    @reward_page = current_participant.reward_page
    @task = @reward_page.tasks.find(params[:task_id])
    @task.undo!
  end
end
