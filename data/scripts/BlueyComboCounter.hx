import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

var returnComboText:FlxTween;
var returnComboText2:FlxTween;
var returnComboText3:FlxTween;

var comboText:FunkinText;
var noteRating:String;
var bCombo:Int = 0;

function postCreate() {
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
        if (event.rating == "sick")
            noteRating = "Dollarbucks!";
        if (event.rating == "good")
            noteRating = "Woah";
        if (event.rating == "bad")
            noteRating = "Okay";
        if (event.rating == "shit")
            noteRating = "Aw biscuits...";
        bCombo += 1;
        comboText.text = bCombo + "\n" + noteRating;
    }
    doesFunny();
}
function onPlayerMiss(event) {
    if (!event.note.isSustainNote) {
        bCombo = 0;
        comboText.text = bCombo + "\nMissed...";
    }
    doesFunny();
}

function doesFunny() {
    if (returnComboText != null) returnComboText.cancel();
    if (returnComboText2 != null) returnComboText2.cancel();
    if (returnComboText3 != null) returnComboText3.cancel();
    comboText.y = 140 + 10;
    comboText.alpha = 1;
    returnComboText = FlxTween.tween(comboText, {y: 140}, 1, {ease: FlxEase.expoOut});
    returnComboText2 = FlxTween.tween(comboText, {y: 140 - 100}, 5, {ease: FlxEase.expoOut, startDelay: 2});
    returnComboText3 = FlxTween.tween(comboText, {alpha: 0}, 0.5, {ease: FlxEase.linear, startDelay: 2});
}