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
					Your contributions are completely optional and very much
					appreciated. Thank you for considering me and my work!
				</p>
			</div>
		</div>

<?php
	include "subpages/support/donate.php";
	include "subpages/support/gifts.php";

	include "helpers/body_close.php";
?>
