class Reward < ApplicationRecord
  belongs_to :reward_page

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :photo, presence: true
  validates :points, presence: true, numericality: true
  validates :reward_page_id, presence: true
end
