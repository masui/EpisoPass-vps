# -*- coding: utf-8 -*-
# -*- ruby -*-

$:.unshift File.expand_path 'lib', File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'sinatra/cross_origin'
require 'data'
require 'defaultdata'
require 'app'
require 'expand'
require 'config'

enable :cross_origin

get '/' do
  redirect "/index.html"
end

post '/:name/__write' do |name|
  data = params[:data]
  log(name,data)
  writedata(name,params[:data])
end

get '/:name.apk' do |name|
  # return "- Service Temporarily Unavailable -"
  content_type 'application/vnd.android.package-archive'
  apk(name)
end

#get '/EpisoDAS/:name.html' do |name|
#  @name = name
#  @json = readdata(name)
#  @json = defaultdata.to_json if @json.nil?
#  erb :episodas
#end

get '/DAS/' do |name|
  redirect "/DAS"
end

get '/EpisoDAS/' do |name|
  redirect "/DAS"
end

get '/EpisoDAS' do |name|
  redirect "/DAS"
end

get '/DAS' do |name|
  redirect "http://scrapbox.io/masui/EpisoDAS"
end

get '/DAS/:name/:seed' do |name,seed|
  @name = name
  @seed = seed
  redirect "/EpisoDAS.html?name=#{name}&seed=#{seed}"
end

get '/DAS/:name' do |name|
  @name = name
  redirect "/EpisoDAS.html?name=#{name}"
end

get '/:name.html' do |name|
  @name = name
  @json = readdata(name)
  @json = defaultdata.to_json if @json.nil?
  expand
  # erb :app
end

get '/:name/:seed.html' do |name,seed|
  @name = name
  @seed = seed
  @json = readdata(name)
  @json = defaultdata.to_json if @json.nil?
  expand
end

get '/:name.json' do |name|
  cross_origin
  json = readdata(name)
  json = defaultdata.to_json if json.nil?
  json
end

get '/:name/:seed' do |name,seed|
  @name = name
  @json = readdata(name)
  @json = defaultdata.to_json if @json.nil?
  @seed = seed
  @seed = JSON.parse(@json)['seed'] if @seed == ''
  erb :episopass
end

get '/:name/' do |name|
  redirect "/#{name}"
end

get '/:name' do |name|
  @name = name
  @json = readdata(name)
  @json = defaultdata.to_json if @json.nil?
  @seed = params[:seed].to_s
  @seed = JSON.parse(@json)['seed'] if @seed == ''
  erb :episopass
end
