# My Website - Hyperling.com

Custom website rather than using WordPress or anything else that handles the code for you.

Rather than using apache or nginx just using Node.js to serve an HTML API. Gives more control.

Use HTML and PHP files for the content because it sounds fun and I like challenges.

Basically a "page" is just a program that echo's HTML content for the API.

Will likely play with some pages being Bash and other fun things.

All content is formatted so that the page source is readible.

# How To Run

The install script is currently only set up for apt, and the package names only
tested on Ubuntu and Debian.

```
git clone https://github.com/Hyperling/website www
cd www
./run.sh
```

Then in a web browser, navigate to `localhost:8080`.

## TODO

All goals are currently completed.

- ~~Add support for Let's Encrypt without using `nginx` or `apache`.~~
    - Going to continue using a reverse proxy, but may still be nice someday.

## Inspiration

- [Liquorix Kernel](https://liquorix.net/)
  - The linux-zen kernel, a really great one if you're running FOSS OS's!
- [Cahlen.org](https://cahlen.org/)
  - Also has really interesting and important content, it is highly recommended.
- [Merkin Vineyards Osteria](https://merkinvineyardsosteria.com/)
  - A winery website for MJ Keenan.
