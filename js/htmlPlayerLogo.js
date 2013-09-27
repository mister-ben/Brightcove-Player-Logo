(function() {
 
    function onPlayerReady() {
        var overlay = videoPlayer.overlay();
        $(overlay).html('<img id="overlaylogo" src="http://cs1.brightcodes.net/ben/img/genericlogo.png" />')
            .css({
                position:"relative"
            });
        $("#overlaylogo").css({
            position:"absolute",
            bottom:"50px",
            right:"10px"
        });
    }
 
    player = brightcove.api.getExperience();
    videoPlayer = player.getModule(brightcove.api.modules.APIModules.VIDEO_PLAYER);
    experience = player.getModule(brightcove.api.modules.APIModules.EXPERIENCE);
 
    if (experience.getReady()) {
        onPlayerReady();
    } else {
        experience.addEventListener(brightcove.player.events.ExperienceEvent.TEMPLATE_READY, onPlayerReady);
    }
 
}());