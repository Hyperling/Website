#!/bin/bash
# 2022-09-14 Hyperling
# Ensure dependencies are met and start the webserver.

### Can docker-compose do this rather than running a sh file on the host OS?
# Look at Dockerfile-ADD for doing git clones into a docker environment. 
# Out of scope for this project, this project is just the site.
if [[ ! `which php` || ! `which node`|| ! `which npm` ]]; then
	sudo apt install -y php-fpm nodejs npm
fi

npm install

./main.js
###

exit 0
