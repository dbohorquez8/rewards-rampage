class RewardPages::ApproveTasksController < ApplicationController
  def create
    @task = current_reward_page.tasks.pending_approval.find(params[:task_id])
    @task.approve!
  end

  def destroy
    @task = current_reward_page.tasks.pending_approval.find(params[:task_id])
    @task.participant_id = nil
    @task.reject!
  end
end
