VERSIONCODE=2
VERSION=0.2

all:
	sed -e "s/VERSIONCODE/${VERSIONCODE}/" AndroidManifest.template | sed -e "s/VERSION/${VERSION}/" > AndroidManifest.xml
	ant debug

test: build
	adb install -r bin/EpisoPass-debug.apk

build: files
	android update project --path .
	ant debug

# 署名してアップロード
publish: clean
	sed -e "s/VERSIONCODE/${VERSIONCODE}/" AndroidManifest.template | sed -e "s/VERSION/${VERSION}/" > AndroidManifest.xml
	ant release
	/bin/cp bin/EpisoPass-release-unsigned.apk bin/EpisoPass.apk
	jarsigner -J-Dfile.encoding=UTF8 -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore ~/.android/masui.keystore bin/EpisoPass.apk pitecan
	-/bin/rm bin/EpisoPass-aligned.apk
	zipalign -v 4 bin/EpisoPass.apk bin/EpisoPass-aligned.apk

#	jarsigner -J-Dfile.encoding=UTF8 -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore ~/.android/masui.keystore bin/EpisoPass-aligned.apk pitecan
#	scp bin/Slime.apk pitecan.com:/www/www.pitecan.com/Slime
#	scp bin/Slime.apk pitecan.com:/www/www.pitecan.com/Slime/Slime-${VERSION}.apk

clean:
	sed -e "s/VERSIONCODE/${VERSIONCODE}/" AndroidManifest.template | sed -e "s/VERSION/${VERSION}/" > AndroidManifest.xml
	ant clean

files: assets/www/javascripts/app.js \
	assets/www/javascripts/crypt.js \
	assets/www/javascripts/jquery.js \
	assets/www/javascripts/jquery-ui.js \
	assets/www/javascripts/md5.js \
	assets/www/javascripts/data.js \
	assets/www/stylesheets/episopass.css \
	assets/www/stylesheets/jquery-ui.css \
	assets/www/index.html

assets/www/javascripts/app.js: ../public/javascripts/app.js
	cp -f ../public/javascripts/app.js assets/www/javascripts/app.js
	chmod 444 assets/www/javascripts/app.js
assets/www/javascripts/crypt.js: ../public/javascripts/crypt.js
	cp -f ../public/javascripts/crypt.js assets/www/javascripts/crypt.js
	chmod 444 assets/www/javascripts/crypt.js
assets/www/javascripts/jquery.js: ../public/javascripts/jquery.js
	cp -f ../public/javascripts/jquery.js assets/www/javascripts/jquery.js
	chmod 444 assets/www/javascripts/jquery.js
assets/www/javascripts/jquery-ui.js: ../public/javascripts/jquery-ui.js
	cp -f ../public/javascripts/jquery-ui.js assets/www/javascripts/jquery-ui.js
	chmod 444 assets/www/javascripts/jquery-ui.js
assets/www/javascripts/md5.js: ../public/javascripts/md5.js
	cp -f ../public/javascripts/md5.js assets/www/javascripts/md5.js
	chmod 444 assets/www/javascripts/md5.js
assets/www/javascripts/data.js: ../public/javascripts/data.js
	cp -f ../public/javascripts/data.js assets/www/javascripts/data.js
	chmod 444 assets/www/javascripts/data.js
assets/www/stylesheets/episopass.css: ../public/stylesheets/episopass.css
	cp -f ../public/stylesheets/episopass.css assets/www/stylesheets/episopass.css
	chmod 444 assets/www/stylesheets/episopass.css
assets/www/stylesheets/jquery-ui.css: ../public/stylesheets/jquery-ui.css
	cp -f ../public/stylesheets/jquery-ui.css assets/www/stylesheets/jquery-ui.css
	chmod 444 assets/www/stylesheets/jquery-ui.css

