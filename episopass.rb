# -*- coding: utf-8 -*-
# -*- ruby -*-

$:.unshift File.expand_path 'lib', File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'data'
require 'defaultdata'
require 'app'

get '/' do
  redirect "/index.html"
end

post '/:name/__write' do |name|
  data = params[:data]
  log(name,data)
  writedata(name,params[:data])
end

get '/:name/__json/:filename' do |name,filename|
  content_type 'application/json'
  readdata(name)
end

post '/:name/__upload' do |name|
  param = params[:uploadfile]
  if param
    # アップロードされたファイルはTempfileクラスになる
    tempfile = param[:tempfile]
    file_contents = tempfile.read
    file_ext = File.extname(param[:filename]).to_s
    tempfile.close # 消してしまう

    writedata(name,file_contents)
  end
end

get '/:name.apk' do |name|
  apkdata = apk(name)
  content_type 'application/vnd.android.package-archive'
  apkdata
end

get '/:name.html' do |name|
  @name = name
  @json = readdata(name)
  @json = defaultdata.to_json if @json.nil?
  erb :app
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
