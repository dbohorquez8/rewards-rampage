class Participant < ApplicationRecord
  include Identifiable

  belongs_to :reward_page
  validates :name, presence: true
  validates :name, uniqueness: {scope: :reward_page_id}
end
