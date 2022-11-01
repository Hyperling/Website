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
				<div class="col-12 text">
					<p> 
						Thanks for visiting my site! It is the central hub of my activities, 
						linking you to most of my projects and providing ways to contact and 
						support me. I've also included information such as my health protocol 
						which was currently only scattered throughout videos.
					</p>
				</div>
			</div>

<?php
	include "subpages/home/apps.php";

	include "helpers/body_close.php";
?>
