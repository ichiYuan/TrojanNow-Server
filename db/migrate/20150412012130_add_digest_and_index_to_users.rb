class AddDigestAndIndexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_digest, :string
    
    add_index :users, :name, unique: true
  end
end
