class AddIndices < ActiveRecord::Migration
  def change
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
    
    add_index :likes, :user_id
    add_index :likes, :micropost_id
    add_index :likes, [:user_id, :micropost_id], unique: true
    
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
    
    add_index :microposts, :user_id
    
    add_index :users, :email, unique: true
  end
end
