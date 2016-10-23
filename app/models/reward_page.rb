class RewardPage < ApplicationRecord
  include Identifiable

  validates :name, presence: true
  has_many :tasks, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rewards, dependent: :destroy

  validates :owner_email, format: {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, allow_nil: true

  def notify_owner_of_task_completion!(task)
    if owner_email.present?
      OwnerMailer.task_completed(self, task).deliver_later
    end
  end
end
