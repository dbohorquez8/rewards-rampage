class Task < ApplicationRecord
  include AASM

  validates :description, presence: true
  validates :title, presence: true
  validates :title, length: {maximum: 140}
  validates :reward_page_id, presence: true
  validates :points, presence: true

  belongs_to :reward_page

  scope :pending_approval, -> { where("status = ?", 'completed') }
  scope :not_pending_approval, -> { where("status not in (?)", ['completed', 'approved']) }

  aasm column: 'status' do
    state :new_task, :initial => true
    state :completed
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
end
