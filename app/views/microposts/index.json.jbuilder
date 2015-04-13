json.array!(@microposts) do |micropost|
  json.extract! micropost, :id, :content, :display_user, :environment
  json.url micropost_url(micropost, format: :json)
end
