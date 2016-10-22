class RewardPage < ApplicationRecord
  validates :name, presence: true
  validates :identifier, presence: true
  validates :identifier, uniqueness: true

  before_validation :generate_identifier, on: :create

  has_many :tasks, dependent: :destroy

  private

  def generate_identifier
    self.identifier = SecureRandom.hex(16) unless self.identifier
  end
end
