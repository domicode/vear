class ChangeTypeToKindOnPosts < ActiveRecord::Migration
  def up
    rename_column :posts, :type, :kind
  end

  def down
    rename_column :posts, :kind, :type
  end
end
