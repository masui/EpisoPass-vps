# -*- coding: utf-8 -*-
# -*- ruby -*-

$:.unshift File.expand_path 'lib', File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'data'
require 'defaultdata'

get '/' do
  redirect "/index.html"
end

post '/:name/__write' do |name|
  writedata(name,params[:data])
end

get '/:name' do |name|
  @name = name
  @json = readdata(name)
  if @json.nil? then
    data = defaultdata
    @json = defaultdata.to_json
  else
    data = JSON.parse(@json)
  end
  @seed = params[:seed]
  @seed = data['seed'] if @seed.to_s == ''
  erb :episopass
end
