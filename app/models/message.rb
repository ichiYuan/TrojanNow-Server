class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, presence: true
  
  def sender_name
    sender.name
  end
  
  def receiver_name
    receiver.name
  end
end
