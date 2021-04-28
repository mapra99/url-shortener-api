redis_url = ENV["REDISCLOUD_URL"] || ENV["REDIS_URL"]

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end

schedule_file = "config/schedule.yml"

if File.exist?(schedule_file)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
