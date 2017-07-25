express = require "express"
oauth   = require "oauth"
http    = require "http"
_       = require "underscore"

host= "localhost"
port= 3000
CALLBACK_URL= "/auth/callback"
app= express()
app.set "port", 3000

oauth_token= undefined
oauth_token_secret= undefined

consumer = new oauth.OAuth \
  "https://www.tumblr.com/oauth/request_token",
  "https://www.tumblr.com/oauth/access_token",
  process.env.npm_config_consumer_key,
  process.env.npm_config_consumer_secret,
  "1.0A",
  "http://#{host}:#{port}#{CALLBACK_URL}",
  "HMAC-SHA1"

# GENERATE REQUEST TOKEN
app.get "/", (request, response)->
  consumer.getOAuthRequestToken (error, token, tokenSecret)->
    oauth_token= token
    oauth_token_secret= tokenSecret
    response.redirect "https://www.tumblr.com/oauth/authorize?oauth_token=#{token}"

# GENERATE ACCESS TOKEN
app.get CALLBACK_URL, (request, response)->
  consumer.getOAuthAccessToken oauth_token, oauth_token_secret, request.query.oauth_verifier, (error, token, secret)->
      response.send """
        Access Token: #{token} <br />
        Access Token Secret: #{secret}
      """

http.createServer app
.listen app.get("port"), ->console.log "Express server listening on port #{app.get("port")}"