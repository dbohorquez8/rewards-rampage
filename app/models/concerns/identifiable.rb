module Identifiable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_identifier, on: :create
    validates :identifier, presence: true
    validates :identifier, uniqueness: true
  end

  private

  def generate_identifier
    self.identifier = SecureRandom.hex(16) unless self.identifier
  end
end
