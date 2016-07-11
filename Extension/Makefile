#
# Firefox/Chrome用EpisoPass拡張機能
#
js:
	coffee -c crypt.coffee
	coffee -c app.coffee
	coffee -c episopass.coffee

XPIFILES=manifest.json app.js crypt.js episopass.js exports.js jquery-2.1.4.min.js md5.js episopass.png icons
xpi: js
	/bin/rm -f episopass.xpi
	zip -r episopass.xpi ${XPIFILES}

# Firefox拡張機能を署名する
# manifest.json中のバージョン番号を更新してから動かすこと
#
sign: xpi
	web-ext sign --api-key $(MOZILLA_USER) --api-secret $(MOZILLA_SECRET)
	/bin/cp web-ext-artifacts/`ls -1 -t web-ext-artifacts | head -1` episopass.xpi

clean:
	/bin/rm -f *~
	/bin/rm -f crypt.js app.js episopass.js
	/bin/rm -f episopass.xpi

