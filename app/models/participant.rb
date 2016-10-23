class Participant < ApplicationRecord
  include Identifiable

  belongs_to :reward_page
  validates :name, presence: true
  validates :name, uniqueness: {scope: :reward_page_id}

  def complete_task!(task)
    Task.transaction do
      task.participant_id = self.id
      task.complete!
    end
    return true
  end

  def undo_task!(task)
    Task.transaction do
      task.participant_id = nil
      task.undo!
    end
    return true
  end

  # redeems a reward
  def redeem_reward!(reward)
    raise "NOoooo Cheater O\.^" if reward.reward_page_id != self.reward_page_id
    return false if reward.is_redeemed?
    return false if reward.points.to_i > self.points.to_i

    Reward.transaction do
      reward.participant_id = self.id
      reward.redeem!
      self.points -= reward.points
      self.save
    end
  end

  # returns wether or not the user can reedem that reward
  def can_redeem?(reward)
    self.points.to_i >= reward.points.to_i
  end
end
