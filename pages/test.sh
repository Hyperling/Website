#!/bin/bash

# Move to the directory that this file is in.
cd `dirname $0`

# Create the necessary HTML components for a web page.
./helpers/body_open.php
echo -e "\t\t<h1>This is a web page written in BASH!!!</h1>"
cat << EOF
		<p>
			Look at all the fancy things we can do!
		</p>
		<h2>Current Time</h2>
		<p> 
			We can use the date command to spit out the time!
		</p>
		<p> 
			`date`
		</p>
EOF

# Create a subsection
echo -e "\t\t<h2>Server Neofetch</h2>"
echo -e "\t\t<p>"
neofetch --stdout
echo -e "\t\t</p>"

# Finish the web page
./helpers/body_close.php
