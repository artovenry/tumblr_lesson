Tumblr = require 'tumblr.js'
_      = require "underscore"
yaml   = require "js-yaml"
fs     = require "fs"
path   = require "path"

class Blog
  unless NAME = process.argv[2]
    throw new Error "Usage: test.coffee hogehoge.tumbler.com"
  CREDENTIALS = yaml.load fs.readFileSync(path.resolve __dirname, "./secret.yml")
  @client= Tumblr.createClient
    returnPromises: yes
    credentials: CREDENTIALS
  @info= ->
    @client.blogInfo NAME
  @lipsum= (title, body)->
    title= "LIPSUM4"
    body= """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. 

      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. 
    """
    @client.createTextPost NAME, {title, body}

# Blog.info().then (data)->console.log data
Blog.lipsum()
.then (data)->console.log data
.catch (error)->console.log error