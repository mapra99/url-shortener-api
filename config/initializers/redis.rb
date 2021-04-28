redis_url = ENV["REDISCLOUD_URL"] || ENV["REDIS_URL"]
if redis_url
  $redis = Redis.new(:url => redis_url)
end