#
# Browserifyで re_expand を使えるようにしている
#

#
# main.coffee の記述をもとになぞなぞ問題を作る!
#   main.js に変換
#   browserify で expand.js に変換 => ブラウザで使えるようになる
#

js:
	coffee -b -c main.coffee
	coffee -b -c main_e.coffee
	browserify main.js -o expand.js
	browserify main_e.js -o expand_e.js

#
# http://www.pitecan.com/tmp/EpisoQ/ で実験できるように
#
upload: js
	scp index.html expand.js pitecan.com:/www/www.pitecan.com/tmp/EpisoQ
