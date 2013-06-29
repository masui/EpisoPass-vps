debug: files build apkcopy

build: files
	ant debug
clean:
	ant clean

apkcopy:
	cp bin/EpisoPass-debug.apk ../public/junk.apk

files: assets/www/javascripts/app.js \
	assets/www/javascripts/crypt.js \
	assets/www/javascripts/jquery.js \
	assets/www/javascripts/jquery-ui.js \
	assets/www/javascripts/md5.js \
	assets/www/javascripts/data.js \
	assets/www/stylesheets/episopass.css \
	assets/www/stylesheets/jquery-ui.css \
	assets/www/index.html

assets/www/index.html: ../public/app.html
	cp -f ../public/app.html assets/www/index.html
	chmod 444 assets/www/index.html
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

