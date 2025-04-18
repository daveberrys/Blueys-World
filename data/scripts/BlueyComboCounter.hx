import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

var returnComboText:FlxTween;
var returnComboText2:FlxTween;
var returnComboText3:FlxTween;

var comboText:FunkinText;
var noteRating:String;
var bCombo:Int = 0;

var yLocation = 200;

var PJsekai = true;

function postCreate() {
    comboGroup.visible = false;

    comboText = new FunkinText(0, 0, 500, "0\nN/A", 40, true);
    comboText.setFormat(Paths.font("bluey.ttf"), 40, 0xFFFFFFFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
    comboText.camera = camHUD;
    comboText.borderSize = 2;
    comboText.alpha = 0;
    //comboText.antialiasing = true;
    comboText.screenCenter();
    comboText.y -= 200;
    add(comboText);
}

function onPlayerHit(event) {
    if (!event.note.isSustainNote) {
        if (event.rating == "sick") {
            noteRating = "Dollarbucks!";
            comboText.color = 0xFF419FFF;
        }
        if (event.rating == "good") {
            noteRating = "Woah";
            comboText.color = 0xFF00FF80;
        }
        if (event.rating == "bad") {
            noteRating = "Okay";
            comboText.color = 0xFFFFFF6D;
        }
        if (event.rating == "shit") {
            noteRating = "Aw biscuits...";
            comboText.color = 0xFF808080;
        }

        if (bCombo < 0)
            bCombo = 0;

        // thought it would be funny if my second favourite rhythm game was here lmao
        if (PJsekai) {
            if (event.rating == "sick" || event.rating == "good")
                bCombo += 1;
            if (event.rating == "bad" || event.rating == "shit")
                bCombo = 0;
        } else {
            bCombo += 1;
        }
        comboText.text = noteRating + "\n" + bCombo;
        combo = bCombo;
        hit();
    }
}
function onPlayerMiss(event) {
    if (!event.note.isSustainNote) {
        if (bCombo > 0)
            bCombo = 0;
        bCombo -= 1;
        comboText.color = 0xFFB50000;
        comboText.text = "Missed...\n" + bCombo;
        combo = bCombo;
        hit();
    }
}

function hit() {
    if (returnComboText != null) returnComboText.cancel();
    if (returnComboText2 != null) returnComboText2.cancel();
    if (returnComboText3 != null) returnComboText3.cancel();

    comboText.alpha = 1;
    if (downscroll) {
        comboText.y = yLocation + 10;
        returnComboText = FlxTween.tween(comboText, {y: yLocation}, 1, {ease: FlxEase.expoOut});
        returnComboText2 = FlxTween.tween(comboText, {y: yLocation - 100}, 0.5, {ease: FlxEase.expoIn, startDelay: 1});
        returnComboText3 = FlxTween.tween(comboText, {alpha: 0}, 0.5, {ease: FlxEase.linear, startDelay: 1});
    } else {
        comboText.y = yLocation - 10;
        returnComboText = FlxTween.tween(comboText, {y: yLocation}, 1, {ease: FlxEase.expoOut});
        returnComboText2 = FlxTween.tween(comboText, {y: yLocation + 100}, 0.5, {ease: FlxEase.expoIn, startDelay: 1});
        returnComboText3 = FlxTween.tween(comboText, {alpha: 0}, 0.5, {ease: FlxEase.linear, startDelay: 1});
    }
}