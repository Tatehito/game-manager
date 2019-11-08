class AddColumnToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :url, :string
    add_column :games, :title, :string
    add_column :games, :manufacturer, :string
    add_column :games, :price, :string
    add_column :games, :image, :string
  end
end
