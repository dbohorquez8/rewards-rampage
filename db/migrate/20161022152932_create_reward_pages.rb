class CreateRewardPages < ActiveRecord::Migration[5.0]
  def change
    create_table :reward_pages do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end
    add_index :reward_pages, :identifier, unique: true
  end
end
