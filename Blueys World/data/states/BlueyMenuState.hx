import flixel.text.FlxTextAlign;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxTextBorderStyle;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;

import funkin.menus.StoryMenuState;
import funkin.menus.FreeplayState;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;

var DEBUGGABLE:Bool = true; // im not disabling this lmao
var MakeButtons:Bool = true;

var curSelect:Int = 0;
var whatYoureSelecting:String = "";
var selectedSomething:Bool = false;

var bg:FlxSprite;
var grid:FlxBackdrop;
var versionText:FunkinText;
var zoomCameraBeat:FlxTween;

var storymode:FlxSprite;
var freeplay:FlxSprite;
var settings:FlxSprite;
var credits:FlxSprite;

var scaleObject:Float = 0.85;

// THE STUPID HOVER !!! R AHHHHHH!!!!
var storyHoverW:FlxTween; // width
var storyHoverH:FlxTween; // height

var freeplayHoverW:FlxTween; // width
var freeplayHoverH:FlxTween; // height

var settingsHoverW:FlxTween; // width
var settingsHoverH:FlxTween; // height

var creditsHoverW:FlxTween; // width
var creditsHoverH:FlxTween; // height

function postCreate() {
	FlxG.mouse.visible = true;

	bg = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/mainmenu/bg"));
	insert(1, bg);

	grid = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, 0x775419FFF, 0x335419FFF));
	grid.velocity.set(40, 40);
	insert(2, grid);

	blackDots = new FlxBackdrop().loadGraphic(Paths.image('menus/titlescreen/blackDots'));
	blackDots.velocity.set(40, 0);
	insert(3, blackDots);

	blackDots2 = new FlxBackdrop().loadGraphic(Paths.image('menus/titlescreen/blackDots'));
	blackDots2.angle = 180;
	blackDots2.velocity.set(-40, 0);
	insert(3, blackDots2);

	versionText = new FunkinText(5, FlxG.height - 2, 0, 'Bluey Mod: v1.0\nMade in Codename Engine!');
	versionText.setFormat(Paths.font("bluey.ttf"), 20, 0xFFFFFFFF, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
	versionText.y -= versionText.height;
	versionText.antialiasing = true;
	insert(4, versionText);

	selectingString = new FunkinText((1280/2)-(500/2), 50, 500, whatYoureSelecting);
	selectingString.setFormat(Paths.font("bluey.ttf"), 40, 0xFF419FFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
	selectingString.antialiasing = true;
	selectingString.borderSize = 69; // WHATTT IT LOOK COOL !!!!!!!!!
	insert(6, selectingString);

	if (MakeButtons) {
		storymode = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/mainmenu/storymode"));
		storymode.scale.set(scaleObject, scaleObject);
		insert(5, storymode);

		freeplay = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/mainmenu/freeplay"));
		freeplay.scale.set(scaleObject, scaleObject);
		insert(5, freeplay);

		settings = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/mainmenu/settings"));
		settings.scale.set(scaleObject, scaleObject);
		insert(5, settings);

		credits = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/mainmenu/credits"));
		credits.scale.set(scaleObject, scaleObject);
		insert(5, credits);

		// positioning lmao
		storymode.screenCenter();

		freeplay.screenCenter();
		freeplay.x += 400;
		freeplay.y += 200;

		settings.screenCenter();
		settings.x += 350;
		settings.y -= 200;

		credits.screenCenter();
		credits.x -= 350;
		credits.y -= 100;
	}
}

function update(elapsed:Float) {
	if (controls.BACK && !selectedSomething)
		FlxG.switchState(new TitleState());
	else if (FlxG.keys.justPressed.SEVEN && DEBUGGABLE && !selectedSomething) {
		persistentUpdate = false;
		persistentDraw = true;
		openSubState(new EditorPicker());
	} else if (FlxG.keys.justPressed.SEVEN && !DEBUGGABLE)
		trace("Access Denied lma-");
    else if (controls.SWITCHMOD && !selectedSomething) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }

	if (!selectedSomething) {
		mouseHover();
		if (curSelect != 0) mouseConfirm();
	}
}

function beatHit(curBeat) {
	if (!selectedSomething) {
		if (zoomCameraBeat != null) zoomCameraBeat.cancel();
		zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1.01}, 0.001);
		zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.expoOut});
	}
}

function mouseHover() {
	// bringing this code back 💔 (hi baran LMFAO)
    // I KNOW THIS IS UNOPTIMIZED, BUT IM NEW TO HAXE, SHUT UP VRO 💔💔💔
	if (MakeButtons) {
		var storymodeX = storymode.x;
		var storymodeY = storymode.y;
		var storymodeWidth = storymode.width;
		var storymodeHeight = storymode.height;

        var freeplayX = freeplay.x;
		var freeplayY = freeplay.y;
		var freeplayWidth = freeplay.width;
		var freeplayHeight = freeplay.height;

        var settingsX = settings.x;
		var settingsY = settings.y;
		var settingsWidth = settings.width;
		var settingsHeight = settings.height;

        var creditsX = credits.x;
		var creditsY = credits.y;
		var creditsWidth = credits.width;
		var creditsHeight = credits.height;

		var mouseX = FlxG.mouse.x;
		var mouseY = FlxG.mouse.y;

        if (storyHoverW != null) storyHoverW.cancel();
        if (storyHoverH != null) storyHoverH.cancel();

        if (freeplayHoverW != null) freeplayHoverW.cancel();
        if (freeplayHoverH != null) freeplayHoverH.cancel();

        if (settingsHoverW != null) settingsHoverW.cancel();
        if (settingsHoverH != null) settingsHoverH.cancel();

        if (creditsHoverW != null) creditsHoverW.cancel();
        if (creditsHoverH != null) creditsHoverH.cancel();
        
        // RESET THE CURSELECT IF ANYTHING ISNT SELECTED!
        curSelect = 0;
		whatYoureSelecting = "";

        // < ----- STORY MODE ----- >
		if (mouseX > storymodeX && mouseX < storymodeX + storymodeWidth &&
            mouseY > storymodeY && mouseY < storymodeY + storymodeHeight) {
            storyHoverH = FlxTween.tween(storymode, {"scale.x": scaleObject + 0.1}, 0.1);
            storyHoverW = FlxTween.tween(storymode, {"scale.y": scaleObject + 0.1}, 0.1);

            curSelect = 1;
			whatYoureSelecting = "Story Mode";
        } else {
            storyHoverH = FlxTween.tween(storymode, {"scale.x": scaleObject}, 0.1);
            storyHoverW = FlxTween.tween(storymode, {"scale.y": scaleObject}, 0.1);
        }

        // < ----- FREEPLAY ----- >
        if (mouseX > freeplayX && mouseX < freeplayX + freeplayWidth &&
            mouseY > freeplayY && mouseY < freeplayY + freeplayHeight) {
            freeplayHoverH = FlxTween.tween(freeplay, {"scale.x": scaleObject + 0.1}, 0.1);
            freeplayHoverW = FlxTween.tween(freeplay, {"scale.y": scaleObject + 0.1}, 0.1);

            curSelect = 2;
			whatYoureSelecting = "Freeplay";
        } else {
            freeplayHoverH = FlxTween.tween(freeplay, {"scale.x": scaleObject}, 0.1);
            freeplayHoverW = FlxTween.tween(freeplay, {"scale.y": scaleObject}, 0.1);
        }

        // < ----- SETTINGS ----- >
        if (mouseX > settingsX && mouseX < settingsX + settingsWidth &&
            mouseY > settingsY && mouseY < settingsY + settingsHeight) {
            settingsHoverH = FlxTween.tween(settings, {"scale.x": scaleObject + 0.1}, 0.1);
            settingsHoverW = FlxTween.tween(settings, {"scale.y": scaleObject + 0.1}, 0.1);

            curSelect = 3;
			whatYoureSelecting = "Settings";
        } else {
            settingsHoverH = FlxTween.tween(settings, {"scale.x": scaleObject}, 0.1);
            settingsHoverW = FlxTween.tween(settings, {"scale.y": scaleObject}, 0.1);
        }

        // < ----- CREDITS ----- >
        if (mouseX > creditsX && mouseX < creditsX + creditsWidth &&
            mouseY > creditsY && mouseY < creditsY + creditsHeight) {
            creditsHoverH = FlxTween.tween(credits, {"scale.x": scaleObject + 0.1}, 0.1);
            creditsHoverW = FlxTween.tween(credits, {"scale.y": scaleObject + 0.1}, 0.1);

            curSelect = 4;
			whatYoureSelecting = "Credits";
        } else {
            creditsHoverH = FlxTween.tween(credits, {"scale.x": scaleObject}, 0.1);
            creditsHoverW = FlxTween.tween(credits, {"scale.y": scaleObject}, 0.1);
        }

		selectingString.text = whatYoureSelecting;
	}
}

function mouseConfirm() {
	if (MakeButtons && FlxG.mouse.pressed) {
		selectedSomething = true;
		if (zoomCameraBeat != null) zoomCameraBeat.cancel();
		FlxG.sound.play(Paths.sound("menu/confirm"));

        FlxTween.tween(FlxG.camera, {zoom: 10, angle: 180, alpha: 0}, 2, {ease: FlxEase.expoIn});
        new FlxTimer().start(2, function(tmr:FlxTimer){
            FlxG.camera.visible = false;
			if (curSelect == 1)
				FlxG.switchState(new StoryMenuState());
			if (curSelect == 2)
				FlxG.switchState(new FreeplayState());
			if (curSelect == 3)
				FlxG.switchState(new OptionsMenu());
			if (curSelect == 4)
				FlxG.switchState(new CreditsMain());
        });

		FlxTween.tween(selectingString, {y: 720/2 - 20}, 2, {ease: FlxEase.expoOut});

		FlxTween.tween(storymode, {y: storymode.y + 720}, 2, {ease: FlxEase.expoInOut, startDelay: 0});
		FlxTween.tween(freeplay, {y: freeplay.y + 720}, 2, {ease: FlxEase.expoInOut, startDelay: 0.1});
		FlxTween.tween(settings, {y: settings.y + 720}, 2, {ease: FlxEase.expoInOut, startDelay: 0.15});
		FlxTween.tween(credits, {y: credits.y + 720}, 2, {ease: FlxEase.expoInOut, startDelay: 0.2});
    }
}