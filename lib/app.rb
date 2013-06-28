# -*- coding: utf-8 -*-

require 'config'
require 'data'

def replace(file,from,to)
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
  env = {}
  env['PATH']='/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/android-sdk-linux/platforms:/usr/local/android-sdk-linux/tools:/usr/local/ant/bin:/usr/java/default/bin:/usr/local/phonegap/lib/android/bin:/usr/java/default/bin'
  env['CLASSPATH']='.:/usr/java/default/jre/lib:/usr/java/default/lib:/usr/java/default/lib/tools.jar'
  env['ANDROID_HOME']='/usr/local/android-sdk-linux'

  tmpdir = "/tmp/episopass#{Time.now.to_i}"
  system("/bin/cp -r /home/masui/EpisoPassApp #{tmpdir}")
  system("/bin/rm -f #{tmpdir}/bin")

  json = readdata(name)
  system("chmod 644 #{tmpdir}/assets/www/javascripts/data.js")
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###JSON###/,json)
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###NAME###/,name)

  # system "cd #{tmpdir}; /usr/bin/ant clean"
  #system("cd #{tmpdir}; PATH=#{env['PATH']} CLASSPATH=#{env['CLASSPATH']} ANDROID_HOME=#{env['ANDROID_HOME']} ANT_HOME=/usr/local/ant ant debug")
  system("cd #{tmpdir}; ANT_HOME=/usr/local/ant ant debug")

  #File.open("/tmp/lll","w"){ |f|
  #  f.puts "cd #{tmpdir}; PATH=#{env['PATH']} CLASSPATH=#{env['CLASSPATH']} /usr/bin/ant debug"
  #}

  apkdata = File.read("#{tmpdir}/bin/EpisoPass-debug.apk")
  # "#{tmpdir}/bin/EpisoPass-debug.apk"
end
