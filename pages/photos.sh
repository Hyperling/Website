#!/bin/bash
# 2024-01-21 Hyperling
# Transition away from PhotoPrism. Helps to save system resources and downsize.

# Static Variables
header="<html>\n\t<header>\n\t\t<title>ALBUM</title>\n\t</header>\n\t<body>"
footer="\n\t</body>\n</html>"

# Move to the main project directory.
cd `dirname $0`/..

# Create the necessary HTML components for a web page.
pages/helpers/body_open.php
echo -e "\n\t\t<h1 class='col-12 title'>Photo Albums</h1>"

# Display the album names descending.
ls files/photos/ | sort -r | while read album; do
	# Clean album name.
	album_name=${album}
	album_name=${album_name//_/ }
	album_name=${album_name//-/ }
	echo -en "\t\t<h2 class='col-12 title'>"
	echo -en "<a href='/files/photos/$album/index.html' "
	echo -e "target='_blank' rel='noopener noreferrer'>$album_name</a></h2>"
	echo -e "\t\t\t<div class='col-12 text'>"

	# Create index for each photo album based on its contents
	page=""
	subpage="files/photos/$album/index.html"
	pages/helpers/body_open.php > $subpage
	echo -e "\t\t<h1 class='col-12 title'>$album_name</h1>" >> $subpage
	ls files/photos/$album/* | sort | while read photo; do
		# Do not include the index page.
		if [[ $photo == *"index.html" ]]; then
			continue
		fi

		# Clean filename to be a little more presentable.
		# Going with CAPSLOCK. ;)
		typeset -u filename
		filename="`basename $photo`"
		# Remove extension.
		filename="${filename%%.*}"
		# Remove special characters for spaces.
		filename="${filename//_/ }"
		filename="${filename//-/ }"

		# Put in the PHOTOS page list
		echo -en "\t\t\t\t<li class='indent'><a href=/$photo target='_blank' "
		echo -e "rel='noopener noreferrer'>$filename</a></li>"

		# Put in the subpage HTML.
		echo -e "\t\t<div class='col-6 center'>" >> $subpage
		echo -en "\t\t\t<a href=/$photo target='_blank' " >> $subpage
		echo -e "rel='noopener noreferrer'>" >> $subpage
		echo -e "\t\t\t\t<img src='/$photo'/>" >> $subpage
		echo -e "\t\t\t\t<p>$filename</p>" >> $subpage
		echo -e "\t\t\t</a>" >> $subpage
		echo -e "\t\t</div>" >> $subpage
	done
	echo -e "\n\t\t\t</div>"

	# Close out the page album's page.
	pages/helpers/body_close.php >> $subpage
done

# Finish the web page
pages/helpers/body_close.php
