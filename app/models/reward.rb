class Reward < ApplicationRecord
  include AASM

  belongs_to :reward_page

  # mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  # validates :photo, presence: true
  validates :points, presence: true, numericality: true
  validates :reward_page_id, presence: true

  aasm column: 'status' do
    state :not_redeemed, :initial => true
    state :redeemed

    event :redeem do
      transitions :from => :not_redeemed, :to => :redeemed
    end
  end

  # return true if the reward is redeemed
  def is_redeemed?
    redeemed? || self.participant_id != nil
  end

end
