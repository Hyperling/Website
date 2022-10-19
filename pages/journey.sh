#!/bin/bash

# Move to the directory that this file is in.
cd `dirname $0`

# Create the necessary HTML components for a web page.
./helpers/body_open.php

#Content for this page
cat << EOF
		<div class="row">
			<h1 class="col-12 title">
				My Journey
			</h1>
			<p class="col-12 text">
				[ TBD, check back soon. ]
			</p>
		</div>
EOF

# Any subpages
###./helpers/section_open.php
###./subpages/journey/???
###./helpers/section_close.php

# Finish the web page
./helpers/body_close.php
