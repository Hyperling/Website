#!/usr/bin/node
'use strict';
/*
	2022-09-14 Hyperling
	Coding my own website rather than using WordPress or anything bloaty.
*/

//// Libraries ////

let express = require('express');
let app = express();

const execSync = require('child_process').execSync;

const fs = require('fs');

//// Global Variables ////

const DEBUG = false;

const app_name = "hyperling.com";

let pages = [];
const pages_dir = "./pages/";
const file_types = ["php", "sh"];

let ports = [];
ports.push(8080);

//// Functions ////

async function main() {
	console.log("...Starting Main...");

	console.log("Set app to return HTML documents.");
	app.use(function (req, res, next) {
		res.contentType('text/html');
		next();
	});

	/* Loop through all file in the pages subdirectory and add the allowed
	// file types into the pages array for automatic router creation.
	*/
	console.log("...Starting Main...");
	let ls = await fs.promises.readdir(pages_dir);
	if (DEBUG) console.log("DEBUG:  Results of ls, ", ls);
	for (let file of ls) {
		let file_test = file.split(".");
		let file_name = file_test[0];
		let file_type = file_test[file_test.length - 1];
		if (file_types.includes(file_type)) {
			if (DEBUG) console.log("DEBUG:  Hooray!", file, "is being added.");
			pages[file_name] = pages_dir + file;
			console.log(" * Added page", file);
		} else {
			if (DEBUG) console.log("DEBUG: ", file, "is not an approved type, skipping.");
		}
	}
	console.log(" * Pages loaded: ", pages);
	//return; // Stop execution FORTESTING

	console.log("...Adding Routes...");
	let router = express.Router();

	/* AUTOMATIC METHOD BASED ON OBJECT/ARRAY OF PHP scripts 
	// Creates routes with the URL of the key and location of the value.
	*/
	for (let key in pages) {
		console.log(" * Creating router for", key);
		router.get("/" + key, function (req,res) {
			console.log(key, "fulfilling request to", req.socket.remoteAddress, "asking for", req.url)
			res.send(execSync(pages[key]));
		});
	}

	// Provide css.
	router.get('/main.css', function (req, res) {
		console.log("css being provided to", req.socket.remoteAddress)
		let html = execSync("cat ./pages/main.css");
		res.send(html);
	});

	// Originally a test, now a catch-all redirection to Home!
	router.get('/*', function (req, res) {
		// WARNING: These are huge so only look when you need to.
		//console.log(req);
		//console.log(res);
		console.log("*wildcard* replying to", req.socket.remoteAddress, "asking for", req.url)
		let html = execSync("./pages/home.php");
		res.send(html);
	});

	app.use('', router);

	console.log("...Adding Ports...");
	ports.forEach(port => {
		app.listen(port);
		console.log(" * Now listening on port " + port + ".");
	});
	console.log("Done! Now we wait...");
}

//// Program Execution ////

main();
