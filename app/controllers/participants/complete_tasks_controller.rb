class Participants::CompleteTasksController < ApplicationController
  def create
    @reward_page = current_participant.reward_page
    @task = @reward_page.tasks.find(params[:task_id])
    current_participant.complete_task!(@task)
  end

  def destroy
    @reward_page = current_participant.reward_page
    @task = @reward_page.tasks.find(params[:task_id])
    current_participant.undo_task!(@task)
  end
end
