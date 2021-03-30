json.tweet do
  json.user_id    @tweet.user_id
  json.id         @tweet.id
  json.message    @tweet.message
  json.created_at @tweet.created_at
end
