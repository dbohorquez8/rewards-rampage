class Task < ApplicationRecord
  validates :description, presence: true
  validates :reward_page_id, presence: true
  validates :points, presence: true

  belongs_to :reward_page
end
