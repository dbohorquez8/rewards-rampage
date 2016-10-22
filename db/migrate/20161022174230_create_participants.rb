class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.integer :reward_page_id
      t.integer :identifier
      t.string :email

      t.timestamps
    end
    add_index :participants, :reward_page_id
    add_index :participants, :identifier
  end
end
