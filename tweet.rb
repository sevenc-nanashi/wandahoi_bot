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
puts <<~EOS
       #{shuffled}:
         #{tweet.url}
     EOS

if shuffled == BASE
  File.open("./SUCCESS_LOG.md", "a") do |f|
    f.puts "| #{Time.now} | #{tweet.url} |"
  end
  system "git -c user.name='えむロボ' -c user.email='emu_bot@phoenix_wonderland.com' commit -am 'わんだほーい！'"
  system "git push"
end
