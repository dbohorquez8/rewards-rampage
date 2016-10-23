class ParticipantMailer < ApplicationMailer
  default :from => 'no-reply@rewards.com'

  def welcome(participant)
    @participant = participant
    mail(:to => @participant.email,
      :subject => 'You have been invited to a rewards page.')
  end

  def points_awarded_to_you(participant, task)
    @participant = participant
    @task        = task
    mail(:to => @participant.email,
      :subject => "You earned #{@task.points} points.")
  end

  def task_submission_rejected(participant, task)
    @participant = participant
    @task        = task
    mail(:to => @participant.email,
      :subject => "[TASK REJECTED] :( please check the task '#{@task.name}'.")
  end
end
