# Hyperling.com - files/

Place files into this folder which should be used as static resources.
Examples would be APKs, zip files, images, text files, etc.

For example, if `test.jpg` was placed here, it could be accessed via
`http://localhost:8080/files/test.jpg`. Depending on the file type the MIME type
may be detected automatically, otherwise it will be assumed a text file and
most likely ask to be downloaded by the browser.
