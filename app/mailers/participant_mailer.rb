class ParticipantMailer < ApplicationMailer
  default :from => 'no-reply@rewards.com'

  def welcome(participant)
    @participant = participant
    mail(:to => @participant.email,
      :subject => 'You have been invited to a rewards page.')
  end
end
