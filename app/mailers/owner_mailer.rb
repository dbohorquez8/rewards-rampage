class OwnerMailer < ApplicationMailer
  default :from => 'no-reply@rewards.com'

  def welcome(reward_page)
    @reward_page = reward_page
    mail(:to => @reward_page.owner_email,
      :subject => 'Welcome to Rewards.')
  end
end
