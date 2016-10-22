class RewardPage < ApplicationRecord
  include Identifiable

  validates :name, presence: true
  has_many :tasks, dependent: :destroy
end
