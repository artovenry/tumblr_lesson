Tumblr = require 'tumblr.js'
_      = require "underscore"

class Blog
  NAME = "some-user-name.tumblr.com"
  @client= Tumblr.createClient
    returnPromises: yes
    credentials: do ->
      cred= _.inject ITEMS= ["consumer_key", "consumer_secret", "token", "token_secret"], (memo,item)->
        unless memo[item]= process.env["npm_config_#{item}"]
          throw new Error "Credential data '#{item}' not found."
        memo
      , {}
      console.log cred
      cred
  @info= ->
    @client.blogInfo NAME
  @lipsum= (title, body)->
    title= "LIPSUM2"
    body= """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. 

      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. 
    """
    @client.createTextPost NAME, {title, body}

# Blog.info().then (data)->console.log data
Blog.lipsum()
.then (data)->console.log data
.catch (error)->console.log error