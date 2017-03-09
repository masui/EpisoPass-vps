#
# Firefox/Chrome用EpisoPass拡張機能
#
js:
	coffee -c crypt.coffee
	coffee -c app.coffee
	coffee -c episopass.coffee

#
# Firefox拡張機能用のxpiを作る
#
XPIFILES=manifest.json app.js crypt.js episopass.js exports.js jquery-2.1.4.min.js md5.js episopass.png icons privacy.html
xpi: js
	/bin/rm -f episopass.xpi
	zip -r episopass.xpi ${XPIFILES}

#
# Chromeエクステンション公開用のzipを作る
#
ZIPFILES=manifest.json app.js crypt.js episopass.js exports.js jquery-2.1.4.min.js md5.js episopass.png icons
zip: js
	/bin/rm -f episopass.zip
	zip -r episopass.zip ${XPIFILES}

# Firefox拡張機能を署名する
# manifest.json中のバージョン番号を更新してから動かすこと
#
# 審査してもらうときこれでうまくいくのか不明...
#
sign: xpi
	web-ext sign --api-key $(MOZILLA_USER) --api-secret $(MOZILLA_SECRET)
	/bin/cp web-ext-artifacts/`ls -1 -t web-ext-artifacts | head -1` episopass.xpi

clean:
	/bin/rm -f *~
	/bin/rm -f crypt.js app.js episopass.js
	/bin/rm -f episopass.xpi
	/bin/rm -f episopass.zip
	/bin/rm -f episopass.crx
