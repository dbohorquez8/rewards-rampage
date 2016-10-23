class AddOwnerEmailToRewardPages < ActiveRecord::Migration[5.0]
  def change
    add_column :reward_pages, :owner_email, :string
  end
end
