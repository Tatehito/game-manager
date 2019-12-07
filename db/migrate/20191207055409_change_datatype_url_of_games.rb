class ChangeDatatypeUrlOfGames < ActiveRecord::Migration[6.0]
  def change
    change_column :games, :url, :text
  end
end
