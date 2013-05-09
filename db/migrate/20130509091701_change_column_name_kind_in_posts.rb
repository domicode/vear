class ChangeColumnNameKindInPosts < ActiveRecord::Migration
  def up
    rename_column :posts, :kind, :type
  end

  def down
    rename_column :posts, :type, :kind
  end
end
