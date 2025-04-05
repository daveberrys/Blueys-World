import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.math.FlxMath;

public var scoreText:FunkinText;
public var missText:FunkinText;
public var accuracyText:FunkinText;

var goBackScoreTween:FlxTween;
var goBackAccuracyTween:FlxTween;
var goBackMissesTween:FlxTween;
var goBackMissesTweenColor:FlxTween;

var lerpScore:Int = 0;
var lastAccuracy:Float = 0;

function postCreate() {
    // make the funny Text s!
    scoreText = new FunkinText(100, 100, 0, "", 40, true);
    scoreText.setFormat(Paths.font("bluey.ttf"), 40, 0xFFFFFFFF, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    scoreText.borderSize = 2;
    //scoreText.antialiasing = true;
    scoreText.camera = camHUD;
    add(scoreText);

    missText = new FunkinText(100, 135, 0, "", 30, true);
    missText.setFormat(Paths.font("bluey.ttf"), 30, 0xFFFFFFFF, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    missText.borderSize = 2;
    //missText.antialiasing = true;
    missText.camera = camHUD;
    add(missText);

    accuracyText = new FunkinText(100, 165, 0, "", 30, true);
    accuracyText.setFormat(Paths.font("bluey.ttf"), 30, 0xFFFFFFFF, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    accuracyText.borderSize = 2;
    //accuracyText.antialiasing = true;
    accuracyText.camera = camHUD;
    add(accuracyText);

    if (downscroll) {
        missText.y = 570;
        scoreText.y = 600;
        accuracyText.y = 540;
    }
    else {
        missText.y = 570;
        scoreText.y = 600;
        accuracyText.y = 540;
    }

    // hides CNE hud because i ca-
    scoreTxt.visible = false;
    missesTxt.visible = false;
    accuracyTxt.visible = false;
}

function update(elapsed:Float) {
    // funny math :3
    lerpScore = FlxMath.lerp(lerpScore, songScore, elapsed * 10);
    if (Math.abs(lerpScore - songScore) <= 10)
        lerpScore = songScore;

    // Update shii bla bla bl-
    accuracyText.text = "Accuracy: " + CoolUtil.quantize(accuracy * 100, 100) + "%";
    scoreText.text = "Score: " + Math.round(lerpScore);
    missText.text = "Misses: " + misses;

    // less than 0 ? well you get "?%"!
    if (accuracy < 0)
        accuracyText.text = "Accuracy: ?%";
}

function onPlayerHit(event) {
    if (!event.note.isSustainNote) {
        // Score Text
        if (goBackScoreTween != null) goBackScoreTween.cancel();
        scoreText.x = 100 + 10;
        goBackScoreTween = FlxTween.tween(scoreText, {x: 100}, 1, {ease: FlxEase.expoOut});

        // Accuracy Text
        if (lastAccuracy < accuracy || lastAccuracy > accuracy && lastAccuracy != null) {
            if (goBackAccuracyTween != null) goBackAccuracyTween.cancel();
            accuracyText.x = 100 + 10;
            goBackAccuracyTween = FlxTween.tween(accuracyText, {x: 100}, 1, {ease: FlxEase.expoOut});
        }
        lastAccuracy = accuracy;
    }
}

function onPlayerMiss(event) {
    if (!event.note.isSustainNote) {
        // Score Text
        if (goBackScoreTween != null) goBackScoreTween.cancel();
        scoreText.x = 100 + 10;
        goBackScoreTween = FlxTween.tween(scoreText, {x: 100}, 1, {ease: FlxEase.expoOut});

        // Miss Text
        if (goBackMissesTween != null) goBackMissesTween.cancel();
        if (goBackMissesTweenColor != null) goBackMissesTweenColor.cancel();
        missText.x = 100 + 10;
        missText.color = 0xFFFF0000;
        goBackMissesTween = FlxTween.tween(missText, {x: 100}, 1, {ease: FlxEase.expoOut});
        goBackMissesTweenColor = FlxTween.tween(missText, {color: 0xFFFFFFFF}, 1, {ease: FlxEase.linear});

        // Accuracy Text
        if (lastAccuracy < accuracy || lastAccuracy > accuracy && lastAccuracy != null) {
            if (goBackAccuracyTween != null) goBackAccuracyTween.cancel();
            accuracyText.x = 100 + 10;
            goBackAccuracyTween = FlxTween.tween(accuracyText, {x: 100}, 1, {ease: FlxEase.expoOut});
        }
        lastAccuracy = accuracy;
    }
}