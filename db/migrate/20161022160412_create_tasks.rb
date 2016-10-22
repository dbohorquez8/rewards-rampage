class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.text :description
      t.integer :reward_page_id
      t.string :status
      t.integer :points
      t.integer :participant_id

      t.timestamps
    end
  end
end
