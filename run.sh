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

sudo=""
if [[ $LOGNAME != "root" ]]; then
	echo "`date` - Using sudo since user is '$LOGNAME'."
	sudo="sudo"
fi

echo "`date` - Check if any system dependencies need installed."
if [[ ! `which php` ]]; then
	echo "- Installing PHP"
	$sudo apt-get install -y php-fpm
fi
if [[ ! `which node` ]]; then
	echo "- Installing Node"
	$sudo apt-get install -y nodejs
fi
if [[ ! `which npm` ]]; then
	echo "- Installing NPM"
	$sudo apt-get install -y npm
fi

# Directories and allowed page types are executable, others are not.
echo "`date` - Fix any strange file permissions."
find ./pages/ | while read file; do
	if [[ $file == *".php" || $file == *".sh" || -d $file ]]; then
		mode=755
	else
		mode=644
	fi
	chmod -c $mode $file
done

###echo "`date` - Check if any node modules need updated/installed."
###npm install

## Main ##

echo "`date` - Start website API."
npm start -- $ports
status=$?

## Finish ##

echo "`date` - Exiting with status '$status'."
exit $status
