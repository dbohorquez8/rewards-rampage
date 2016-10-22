class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.integer :points
      t.references :reward_page, foreign_key: true

      t.timestamps
    end
  end
end
