class Task < ApplicationRecord
  include AASM

  validates :description, presence: true
  validates :title, presence: true
  validates :title, length: {maximum: 140}
  validates :reward_page_id, presence: true
  validates :points, presence: true

  belongs_to :reward_page
  belongs_to :participant, optional: true

  scope :pending_approval, -> { where("status = ?", 'completed') }
  scope :not_pending_approval, -> { where("status not in (?)", ['completed', 'approved']) }

  aasm column: 'status' do
    state :new_task, :initial => true
    state :completed, :after => :notify_owner_of_reward_page
    state :approved

    event :complete do
      transitions :from => [:new_task, :new], :to => :completed
    end

    event :undo do
      transitions :from => :completed, :to => :new_task
    end

    event :approve do
      transitions :from => :completed, :to => :approved
    end

    event :reject do
      transitions :from => :completed, :to => :new_task
    end
  end

  # gives the participant his points
  def award_points!
    Task.transaction do
      participant.points = participant.points.to_i + self.points.to_i
      participant.save
      self.approve!
    end
    return true
  end

  private

  # if the owner of this task has email, we will notify him
  def notify_owner_of_reward_page
    reward_page.notify_owner_of_task_completion!(self)
  end
end
