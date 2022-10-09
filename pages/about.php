#!/usr/bin/php

<?php
	include "helpers/body_open.php";
?>
		<div class="row col-12 title">
			<h1>Curious About Me?</h1>
			<p> 
				TBD
			</p>
		</div>	

<?php
	include "helpers/section_open.php";
	include "subpages/about/whoami.php";
	include "helpers/section_close.php";

	include "helpers/section_open.php";
	include "subpages/about/health.php";
	include "helpers/section_close.php";

	include "helpers/section_open.php";
	include "subpages/home/contact.php";
	include "helpers/section_close.php";

	include "helpers/section_open.php";
	include "subpages/about/stance.php";
	include "helpers/section_close.php";

	include "helpers/section_open.php";
	include "subpages/about/notice.php";
	include "helpers/section_close.php";

	include "helpers/body_close.php";
?>
