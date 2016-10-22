class ChangeDatatypeOfParticipantsIdentifier < ActiveRecord::Migration[5.0]
  def change
    change_column :participants, :identifier, :string
  end
end
