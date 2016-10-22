class AddStatusAndParticipantIdToRewards < ActiveRecord::Migration[5.0]
  def change
    add_column :rewards, :status, :string
    add_index :rewards, :status
    add_column :rewards, :participant_id, :integer
    add_index :rewards, :participant_id
  end
end
