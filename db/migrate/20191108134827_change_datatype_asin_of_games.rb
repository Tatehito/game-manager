class ChangeDatatypeAsinOfGames < ActiveRecord::Migration[6.0]
  def change
    change_column :games, :asin, :string
  end
end
