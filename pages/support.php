#!/usr/bin/php
<!--
	Page to provide ways people can support me.
-->
<?php
	include "helpers/body_open.php";
?>

		<div class="row">
			<h1 class="col-12 title">Support</h1>
		</div>
		<div class="row">
			<div class="col-12 text">
				<p>	
					While I do not ask for anything, and prefer to take care of myself,
					I acknowledge that some people enjoy gift giving and would like to
					help me out. Below are my preferred ways to do this.
				</p>
			</div>
		</div>

<?php
	include "subpages/support/gifts.php";
	include "subpages/support/donate.php";

	include "helpers/body_close.php";
?>
