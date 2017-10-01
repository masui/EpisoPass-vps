clean:
	/bin/rm -f *~ */*~
push:
	git push pitecan.com:/home/masui/git/EpisoPass.git
	git push git@github.com:masui/EpisoPass.git
js:
	coffee -c -b public/javascripts/episopass.coffee
	coffee -c public/javascripts/crypt.coffee

certbot:
	/home/masui/Systems/certbot/certbot-auto renew --apache

# Amazonのパスワードを計算するHTML
# こういうのをセーブしておけば安全ということ
Amazon:
	ruby expandjs.rb Amazon_masui  > Amazon.html

# public/images/episopass2.png



