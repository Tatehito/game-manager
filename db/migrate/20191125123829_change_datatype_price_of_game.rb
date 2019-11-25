class ChangeDatatypePriceOfGame < ActiveRecord::Migration[6.0]
  def change
    change_column :games, :price, :integer
  end
end
