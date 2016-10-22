require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:reward_page) }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:points) }
  it { should validate_presence_of(:reward_page_id) }
end

