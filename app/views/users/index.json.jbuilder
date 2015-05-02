json.array!(@users) do |user|
  json.extract! user, :id, :name, :first_name, :last_name, :email, :password_digest
  json.url user_url(user, format: :json)
  json.following !!current_user && current_user.following?(user)
end
