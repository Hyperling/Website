#!/usr/bin/php
<?php
	include "header.php";
?>

	<body>

<?php
	include "banner.php";
	include "menu.php";
	if ($GLOBALS["ADVISORY"] !== false)
		include "advisory.php";
?>
