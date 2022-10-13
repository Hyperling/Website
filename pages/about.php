#!/usr/bin/php

<?php
	include "helpers/body_open.php";
?>
		<div class="row col-12 title">
			<h1>Curious About Me?</h1>
			<p> 
				Hi there! My name is Chad, I am the primary content creator behind the
				Hyperling and HyperVegan brands. Thank you for your interest!
			</p>
			<p>	
				My hobbies go further than just coding and video making. I am big into 
				health and believe it is humanity's most important asset. I was fortunate 
				to have time off school/work/hobbies in my early 20's was able to lock 
				in a great lifestyle after a life of chronic sickness. See more below in 
				<a href="#health">My Health Protocol</a>, it also includes a link to the 
				full history.
			</p>
			<p>	
				I am also an avid gardener, focusing on the principles of nature-based 
				permaculture in order to grow fruits and vegetables, like in a Food 
				Forest system. This comes with other outdoor interests such as hiking, 
				camping, backpacking, foraging, and traveling. 
			</p>
			<p>	
				For all of my life I have resided in Indiana, USA, but in Spring 2023 I 
				am making a big leap and heading to the southwest, most likely Arizona
				or Colorado. The humidity in the midwest is miserable and the terrain
				is flat and boring. There are all sorts of insect pests and the ground
				is so fertile that yard grass takes over a garden in a jiffy. I look 
				forward to the challenge of growing food in the new climate, but also
				plan to reduce costs by living outdoors. Home ownership isn't for me.
			</p>
		</div>	

<?php
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
