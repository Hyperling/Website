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

# Give the page a description.
echo -e "\n\t\t<h1 class='col-12 title'>Photo Albums</h1>"
echo -en "\t\t<p class='col-12 text'>You may click on an album name to view "
echo -en "all of its files, or click on a specific image to bring up the full "
echo -en "resolution. On the album pages you may also click an image or video "
echo -e "name to pull up the full resolution for download.</p>"

# Display the album names descending.
ls files/photos/ | sort -r | while read album; do
	# Clean album name.
	album_name=${album}
	album_name=${album_name//_/ }
	album_name=${album_name//-/ }
	echo -en "\t\t<h2 class='col-12 title'>"
	echo -en "<a href='/files/photos/$album/index.html' "
	echo -e "target='_blank' rel='noopener noreferrer'>$album_name</a></h2>"
	echo -e "\t\t<div class='col-12 text'>"

	# Create index for each photo album based on its contents.
	page=""
	subpage="files/photos/$album/index.html"
	pages/helpers/body_open.php > $subpage
	echo -e "\n\t\t<h1 class='col-12 title'>$album_name</h1>" >> $subpage
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


		if [[ $photo == *"/README.md" || $photo == *"/README.txt" ]]; then
			# If there is a README, show it on the PHOTOS page without a link.
			echo -e "\t\t\t<p>`cat $photo`</p>"
		else
			# Otherwise put in the PHOTOS page list.
			echo -en "\t\t\t<li class='indent'><a href=/$photo target='_blank' "
			echo -en "rel='noopener noreferrer'>$filename"
			if [[ $photo == *".mp4" ]]; then
				echo -en " [VIDEO]"
			fi
			echo -e "</a></li>"
		fi

		# Put in the subpage HTML.
		echo -e "\t\t<div class='col-6 center'>" >> $subpage
		echo -en "\t\t\t<a href=/$photo target='_blank' " >> $subpage
		echo -e "rel='noopener noreferrer'>" >> $subpage
		if [[ $photo == *".mp4" ]]; then
			echo -e "\t\t\t\t<video width='320px' controls>" >> $subpage
			echo -e "\t\t\t\t\t<source src='/$photo' type=video/mp4>" >> $subpage
			echo -e "\t\t\t\t\tYour browser does not support videos." >> $subpage
			echo -e "\t\t\t\t</video>" >> $subpage
		elif [[ $photo == *".md" || $photo == *".txt" ]]; then
			echo -e "\t\t\t\t<p>`cat $photo`</p>" >> $subpage
		else
			echo -e "\t\t\t\t<img src='/$photo'/>" >> $subpage
		fi

		# Add a descriptive link.
		echo -en "\t\t\t\t<p>$filename" >> $subpage
		if [[ $photo == *".mp4" ]]; then
			echo -en " [VIDEO]" >> $subpage
		fi
		echo -e "</p>\n\t\t\t</a>\n\t\t</div>" >> $subpage
	done

	# End album on PHOTOS page.
	echo -e "\t\t</div>"

	# Close out the ALBUM's page.
	pages/helpers/body_close.php >> $subpage
done

# Finish the web page.
pages/helpers/body_close.php
