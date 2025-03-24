import funkin.backend.utils.WindowUtils;
WindowUtils.winTitle = "Friday Night Funkin' - Bluey's World";

function new() {
    FlxG.save.data.blueysWorldBlackFade ??= true;
    FlxG.save.data.blueysWorldFollowDirectionCam ??= true;
}