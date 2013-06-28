# -*- coding: utf-8 -*-

require 'config'
require 'data'
require 'json'
require 'digest/md5'

def replace(file,from,to) # fileのfromパタンをtoに置き換え
  a = []
  File.open(file){ |f|
    f.each { |line|
      line.sub!(from,to)
      a.push(line)
    }
  }
  File.open(file,"w"){ |f|
    f.print(a.join)
  }
end

def apk(name)
  tmpdir = "/tmp/episopass#{Time.now.to_i}"
  system("/bin/cp -r /home/masui/EpisoPass/App #{tmpdir}")
  system("/bin/rm -f #{tmpdir}/bin")

  jsonstr = readdata(name)
  jsondata = JSON.parse(jsonstr)

  # 画像データをローカルにコピー
  qas = jsondata['qas']
  qas.each { |qa|
    s = qa['question']
    if s =~ /\/(([^\/])+\.(gif|png|jpg|jpeg))/i then
      ext = $3
      tmpfile = "/tmp/tmpfile#{Time.now.to_i}"
      system "wget #{s} -O #{tmpfile}"
      hash = Digest::MD5.new.hexdigest(File.read(tmpfile)).to_s
      system "cp #{tmpfile} #{tmpdir}/assets/www/images/#{hash}.#{ext}"
      qa['question'] = "images/#{hash}.#{ext}"
    end
  }
  jsonstr = jsondata.to_json

  system("chmod 644 #{tmpdir}/assets/www/javascripts/data.js")
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###JSON###/,jsonstr)
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###NAME###/,name)

  system("cd #{tmpdir}; ANT_HOME=/usr/local/ant ant debug")

  apkdata = File.read("#{tmpdir}/bin/EpisoPass-debug.apk")
end
