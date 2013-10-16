Brightcove Player Logo
======================
These SWF and javascript plugins add logo overlays to a Video Cloud player to compliment the existing options to add logos per-video and per-account.

_Not made or supported by Brightcove_

##SWF Plugin

The SWF version of the logo will show even when the player is fullscreen. The logo is hidden during while an ad is playing and whenever the player menu is open.

###To use compiled swf

* Upload the swf from the _bin-debug_ folder to your server
* Either add as a player plugin:
    *  In the [player settings in Video Cloud](http://videocloud.brightcove.com/publishing) add the URL to the swf as a plugin
* Or add it to a BEML template:
    * Add `<SWFLoader src=""http://example.com/PlayerLogo.swf" />` to the template
* In your publishing code, add a _customLogoUrl_ param with the URL to the image as its value, e.g. `<param name="customLogoUrl" value="http://example.com/myLogo.png" />`.

* The server(s) hosting the swf and the images needs to have a [Flash crossdomain security policy file](http://support.brightcove.com/en/video-cloud/docs/cross-domain-security-flash) at the root.

###Customising and compiling your own swf

Things you might want to change or add include:

* Change the hard-coded default image URL
* Change the logo position
* Use different images in fullscreen

##Javascript plugin

The javascript version of the plugin will never show when the video is fullscreen. It is only possible to overlay an image over the video while it is windowed. On iPhone the video is always fullscreen when it plays.

* Modify `js/htmlPlayerLogo.js` to use your own image file. You may also want to alter the position.
* Host on your server.
* In the [player settings in Video Cloud](http://videocloud.brightcove.com/publishing) add the URL to the js file as a plugin.