class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  
  has_many :active_messages, class_name: "Message",
                             foreign_key: "sender_id",
                             dependent: destroy
  has_many :passive_messages, class_name: "Message",
                              foreign_key: "receiver_id",
                              dependent: destroy
  has_many :out_messages, through: active_relationships, source: :receiver
  has_many :in_messages, through: passive_messages, source: :sender
  
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@usc\.edu\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
end
