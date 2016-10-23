class Reward < ApplicationRecord
  include AASM

  belongs_to :reward_page
  belongs_to :participant, optional: true

  validates :name, presence: true
  validates :photo, presence: true
  validates :points, presence: true, numericality: true
  validates :reward_page_id, presence: true

  aasm column: 'status' do
    state :not_redeemed, :initial => true
    state :redeemed

    event :redeem, :after => :notify_owner_of_redeemed_reward do
      transitions :from => :not_redeemed, :to => :redeemed
    end
  end

  # return true if the reward is redeemed
  def is_redeemed?
    redeemed? || self.participant_id != nil
  end

  # this will notify the owner that a participant redeemed a reward
  def notify_owner_of_redeemed_reward
    reward_page.notify_owner_of_redeemed_reward!(self, self.participant_id)
    return true
  end

end
