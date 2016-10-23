class OwnerMailer < ApplicationMailer
  default :from => 'no-reply@rewards.com'

  def welcome(reward_page)
    @reward_page = reward_page
    mail(:to => @reward_page.owner_email,
      :subject => 'Welcome to Rewards.')
  end

  def task_completed(reward_page, task)
    @reward_page = reward_page
    @task = task

    mail(:to => @reward_page.owner_email,
      :subject => 'A completed task needs your approval.')
  end
end
