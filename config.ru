require 'rubygems'
require 'sinatra'
  
require './episopass.rb'

Encoding.default_external = 'utf-8'

run Sinatra::Application
