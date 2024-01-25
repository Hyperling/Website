#!/bin/bash
# 2024-01-21 Hyperling
# Transition away from PhotoPrism. Helps to save system resources and downsize.

# Static Variables
header="<html>\n\t<header>\n\t\t<title>ALBUM</title>\n\t</header>\n\t<body>"
footer="\n\t</body>\n</html>"
HELPER_DIR=./pages/helpers

# Move to the main project directory.
cd `dirname $0`/..

# Create the necessary HTML components for a web page.
$HELPER_DIR/body_open.php
echo ""

# Give the page a description.
echo -e "\t\t<div class='row'>"
echo -e "\t\t\t<h1 class='col-12 title'>Photo Albums</h1>"
echo -e "\t\t</div>"

echo -e "\t\t<div class='row'>"
echo -e "\t\t\t<div class='col-12 text'>"
echo -en "\t\t\t\t<p>You may click on an album name to "
echo -en "view all of its files, or click on a specific image to bring up the "
echo -en "full resolution. On the album pages you may also click an image or "
echo -e "video name to pull up the full resolution for download.</p>"
echo -e "\t\t\t</div>"
echo -e "\t\t</div>"

# Display the album names descending.
ls files/photos/ | sort -r | while read album; do
	# Skip files, only read directories.
	if [[ ! -d files/photos/$album ]]; then
		continue
	fi

	# Clean album name.
	album_name=${album}
	album_name=${album_name//_/ }
	album_name=${album_name//-/ }
	echo -e "\t\t<div class='row'>"
	echo -en "\t\t\t<h2 class='col-12 title'>"
	echo -en "<a href='/files/photos/$album/index.html' "
	echo -e "target='_blank' rel='noopener noreferrer'>$album_name</a></h2>"
	echo -e "\t\t</div>"

	# Catch all the upcoming photo records.
	echo -e "\t\t<div class='row'>\n\t\t\t<div class='col-12 text'>"

	# Create index page for each photo ALBUM based on its contents.
	page=""
	subpage="files/photos/$album/index.html"
	$HELPER_DIR/body_open.php > $subpage

	# Add a back button
	echo -en "\n\t\t<div class='row'>\n\t\t\t<a href='/photos'>" >> $subpage
	echo -e "<h3 class='col-12 title'>Back</h3></a>\n\t\t</div>" >> $subpage

	# Build the ALBUM page.
	echo -e "\t\t<div class='row'>" >> $subpage
	echo -e "\t\t\t<h1 class='col-12 title'>$album_name</h1>" >> $subpage
	echo -e "\t\t</div>" >> $subpage

	echo -e "\t\t<div class='row text'>" >> $subpage
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
			echo -e "\t\t\t\t<p>`cat $photo`</p>"
		else
			# Otherwise put in the PHOTOS page list.
			echo -en "\t\t\t\t<li class='indent'><a href=/$photo target='_blank' "
			echo -en "rel='noopener noreferrer'>$filename"
			if [[ $photo == *".mp4" ]]; then
				echo -en " [VIDEO]"
			fi
			echo -e "</a></li>"
		fi

		# Put in the subpage HTML.
		echo -e "\t\t\t<div class='col-6 center'>" >> $subpage
		echo -en "\t\t\t\t<a href=/$photo target='_blank' " >> $subpage
		echo -e "rel='noopener noreferrer'>" >> $subpage
		if [[ $photo == *".mp4" ]]; then
			echo -e "\t\t\t\t\t<video width='320px' controls>" >> $subpage
			echo -e "\t\t\t\t\t\t<source src='/$photo' type=video/mp4>" >> $subpage
			echo -e "\t\t\t\t\t\tYour browser does not support videos." >> $subpage
			echo -e "\t\t\t\t\t</video>" >> $subpage
		elif [[ $photo == *".md" || $photo == *".txt" ]]; then
			echo -e "\t\t\t\t\t<p>`cat $photo`</p>" >> $subpage
		else
			echo -e "\t\t\t\t\t<img src='/$photo'/>" >> $subpage
		fi

		# Add a descriptive link.
		echo -en "\t\t\t\t\t<p>$filename" >> $subpage
		if [[ $photo == *".mp4" ]]; then
			echo -en " [VIDEO]" >> $subpage
		fi
		echo -e "</p>\n\t\t\t\t</a>\n\t\t\t</div>" >> $subpage
	done
	echo -e "\t\t</div>" >> $subpage

	# End album listings on PHOTOS page.
	echo -e "\t\t\t</div>"
	echo -e "\t\t</div>"

	# Add a final back button
	echo -en "\n\t\t<div class='row'>\n\t\t\t<a href='/photos'>" >> $subpage
	echo -e "<h3 class='col-12 title'>Back</h3></a>\n\t\t</div>" >> $subpage

	# Close out the ALBUM's page.
	$HELPER_DIR/body_close.php >> $subpage
done

# Finish the web page.
$HELPER_DIR/body_close.php
