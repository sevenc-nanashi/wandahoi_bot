require "dotenv/load"
require "twitter"
client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV["API_KEY"]
  config.consumer_secret = ENV["API_SECRET"]
  config.access_token = ENV["OAUTH_KEY"]
  config.access_token_secret = ENV["OAUTH_SECRET"]
end

BASE = "わんだほーい！"
shuffled = BASE.chars.shuffle.join

tweet = client.update(shuffled)

if shuffled == BASE
  File.open("./SUCCESS_LOG.md", "a") do |f|
    f.puts "| https://github.com/sevenc-nanashi/wandahoi_bot/actions/runs/#{ENV["GITHUB_RUN_ID"]} | #{tweet.url} |"
  end
else
  exit 1
end
