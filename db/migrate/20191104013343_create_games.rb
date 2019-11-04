class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :uid
      t.integer :asin
      t.integer :status
      t.integer :platform
      t.integer :evaluation
      t.text :memo
      t.integer :play_time

      t.timestamps
    end
  end
end
