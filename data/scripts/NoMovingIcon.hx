import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

// You can change these!
var fakeIconBop:Bool = true;
var fakeIconScaleWhen:String = "OnHit"; // "OnHit", "OnBeat"
var fakeIconDuration:Int = 0.5;
var fakeWinningIcon:Bool = true;
var fakeIconBeat:Int = 1;

// From this point on, do not change anything here unless you know what you're doing !
public var fakeIconOpponent:FlxSprite;
public var fakeIconPlayer:FlxSprite;

public var varFakeIconOpponent:String = dad.icon;
public var varFakeIconPlayer:String = boyfriend.icon;

var scaleDownOnPlayer:FlxTween;
var scaleDownOnOpponent:FlxTween;

var fakeIconOpponentAlphaTweenA:FlxTween; // APPEAR
var fakeIconPlayerAlphaTweenA:FlxTween; // APPEAR

var fakeIconOpponentAlphaTweenH:FlxTween; // HIDE
var fakeIconPlayerAlphaTweenH:FlxTween; // HIDE

var fakeIconOpponentAlphaTweenHT:FlxTimer; // HIDE TIMER
var fakeIconPlayerAlphaTweenHT:FlxTimer; // HIDE TIMER

function postCreate() {
	// Creates the Fake Icon
	iconP1.visible = false;
	iconP2.visible = false;
	healthBar.visible = false;
	healthBarBG.visible = false;

	fakeIconOpponent = new FlxSprite(iconP2.x - 10, iconP2.y - 50).loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent));
	fakeIconOpponent.camera = camHUD;
	fakeIconOpponent.antialiasing = true;
	insert(16, fakeIconOpponent);

	fakeIconPlayer = new FlxSprite(iconP1.x + 10, iconP1.y - 50).loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer));
	fakeIconPlayer.camera = camHUD;
	fakeIconPlayer.antialiasing = true;
	fakeIconPlayer.flipX = true;
	insert(16, fakeIconPlayer);

	new FlxTimer().start(0.5, function(tmr:FlxTimer) {
		fakeIconOpponentAlphaTween = FlxTween.tween(fakeIconOpponent, {alpha: 0.5}, 0.5);
	});

	new FlxTimer().start(0.5, function(tmr:FlxTimer) {
		fakeIconPlayerAlphaTween = FlxTween.tween(fakeIconPlayer, {alpha: 0.5}, 0.5);
	});
}

function beatHit(curBeat:Int) {
	if (fakeIconBop && curBeat % fakeIconBeat == 0 && fakeIconScaleWhen == "OnBeat") {
		if (scaleDownOnPlayer != null)
			scaleDownOnPlayer.cancel();
		if (scaleDownOnOpponent != null)
			scaleDownOnOpponent.cancel();

		fakeIconPlayer.scale.set(1.2, 1.2);
		fakeIconOpponent.scale.set(1.2, 1.2);
		scaleDownOnPlayer = FlxTween.tween(fakeIconPlayer, {"scale.x": 1, "scale.y": 1}, fakeIconDuration, {ease: FlxEase.expoOut});
		scaleDownOnOpponent = FlxTween.tween(fakeIconOpponent, {"scale.x": 1, "scale.y": 1}, fakeIconDuration, {ease: FlxEase.expoOut});
	}
}

function postUpdate(elapsed:Float) {
	// DAD
	if (health > 1.5) {
		fakeIconOpponent.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent + "-losing"));
		if (fakeWinningIcon)
			fakeIconPlayer.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer + "-winning"));
	} else if (health < 1.5 && health > 0.5)
		fakeIconOpponent.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent));

	// BF
	if (health < 0.5) {
		fakeIconPlayer.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer + "-losing"));
		if (fakeWinningIcon)
			fakeIconOpponent.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconOpponent + "-winning"));
	} else if (health > 0.5 && health < 1.5) {
		fakeIconPlayer.loadGraphic(Paths.image("icons/fakeicon/" + varFakeIconPlayer));
	}
}

function onPlayerHit(e) {
	if (fakeIconScaleWhen == "OnHit" && !e.note.isSustainNote) {
		if (scaleDownOnPlayer != null)
			scaleDownOnPlayer.cancel();
		
		fakeIconPlayer.scale.set(1.2, 1.2);
		scaleDownOnPlayer = FlxTween.tween(fakeIconPlayer, {"scale.x": 1, "scale.y": 1}, fakeIconDuration, {ease: FlxEase.expoOut});
	}
    if (fakeIconPlayerAlphaTweenHT != null) fakeIconPlayerAlphaTweenHT.cancel();
    if (fakeIconPlayerAlphaTweenH != null) fakeIconPlayerAlphaTweenH.cancel();

	fakeIconPlayerAlphaTweenA = FlxTween.tween(fakeIconPlayer, {alpha: 1}, 0.5);
	fakeIconPlayerAlphaTweenHT = new FlxTimer().start(0.5, function(tmr:FlxTimer) {
        if (fakeIconPlayerAlphaTweenA != null) fakeIconPlayerAlphaTweenA.cancel();
		fakeIconPlayerAlphaTweenH = FlxTween.tween(fakeIconPlayer, {alpha: 0.5}, 0.5);
	});
}

function onDadHit(e) {
	if (fakeIconScaleWhen == "OnHit" && !e.note.isSustainNote) {
		if (scaleDownOnOpponent != null)
			scaleDownOnOpponent.cancel();

		fakeIconOpponent.scale.set(1.2, 1.2);
		scaleDownOnOpponent = FlxTween.tween(fakeIconOpponent, {"scale.x": 1, "scale.y": 1}, fakeIconDuration, {ease: FlxEase.expoOut});
	}
    if (fakeIconOpponentAlphaTweenHT != null) fakeIconOpponentAlphaTweenHT.cancel();
    if (fakeIconOpponentAlphaTweenH != null) fakeIconOpponentAlphaTweenH.cancel();
    
	fakeIconOpponentAlphaTweenA = FlxTween.tween(fakeIconOpponent, {alpha: 1}, 0.5);
	fakeIconOpponentAlphaTweenHT = new FlxTimer().start(0.5, function(tmr:FlxTimer) {
        if (fakeIconOpponentAlphaTweenA != null) fakeIconOpponentAlphaTweenA.cancel();
		fakeIconOpponentAlphaTweenH = FlxTween.tween(fakeIconOpponent, {alpha: 0.5}, 0.5);
	});
}
