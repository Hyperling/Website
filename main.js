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
// Check parameters for numeric port numbers.
process.argv.forEach(function (val, index, array) {
	console.log("Parameter", index + ':', val, !isNaN(val));
	if (!isNaN(val)) {
		console.log("Adding Port", val)
		ports.push(val);
	}
});
// Default port if none were passed.
if (ports.length === 0) {
	ports.push(8080);
}

const stringsToRemove = [
	RegExp("#!/usr/bin/php\n", "g")
]

//// Functions ////

/* Code exists inside a main function so that we may use async/await.
*/
async function main() {
	console.log("...Starting Main...");

	// Getting dates in Node.js is awful, just use Linux.
	const start_datetime = "" + await execSync('date "+%Y-%m-%dT%H:%M:%S%:z"');
	const start_datetime_trimmed = start_datetime.trim();

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

	/* Create both an XML and HTML sitemap based on these entries. XML is used for
	// bots like SEO scrapers. HTML will be for human users looking for a list of
	// all pages. Some are not in the menu. Generated an example XML sitemap at
	// www.xml-sitemaps.com then stripped it apart and made it dynamic.
	*/
	let sitemap_xml = `<?xml version="1.0" encoding="UTF-8"?>
		<urlset
			xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
					http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
		>
			<url>
				<loc>https://hyperling.com/</loc>
				<lastmod>`+start_datetime_trimmed+`</lastmod>
				<priority>1.00</priority>
			</url>
			<url>
				<loc>https://hyperling.com/sitemap/</loc>
				<lastmod>`+start_datetime_trimmed+`</lastmod>
				<priority>0.80</priority>
			</url>
	`;
	let sitemap_html = `
		<html><body>
			<strong>Special Pages</strong>
			<ul>
				<li>
					<b>Main Site</b>
					(<a href="/">Local</a>)
					(<a href="https://`+app_name+`/">Hardlink</a>)
				</li>
				<li>
					<b>XML Site Map</b>
					(<a href="/sitemap.xml">Local</a>)
					(<a href="https://`+app_name+`/sitemap.xml">Hardlink</a>)
				</li>
				<li>
					<b>HTML Site Map</b>
					(<a href="/sitemap/">Local</a>)
					(<a href="https://`+app_name+`/sitemap/">Hardlink</a>)
					<i>[You are here!]</i>
				</li>
			</ul>
			<strong>Web Pages (Alphabetical)</strong>
			<ul>
	`;

	console.log("...Adding Routes...");
	let router = express.Router();

	/* AUTOMATIC METHOD BASED ON OBJECT/ARRAY OF WEB SCRIPTS
	// Creates routes with the URL of the key and location of the value.
	*/
	for (let key in pages) {
		console.log(" * Creating router for", key);
		router.get("/" + key, function (req,res) {
			console.log(key, "fulfilling request to", req.socket.remoteAddress, "asking for", req.url);
			let html = "" + execSync(pages[key]);
			stringsToRemove.forEach(string => {
				html = html.replace(string, "");
			});
			res.send(html);
		});

		/* Append the page to the sitemap variables.
		*/
		console.log(" * * Adding to sitemap.xml");
		sitemap_xml = sitemap_xml + `
				<url>
					<loc>https://hyperling.com/`+key+`/</loc>
					<lastmod>`+start_datetime_trimmed+`</lastmod>
					<priority>0.80</priority>
				</url>
		`;
		console.log(" * * Adding to sitemap.html");
		sitemap_html = sitemap_html + `
				<li>
					<b>`+key+`</b>
					(<a href="/`+key+`/">Local</a>)
					(<a href="https://`+app_name+`/`+key+`/">Hardlink</a>)
				</li>
		`;
	}

	/* Close the sitemap variables
	*/
	sitemap_xml = sitemap_xml + `
		</urlset>
	`;
	sitemap_html = sitemap_html + `
		</ul></body></html>
	`;

	// Provide sitemap.xml file for "SEO".
	console.log(" * Creating router for sitemap.xml");
	router.get('/sitemap.xml', function (req, res) {
		console.log("sitemap.xml being provided to", req.socket.remoteAddress)
		res.contentType('text/xml');
		res.send(sitemap_xml);
	});

	// Provide human-usable sitemap links.
	console.log(" * Creating router for sitemap*");
	router.get('/sitemap*', function (req, res) {
		console.log("sitemap.html being provided to", req.socket.remoteAddress)
		res.send(sitemap_html);
	});

	// Return a resource from the files folder.
	console.log(" * Creating router for files");
	router.get('/files*', function (req, res) {
		console.log("file response to", req.socket.remoteAddress, "asking for", req.url)

		// Build variables.
		const file = "." + req.path;
		const extensions = req.path.split(".");
		const extension = extensions[extensions.length-1];

		// Check extension and guess a MIME type.
		let mime;
		switch (extension) {
			case "apk":
				mime = "application/vnd.android.package-archive";
				break;
			case "jpg" || "jpeg":
				mime = "image/jpeg";
				break;
			case "png":
				mime = "image/png";
				break;
			case "html":
				mime = "text/html";
				break;
			default:
				mime = "text/*";
				break;
		}

		// Return the file
		res.contentType(mime);
		let f = fs.createReadStream(file)
			.on("error", function(e) {
				res.contentType("text/plain");
				res.send(404, "File Not Found");
			})
			.pipe(res)
		;
	});

	// Originally a test, now a catch-all redirection to Home!
	console.log(" * Creating router for redirection");
	router.get('/*', function (req, res) {
		// WARNING: These are huge so only look when you need to.
		//console.log(req);
		//console.log(res);
		console.log("*wildcard* replying to", req.socket.remoteAddress, "asking for", req.url)
		let html = "" + execSync("./pages/home.php");
		stringsToRemove.forEach(string => {
			html = html.replace(string, "");
		});
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
