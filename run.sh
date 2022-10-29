#!/bin/bash
# 2022-09-14 Hyperling
# Ensure dependencies are met and start the webserver.

# Ensure we are executing from this file's directory.
cd `dirname $0`

### Can docker-compose do this rather than running a sh file on the host OS?
# Look at Dockerfile-ADD for doing git clones into a docker environment. 
# Out of scope for this project, this project is just the site, leave for now.
if [[ ! `which php` || ! `which node`|| ! `which npm` ]]; then
	sudo apt install -y php-fpm nodejs npm
fi

# Fix any file permissions
# Directories and allowed page types are executable, others are not.
find ./pages/ | while read file; do
	if [[ $file == *".php" || $file == *".sh" || -d $file ]]; then
		mode=755
	else
		mode=644
	fi
	chmod -c $mode $file
done

npm install

./main.js
###

exit $?
