var ecamGame:Bool;
var ecamHUD:Bool;
var ezoom:Int;
var ebeat:Int;

function onEvent(e) {
    if (e.event.name == "Camera Beat") {
        ecamGame = e.event.params[0];
        ecamHUD = e.event.params[1];
        ezoom = e.event.params[2];
        ebeat = e.event.params[3];
    }
}

var camGameTween:FlxTween;
var camHUDTween:FlxTween;
var previousCGInt:Int;
function beatHit(curBeat:Int) {
    if (curBeat % ebeat == 0) {
        if (camGameTween != null) camGameTween.cancel();
        if (camHUDTween != null) camHUDTween.cancel();
        
        if (ecamGame) {
            previousCGInt = camGame.zoom;
            camGame.zoom += ezoom;
            camGameTween = FlxTween.tween(camGame, {zoom: 1}, previousCGInt, {ease: FlxEase.expoOut});
        } if (ecamHUD) {
            camHUD.zoom += ezoom;
            camHUDTween = FlxTween.tween(camHUD, {zoom: 1}, 1, {ease: FlxEase.expoOut});
        }
    }
}