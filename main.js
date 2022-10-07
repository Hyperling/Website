#!/usr/bin/node
'use strict';

/*
2022-09-14 Mockup of what a web server may look like.
Should serve very quick since it's all from scratch, nothing to load like WordPress. 
May even skip out on things like 
*/

const app_name = "www.example.com";
let express = require('express');
let app = express();

const execSync = require('child_process').execSync;

let pages = {};
pages.home = require('./pages/home.js');
//pages.notice = require('./pages/notice.js');

let pages_php = {};
pages.home = './pages/home.php';
//pages.notice = './pages/notice.php';

// Even better, look through ./pages/ for *.php or *.js and add them to the array!

let ports = [];
ports.push(8080);

async function main() {
	console.log("Starting Main");

	app.use(function (req, res, next) {
		res.contentType('text/html');
		next();
	});

	console.log("Adding Routes");
	let router = express.Router();
/* MANUAL METHOD, SPECIFY EVERY PATH+FILE
	router.get('/', function (req, res) {
		console.log("Fetching");
		require('lib/home.js'); // one way, maybe?
	});
	router.get('/notice', function (req, res) {
		pages.notice(req, res); // another way?
	});
*/
/* AUTOMATIC METHOD BASED ON OBJECT/ARRAY
	for page in pages { // FORTESTING pseudocode
		router.get("/" + page.key, function (req,res) {
			page.value(req, res);
		});
	}
*/
/* AUTOMATIC METHOD BASED ON OBJECT/ARRAY OF PHP scripts
	for page in pages { // FORTESTING pseudocode
		router.get("/" + page.key, function (req,res) {
			res.send(system("php page.value"));
		});
	}
*/
	// Test (Also a decent catch-all to Home!)
	router.get('/*', function (req, res) {
		//console.log(req);
		//console.log(res);
		console.log(req.socket.remoteAddress, "asked for", req.url)
		let html = execSync("php ./pages/home.php");
		res.send(html);
	});

	app.use('', router);

	console.log("Adding Ports");
	ports.forEach(port => {
		app.listen(port);
		console.log(" * Now listening on port " + port + ".");
	});
	console.log("Done! Now we wait...");
}

main();
