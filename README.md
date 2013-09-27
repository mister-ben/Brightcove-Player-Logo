Brightcove Player Logo
======================
SWF plugin to add a logo overlay to a player.

#To use compiled swf

* Upload swf to your server
* In the [player settings in Video Cloud](http://videocloud.brightcove.com/publishing) add the URL to the swf as a plugin
* In your publishing code, add a _customLogoUrl_ param with the URL to the image as its value, e.g. `<param name="customLogoUrl" value="http://example.com/myLogo.png" />`.

* Don't forget the server(s) hosting the swf and the images needs a crossdomain.xml Flash policy file at the root.

#To customise and compile your own swf

Things you might want to change or add include:

* Change the hard-coded default image URL
* Change the logo position
* Use different images in fullscreen