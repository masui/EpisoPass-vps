build:
	cordova build android
run:
	cordova run android
keystore:
	/bin/rm -r -f debug.keystore
	keytool -genkey -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android -keyalg RSA -validity 10000 -dname "CN=Android Debug,O=Android,C=US"


