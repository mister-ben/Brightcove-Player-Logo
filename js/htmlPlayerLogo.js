(function() {
 
    function onPlayerReady() {
        var overlay = videoPlayer.overlay();
        $(overlay).html('<img id="overlaylogo" src="http://cs1.brightcodes.net/ben/img/genericlogo.png" />')
            .css({
                position:"fixed",
                height:"100%",
                width:"100%"
            });
        $("#overlaylogo").css({
            position:"absolute",
            bottom:"50px",
            right:"10px"
        });
    }
 
    var _player = brightcove.api.getExperience();
    var videoPlayer = _player.getModule(brightcove.api.modules.APIModules.VIDEO_PLAYER);
    var experience = _player.getModule(brightcove.api.modules.APIModules.EXPERIENCE);
 
    if (experience.getReady()) {
        onPlayerReady();
    } else {
        experience.addEventListener(brightcove.player.events.ExperienceEvent.TEMPLATE_READY, onPlayerReady);
    }
 
}());
