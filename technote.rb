#!/usr/bin/env ruby
# beginnings of technote v sinatra...
# lets see how this goes.......

require "sinatra"
require "redcarpet"
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

get '/' do
  haml :new
end

get '/login' do
  haml :login
end

post '/workorder-add' do
  @params = params
  haml :default
end

get '/workorders' do
  haml :workorder
end

get '/workorder/:number' do
  @params = "set the workorder number and stuff with the things and stuff...  #{params[:number]}"
  haml :default
end

get '/techs' do
  techs = settings.techs.find().to_a
  @techs = techs.map {|t| t if t["firstname"] }.join('<br>')
  haml :techs
end

get '/tech-add' do
  haml :tech_add
end

post '/tech-add' do
  settings.techs.insert(params)
  @working = "recievd: #{params}"
  haml :tech_add
end

get '/tech/:name' do
  tech = settings.techs.find("tech" =>  params[:name])
  @stuff = "you searched for tech #{params[:name]} and found: #{tech}"
end



