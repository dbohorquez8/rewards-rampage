class Task < ApplicationRecord
  include AASM

  validates :description, presence: true
  validates :reward_page_id, presence: true
  validates :points, presence: true

  belongs_to :reward_page

  aasm column: 'status' do
    state :new, :initial => true
    state :completed
    state :approved

    event :complete do
      transitions :from => :new, :to => :completed
    end

    event :undo do
      transitions :from => :completed, :to => :new
    end

    event :approve do
      transitions :from => :completed, :to => :approved
    end

    event :reject do
      transitions :from => :completed, :to => :new
    end
  end
end
