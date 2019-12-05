class AddColumnToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :purchase_date, :date
  end
end
