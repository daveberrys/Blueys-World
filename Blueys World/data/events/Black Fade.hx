var blueysWorldBlackFade = FlxG.save.data.blueysWorldBlackFade;
var blackOther:FlxSprite;

function postCreate() {
    blackOther = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
    blackOther.camera = camHUD;
    if (blueysWorldBlackFade)
        add(blackOther);
}

function onSongStart() {
    FlxTween.tween(blackOther,{alpha:0}, 2, {ease:FlxEase.linear});
}

function onEvent(e) {
    if (e.event.name == "Black Fade") {
        var params:Array = e.event.params;
        if (params[1] == "On") {
            FlxTween.tween(blackOther,{alpha:1}, params[0], {ease:FlxEase.linear});
        }
        if (params[1] == "Off") {
            FlxTween.tween(blackOther,{alpha:0}, params[0], {ease:FlxEase.linear});
        }
    }
}
