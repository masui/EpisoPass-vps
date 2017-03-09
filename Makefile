clean:
	/bin/rm -f *~ */*~
push:
	git push pitecan.com:/home/masui/git/EpisoPass.git
	git push git@github.com:masui/EpisoPass.git
js:
	coffee -c public/javascripts/episopass.coffee
	coffee -c public/javascripts/crypt.coffee

certbot:
	/home/masui/Systems/certbot/certbot-auto renew --apache

# public/images/episopass2.png



