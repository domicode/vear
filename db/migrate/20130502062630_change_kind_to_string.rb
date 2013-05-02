class ChangeKindToString < ActiveRecord::Migration
  def up
    change_column :posts, :kind, :string, :null => false
  end

  def down
    change_column :posts, :kind, :integer, :null => false
  end
end
