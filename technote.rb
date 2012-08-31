#!/usr/bin/env ruby
# beginnings of technote v sinatra...
# lets see how this goes.......

require "sinatra"
require "redcarpet"
require "sass"
# require "mongo"
require "./lib/techs"
require "./lib/workorders"
require "./lib/databaser"

require "pry"

#-------------------------------------------------------------------------------
# MongoDB play...

configure do
  # conn = Mongo::Connection.new("localhost", 27017)
  # set :mongo_connection,  conn
  # set :mongo_db,          conn.db('test')
  # set :techs,             settings.mongo_db["techs"]
  set :techs,             Techs.new
  # set :workorders,        settings.mongo_db["workorders"]
  set :workorders,        Workorders.new
  # use session cookies
  enable :sessions
end

#-------------------------------------------------------------------------------
# the actual app of appyness....

set :haml, :layout => :layout, :format => :html5
set :markdown, layout_engine: :haml

###########################################
# login
get '/' do
  haml :login
end

get '/login' do
  haml :login
end

###########################################
# adding workorders
get '/new' do
  @num = settings.workorders.next_number
  # coll.find.sort([:i, :desc])
  haml :new
end

post '/new' do
  params["workorder"] = params["workorder"].to_i
  foo = settings.workorders.insert(params)
  @text = "added workorder:<br/> #{foo}"
  haml :default
end

get '/workorders' do
  doc = "%h2\n  listing all workorders...\n\n%ul\n"
  settings.workorders.find.first(10).each { |w|
    doc << "  %li #{w}\n"
  }
  haml doc
end

###########################################
# finding stuff


###########################################
# adding techs
get '/tech-add' do
  haml :tech_add
end

post '/tech-add' do
  settings.techs.insert(params)
  @working = "received: #{params}"
  haml :tech_add
end

get '/techs' do
  techs = settings.techs.find().to_a
  @techs = techs.map {|t| t if t["firstname"] }.join('<br>')
  haml :techs
end

###########################################
# perusing...
get '/workorder/:number' do
  @params = "set the workorder number and stuff with the things and stuff...  #{params[:number]}"
  haml :default
end

get '/tech/:name' do
  tech = settings.techs.find("tech" =>  params[:name])
  @stuff = "you searched for tech #{params[:name]} and found: #{tech}"
end


#  fluff....
get '/css/stylesheet.css' do
  sass :'css/stylesheet'
end

get '/css/style.css' do
  scss :'css/style'
end