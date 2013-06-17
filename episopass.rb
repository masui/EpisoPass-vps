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
  @data = readdata(name)
  @data = defaultdata if @data.nil?
  @seed = params[:seed]
  @json = @data.to_json
  erb :episopass
end
