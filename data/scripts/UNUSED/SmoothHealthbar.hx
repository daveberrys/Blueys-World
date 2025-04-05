// hi, smooth healthbar was made by daveberry, please credit :3 ( daveberry.netlify.app )
// I know i could've done a better way of doing a smooth healthbar, but let me feel proud since this is my first time using haxe :catfakyou:

// You can change these!
var fakeIconBop:Bool = true;
var fakeIconBeat:Int = 1;
var fakeIconDuration:Int = 0.5;

var fakeWinningIcon:Bool = true;

// From this point on, do not change anything here unless you know what you're doing !
public var fakeIconOpponent:FlxSprite;
public var fakeIconPlayer:FlxSprite;

public var varFakeIconOpponent:String = dad.icon;
public var varFakeIconPlayer:String = boyfriend.icon;

var fakeIconOpponentMath:FlxMath;
var fakeIconPlayerMath:FlxMath;

var fakeIconPlayerInt:Int;
var fakeIconOpponentInt:Int;

var scaleDownOnPlayer:FlxTween;
var scaleDownOnOpponent:FlxTween;

function postCreate() {
    doIconBop = false; // Disables Icon Bop !

    // Creates the Fake Icon
    iconP1.visible = false;
    iconP2.visible = false;

    fakeIconOpponent = new FlxSprite(iconP2.x, iconP2.y).loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent));
    fakeIconOpponent.camera = camHUD;
    fakeIconOpponent.antialiasing = true;
    add(fakeIconOpponent);

    fakeIconPlayer = new FlxSprite(iconP1.x, iconP1.y).loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer));
    fakeIconPlayer.camera = camHUD;
    fakeIconPlayer.antialiasing = true;
    fakeIconPlayer.flipX = true;
    add(fakeIconPlayer);
}

function beatHit(curBeat:Int) {
    if (fakeIconBop && curBeat % fakeIconBeat == 0) {
        if (scaleDownOnPlayer != null) scaleDownOnPlayer.cancel();
        if (scaleDownOnOpponent != null) scaleDownOnOpponent.cancel();
    
        fakeIconPlayer.scale.set(1.2, 1.2);
        fakeIconOpponent.scale.set(1.2, 1.2);
        scaleDownOnPlayer = FlxTween.tween(fakeIconPlayer, {"scale.x": 1, "scale.y": 1}, fakeIconDuration, {ease: FlxEase.expoOut});
        scaleDownOnOpponent = FlxTween.tween(fakeIconOpponent, {"scale.x": 1, "scale.y": 1}, fakeIconDuration, {ease: FlxEase.expoOut});
    }
}

function onDadHit(event) {
    fakeIconOpponentInt = 20;
    fakeIconPlayerInt = 10;
}
function onPlayerMiss(event) {
    fakeIconOpponentInt = 20;
    fakeIconPlayerInt = 10;
}
function onPlayerHit(event) {
    fakeIconOpponentInt = 10;
    fakeIconPlayerInt = 20;
}

function postUpdate(elapsed:Float) {
    if (fakeIconOpponentMath == 0 && fakeIconPlayerMath == 0) {
        fakeIconOpponentMath = iconP2.x;
        fakeIconPlayerMath = iconP1.x;
    }

    // UPDAING THE x POS OF HEALTH ICON
    fakeIconOpponentMath = FlxMath.lerp(fakeIconOpponentMath, iconP2.x, elapsed * fakeIconOpponentInt);
    fakeIconOpponent.x = fakeIconOpponentMath;
    fakeIconPlayerMath = FlxMath.lerp(fakeIconPlayerMath, iconP1.x, elapsed * fakeIconPlayerInt);
    fakeIconPlayer.x = fakeIconPlayerMath;

    // DAD
    if (health > 1.5) {
        fakeIconOpponent.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent + "-losing"));
        if (fakeWinningIcon)
            fakeIconPlayer.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer + "-winning"));
    }
    else if (health < 1.5 && health > 0.5)
        fakeIconOpponent.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent));

    // BF
    if (health < 0.5) {
        fakeIconPlayer.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer + "-losing"));
        if (fakeWinningIcon)
            fakeIconOpponent.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent + "-winning"));
    }
    else if (health > 0.5 && health < 1.5)
        fakeIconPlayer.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer));
}