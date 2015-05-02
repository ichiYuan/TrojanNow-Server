class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  def display_user
    anony ? 'Anonymous' : user.name
  end
  
  def liked?(user)
    !likes.includes(user).empty?
  end
end
