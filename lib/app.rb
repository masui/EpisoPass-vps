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

def apk_old(name)
  tmpdir = "/tmp/episopass#{Time.now.to_i}"
  system("/bin/cp -r /home/masui/EpisoPass/App #{tmpdir}")
  system("/bin/cp /home/masui/EpisoPass/App/AndroidManifest.xml.nopermission #{tmpdir}/AndroidManifest.xml")
  replace("#{tmpdir}/assets/www/index.html",/uselocalfile = true/,'uselocalfile = false')
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
      File.delete(tmpfile)
      qa['localimage'] = "images/#{hash}.#{ext}"
    end
  }
  jsonstr = jsondata.to_json

  system("chmod 644 #{tmpdir}/assets/www/javascripts/data.js")
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###JSON###/,jsonstr)
  replace("#{tmpdir}/assets/www/javascripts/data.js",/###NAME###/,name)

  system("cd #{tmpdir}; /usr/local/android-sdk-linux/tools/android update project --path .")
  system("cd #{tmpdir}; ANT_HOME=/usr/local/ant ant debug")

  apkdata = File.read("#{tmpdir}/bin/EpisoPass-debug.apk")
end

def apk_build(name)
  tmpdir = "/tmp/episopass#{Time.now.to_i}"
  system("/bin/cp -r /home/masui/EpisoPass/Cordova #{tmpdir}")
  File.open("#{tmpdir}/www/qa.json","w"){ |f|
    jsonstr = readdata(name)
    f.print jsonstr
  }
  system("cd #{tmpdir}; ANDROID_HOME=/usr/local/android-sdk-linux JAVA_HOME=/usr/java/default cordova build android")
  apkdata = File.read("#{tmpdir}/platforms/android/build/outputs/apk/android-debug.apk")
  system("/bin/rm -r -f #{tmpdir}")
  apkdata
end

def apk(name)
  redirect "/try.html" if Dir.glob("/tmp/episopass*").length > 0
  tmpdir = "/tmp/episopass#{Time.now.to_i}"
  system "mkdir #{tmpdir}"
  system "mkdir #{tmpdir}/tmp"
  system "cd #{tmpdir}/tmp; unzip /home/masui/EpisoPass/Cordova/platforms/android/build/outputs/apk/android-debug.apk"
  File.open("#{tmpdir}/tmp/assets/www/qa.json","w"){ |f|
    jsonstr = readdata(name)
    f.print jsonstr
  }
  system "cd #{tmpdir}; perl /home/masui/EpisoPass/Cordova/platforms/android/make-manifest.pl tmp > tmp/META-INF/MANIFEST.MF"
  system "cd #{tmpdir}; perl /home/masui/EpisoPass/Cordova/platforms/android/make-cert-sf.pl tmp/META-INF/MANIFEST.MF > tmp/META-INF/CERT.SF"
  system "cd #{tmpdir}; openssl smime -sign -inkey /home/masui/EpisoPass/Cordova/platforms/android/testkey.pem -signer /home/masui/EpisoPass/Cordova/platforms/android/testkey.x509.pem -in tmp/META-INF/CERT.SF -outform DER -noattr > tmp/META-INF/CERT.RSA"
  system "cd #{tmpdir}; /bin/rm -f episopass.apk"
  system "cd #{tmpdir}/tmp; zip ../episopass.apk `find .`"
  #system "cd #{tmpdir}; /bin/rm -f debug.keystore"
  #system "cd #{tmpdir}; keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android -keyalg RSA -validity 10000 -dname 'CN=Android Debug,O=Android,C=US'"
  system "cd #{tmpdir}; jarsigner -verbose -digestalg SHA1 -keystore /home/masui/EpisoPass/Cordova/platforms/android/debug.keystore -storepass android -keypass android -tsa http://timestamp.digicert.com episopass.apk androiddebugkey"
  apkdata = File.read "#{tmpdir}/episopass.apk"
  # 
  system("/bin/rm -r -f #{tmpdir}")
  apkdata
end

if $0 == __FILE__
  #require 'test/unit'
  File.open("/tmp/aho.apk","w"){ |f|
    f.print apk('masui2015')
  }
end
