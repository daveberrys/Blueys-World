import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

var songNameText:FunkinText;
var composedText:FunkinText;
var chartedText:FunkinText;
var visualsText:FunkinText;

var songNameBG:FlxSprite;
var songNameBGdropShadow:FlxSprite;

var makeText:Bool = true;
var showMoreInfo:Bool = false;

function postCreate() {
    var songName = PlayState.SONG.meta.displayName;
    var composed = PlayState.SONG.meta.customValues?.composed;
    var charted = PlayState.SONG.meta.customValues?.charted;
    var visuals = PlayState.SONG.meta.customValues?.visuals;

    trace(">> Custom Values");
    trace("songName: " + songName);
    trace("composed: " + composed);
    trace("charted: " + charted);
    trace("visuals: " + visuals);

    songNameBGdropShadow = new FlxSprite(0, 0).loadGraphic(Paths.image("game/songNameBG"));
    songNameBGdropShadow.alpha = 0.5;
    songNameBGdropShadow.scale.set(0, 0);
    songNameBGdropShadow.screenCenter();
    songNameBGdropShadow.y = 470 - 10;
    songNameBGdropShadow.x -= 10;
    songNameBGdropShadow.camera = camHUD;
    songNameBGdropShadow.color = 0xFF000000;
    add(songNameBGdropShadow);

    songNameBG = new FlxSprite(0, 0).loadGraphic(Paths.image("game/songNameBG"));
    songNameBG.alpha = 0.75;
    //songNameBG.alpha = 0;
    songNameBG.scale.set(0, 0);
    songNameBG.screenCenter();
    songNameBG.y = 470;
    songNameBG.camera = camHUD;
    add(songNameBG);

    // thank video bo t :3
    if (makeText) {
        songNameText = new FunkinText(0, 0, 1000, songName, 0, true);
        composedText = new FunkinText(0, 0, 1000, "Composed By " + composed, 0, true);
        chartedText = new FunkinText(0, 0, 1000, "Charted By " + charted, 0, true);
        visualsText = new FunkinText(0, 0, 1000, "Visual Art By " + visuals, 0, true);
        var list:Array<FunkinText> = [songNameText, composedText, chartedText, visualsText];

        for (item in list) {
            item.setFormat(Paths.font("bluey.ttf"), 30, 0xFFFFFFFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
            item.x = 240;
            item.angle = 5;
            item.alpha = 0;
            item.borderSize = 2;
            item.camera = camHUD;
            item.antialiasing = true;
            add(item);
        }
        
        songNameText.size = 50;
        songNameText.y = 520;
        composedText.y = songNameText.y - 40;
        chartedText.y = composedText.y - 30;
        visualsText.y = chartedText.y - 30;

        if (!showMoreInfo) {
            composedText.visible = false;
            chartedText.visible = false;
            visualsText.visible = false;
            songNameText.y = 520 - 50;
        }
    }
}

function onEvent(e) {
    if (e.event.name == "Song Name") {
        trace("Thou \"Song Name\" Shall appear here!");

        FlxTween.tween(songNameBG, {"scale.x": 5, "scale.y": 5}, 2, {ease: FlxEase.expoOut, startDelay: 0});
        FlxTween.tween(songNameBGdropShadow, {"scale.x": 5, "scale.y": 5}, 2, {ease: FlxEase.expoOut, startDelay: 0});

        FlxTween.tween(songNameText, {x: 140, alpha: 1, angle: 0}, 2, {ease: FlxEase.expoOut, startDelay: 0});
        FlxTween.tween(composedText, {x: 140, alpha: 1, angle: 0}, 2, {ease: FlxEase.expoOut, startDelay: 0.25});
        FlxTween.tween(chartedText, {x: 140, alpha: 1, angle: 0}, 2, {ease: FlxEase.expoOut, startDelay: 0.5});
        FlxTween.tween(visualsText, {x: 140, alpha: 1, angle: 0}, 2, {ease: FlxEase.expoOut, startDelay: 0.75});

        new FlxTimer().start(2, function(tmr:FlxTimer){
            trace("Thou \"Song Name\" Shall dissapear here!");

            FlxTween.tween(songNameBG, {"scale.x": 0, "scale.y": 0}, 2, {ease: FlxEase.expoIn, startDelay: 0});
            FlxTween.tween(songNameBGdropShadow, {"scale.x": 0, "scale.y": 0}, 2, {ease: FlxEase.expoIn, startDelay: 0});

            FlxTween.tween(songNameText, {x: 40, alpha: 0, angle: -5}, 2, {ease: FlxEase.expoIn, startDelay: 0});
            FlxTween.tween(composedText, {x: 40, alpha: 0, angle: -5}, 2, {ease: FlxEase.expoIn, startDelay: 0.25});
            FlxTween.tween(chartedText, {x: 40, alpha: 0, angle: -5}, 2, {ease: FlxEase.expoIn, startDelay: 0.5});
            FlxTween.tween(visualsText, {x: 40, alpha: 0, angle: -5}, 2, {ease: FlxEase.expoIn, startDelay: 0.75});
        });
    }
}