#!/usr/bin/php
<!--
	Landing page, keeping it apps and development projects like old WordPress site.
-->
<?php
	include "helpers/body_open.php";
?>

			<div class="row">
				<h1 class="col-12 title">Welcome!</h1>
			</div>
			<div class="row">
				<div class="col-12 header center" >
					<img src="/files/media/icons/20230423165239277_Chad-on-the-mountains.shrunk20230831.resized20240125_16x9.jpg">
				</div>
			</div>
			<div class="row">
				<div class="col-12 text">
					<p>
						Thank you for visiting my site! My goal is to make the world a
						better place. Hopefully you find content here which helps
						empower you to do the same!
					</p>
				</div>
			</div>

<?php
	include "subpages/home/apps.php";

	include "helpers/body_close.php";
?>
