#!/usr/bin/php

<?php
	include "helpers/body_open.php";
?>

		<h1> Welcome! </h1>
			
		<p> This is a test. It can be ignored. :) </p>

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
