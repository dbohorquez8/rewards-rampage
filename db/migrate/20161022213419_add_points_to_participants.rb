class AddPointsToParticipants < ActiveRecord::Migration[5.0]
  def change
    add_column :participants, :points, :integer
  end
end
