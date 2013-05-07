class RenameMessageOnPost < ActiveRecord::Migration
  def up
    rename_column :posts, :message, :body
  end

  def down
    rename_column :posts, :body, :message
  end
end
