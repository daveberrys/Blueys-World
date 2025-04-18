import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

public var blueyTxt:FunkinText;
var blueyTxtTween:FlxTween;

var ratingFC:String = "SFC";

var sick:Int = 0;
var good:Int = 0;
var bad:Int = 0;
var shit:Int = 0;
var hits:Int = 0;

var lerpScore:Int = 0;

var healthText:FunkinText;
var healthMath:FlxMath;
var healthDisplay:Int = 0;

function postCreate() {
    scoreTxt.visible = false;
    missesTxt.visible = false;
    accuracyTxt.visible = false;

    blueyTxt = new FunkinText(0, 100, 10000, "", 0, true);
    blueyTxt.setFormat(Paths.font("bluey.ttf"), 25, 0xFFFFFFFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    blueyTxt.screenCenter(FlxAxes.X);
    blueyTxt.camera = camHUD;
    blueyTxt.antialiasing = true;
    add(blueyTxt);

    healthText = new FunkinText(iconP1.x - 75, iconP1.y - 50, 200, "");
	healthText.setFormat(Paths.font("bluey.ttf"), 30, 0xFFFFFFFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
	healthText.camera = camHUD;
    healthText.antialiasing = true;
	add(healthText);
}

function update(elapsed:Float) {
	healthDisplay = (health * 50);
	healthMath = FlxMath.lerp(healthMath, healthDisplay, elapsed * 10);
	healthText.text = "HP: " + Math.round(healthMath) + "%";

    lerpScore = FlxMath.lerp(lerpScore, songScore, elapsed * 10);
    if (!downscroll) {
        if (hits > 0)
            blueyTxt.text = "SCORE: " + Math.round(lerpScore) + "\nCOMBO BREAKS: " + misses + "\nACCURACY: " + CoolUtil.quantize(accuracy * 100, 100) + "% (" + ratingFC + ")";
        else if (hits < 1)
            blueyTxt.text = "SCORE: 0\nCOMBO BREAKS: 0\nACCURACY: ? (N/A)";
    } else {
        if (hits > 0)
            blueyTxt.text = "ACCURACY: " + CoolUtil.quantize(accuracy * 100, 100) + "% (" + ratingFC + ")" + "\nCOMBO BREAKS: " + misses + "\nSCORE: " + Math.round(lerpScore);
        else if (hits < 1)
            blueyTxt.text = "ACCURACY: ? (N/A)\nCOMBO BREAKS: 0\nSCORE: 0";
    }
}

function onPlayerHit(event) {
	if(misses == 0)
	{
		if (bad > 0 || shit > 0) ratingFC = 'FC';
		else if (good > 0) ratingFC = 'GFC';
		else if (sick > 0) ratingFC = 'SFC';
	}
	else {
		if (misses < 10) ratingFC = 'SDCB';
		else ratingFC = 'Clear';
	}

    if (event.rating == "sick") sick += 1;
    if (event.rating == "good") good += 1;
    if (event.rating == "bad") bad += 1;
    if (event.rating == "shit") shit += 1;
    if (!event.note.isSustainNote) {
        hits += 1;

        if (blueyTxtTween != null) blueyTxtTween.cancel();
        blueyTxt.scale.x = 1.075;
        blueyTxt.scale.y = 1.075;
        blueyTxt.screenCenter(FlxAxes.X);
        blueyTxtTween = FlxTween.tween(blueyTxt.scale, {x: 1, y: 1}, 0.2);
    }
}