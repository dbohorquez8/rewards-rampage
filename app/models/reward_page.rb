class RewardPage < ApplicationRecord
  include Identifiable

  validates :name, presence: true
  has_many :tasks, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rewards, dependent: :destroy

  private

  def generate_identifier
    self.identifier = SecureRandom.hex(16) unless self.identifier
  end
end
