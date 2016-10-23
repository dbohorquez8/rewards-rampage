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
  scope :to_do, -> { where("status in (?)", ['new_task']) }

  aasm column: 'status' do
    state :new_task, :initial => true
    state :completed
    state :approved

    event :complete, :after => :notify_owner_of_reward_page do
      transitions :from => [:new_task, :new], :to => :completed
    end

    event :undo do
      transitions :from => :completed, :to => :new_task
    end

    event :approve, :after => :notify_participant_of_approved_task do
      transitions :from => :completed, :to => :approved
    end

    event :reject, :after => :notify_participant_of_rejected_task do
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

  # if the owner of this task has email, we will notify him
  def notify_owner_of_reward_page
    Rails.logger.info("I will schedule the Email job notify_owner_of_reward_page")
    reward_page.notify_owner_of_task_completion!(self)
    return true
  end

  def notify_participant_of_approved_task
    Rails.logger.info("I will schedule the Email job notify_participant_of_approved_task")
    participant.notify_of_approved_task!(self) unless self.participant_id.nil?
    return true
  end

  def notify_participant_of_rejected_task
    Rails.logger.info("I will schedule the Email job notify_participant_of_approved_task")
    participant.notify_of_rejected_task!(self) unless self.participant_id.nil?
    return true
  end
end
