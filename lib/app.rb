# -*- coding: utf-8 -*-

require 'config'
require 'data'

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

  json = readdata(name)
  system("chmod 644 #{tmpdir}/assets/www/javascripts/data.js")
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###JSON###/,json)
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###NAME###/,name)

  system("cd #{tmpdir}; ANT_HOME=/usr/local/ant ant debug")

  apkdata = File.read("#{tmpdir}/bin/EpisoPass-debug.apk")
end
