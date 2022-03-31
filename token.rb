require "oauth"
require "oauth/consumer"
require "dotenv/load"

consumer = OAuth::Consumer.new(ENV["API_KEY"], ENV["API_SECRET"], {
  site: "https://api.twitter.com",
})

request_token = consumer.get_request_token
puts request_token.authorize_url
print "PIN> "
access_token = request_token.get_access_token(:oauth_verifier => gets)
puts "TOKEN:", access_token.token
puts "SECRET:", access_token.secret
