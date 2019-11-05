class RenameUidColumnToUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :uid, :user_id
  end
end
