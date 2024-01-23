#!/bin/bash
# 2022-09-14 Hyperling
# Ensure dependencies are met and start the webserver.

## Setup ##

DIR=`dirname $0`
PROG=`basename $0`

## Functions ##

function usage {
	cat <<- EOF
		$PROG calls the main Node.js program after ensuring the project can run.
		  (PORTS)
		    -p : Pass the port numbers that the API/website should listen at.
		         Example: $PROG -p 80 -p 443 -p 8080
		  (HELP)
		    -h : Show this usage output and exit successfully.
	EOF
	exit $1
}

## Parameters ##

while getopts ':p:h' opt; do
	case "$opt" in
		p) (( OPTARG < 1024 )) && [[ $LOGNAME != "root" ]] && {
				echo "WARNING: Port $OPTARG is privileged. Will need to be root."
				exit 1
			}
			ports="$ports $OPTARG" ;;
		h) usage 0 ;;
		*) echo "ERROR: Option $OPTARG not recognized." >&2
			usage 1 ;;
	esac
done

## Build Environment ##

# Ensure we are executing from this file's directory.
cd $DIR

# Check if any dependencies need installed.
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

## Main ##

./main.js $ports

## Finish ##

exit $?
