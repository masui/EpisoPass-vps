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
