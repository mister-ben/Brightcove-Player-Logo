Brightcove Player Logo
======================
SWF and javascript plugins to add a logo overlay to a player to compliment the existing per-video and per-account logos.

#SWF Plugin

The SWF version of the logo will also show when the player is fullscreen.

##To use compiled swf

* Upload swf to your server
* In the [player settings in Video Cloud](http://videocloud.brightcove.com/publishing) add the URL to the swf as a plugin.
* In your publishing code, add a _customLogoUrl_ param with the URL to the image as its value, e.g. `<param name="customLogoUrl" value="http://example.com/myLogo.png" />`.

* Don't forget the server(s) hosting the swf and the images needs a crossdomain.xml Flash policy file at the root.

##Customising and compiling your own swf

Things you might want to change or add include:

* Change the hard-coded default image URL
* Change the logo position
* Use different images in fullscreen

#Javascript plugin

The javascript version of the plugin will never show when the video is fullscreen. It's only possible to overlay an image over the video while it is windowed. On iPhone the video is always fullscreen when it plays.

* Modify `js/htmlPlayerLogo.js` to use your own image file. You may also want to alter the position.
* Host on your server.
* In the [player settings in Video Cloud](http://videocloud.brightcove.com/publishing) add the URL to the js file as a plugin.