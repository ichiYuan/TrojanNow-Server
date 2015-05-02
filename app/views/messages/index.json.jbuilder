json.array!(@messages) do |message|
  json.extract! message, :content, :sender_name, :receiver_name
  json.url message_url(message, format: :json)
  json.target_id (current_user.id == message.sender.id) ? message.receiver_id : message.sender_id 
  json.target_name (current_user.id == message.sender.id) ? message.receiver.name : message.sender.name
end
