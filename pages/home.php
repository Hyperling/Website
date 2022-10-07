#!/usr/bin/php

<?php
	include "helpers/body_open.php";
?>

		<h1>Welcome!</h1>
		<p> 
			Website is still in testing. Don't judge too harshly. :)
		</p>

<?php
	include "helpers/section_open.php";
	include "subpages/home/apps.php";
	include "helpers/section_close.php";

	include "helpers/section_open.php";
	include "subpages/home/health.php";
	include "helpers/section_close.php";

	include "helpers/section_open.php";
	include "subpages/home/contact.php";
	include "helpers/section_close.php";

	include "helpers/body_close.php";
?>
