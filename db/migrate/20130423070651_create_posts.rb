class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :kind, :null => false
      t.string :message, :limit => 140, :null => false

      t.timestamps
    end
  end
end
