import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

// THE BG
var sky:FlxBackdrop;
var bushes:FlxSprite;
var grass:FlxSprite;
var housething:FlxSprite;
var tree:FlxSprite;

// THE USER INTERFACE
var blackDots:FlxBackdrop;
var blackDots2:FlxBackdrop;

var play:FlxSprite;
var listen:FlxSprite;
var blueskied:FlxSprite;
var doubleDuo:FlxSprite;
#if mobile var back:FlxSprite; #end

var zoomCameraBeat:FlxTween;
var showListen:Bool = false; // hid the listen thing because it wont work 🫡 (maybe because im stupid)

// THE MOUSE INTERACTION
var selectedPlay:Bool = false;
var curSelect:Int = 0;
var curSongSelect:Int = 0;

// HOVER TWEEN
var playHoverH:FlxTween; // height
var playHoverW:FlxTween; // width

var listenHoverH:FlxTween; // height
var listenHoverW:FlxTween; // width

#if mobile
var backHoverH:FlxTween; // height
var backHoverW:FlxTween; // width
#end

var blueskiedHoverH:FlxTween; // height
var blueskiedHoverW:FlxTween; // width

var doubleDuoHoverH:FlxTween; // height
var doubleDuoHoverW:FlxTween; // width

function create() {
    sky = new FlxBackdrop().loadGraphic(Paths.image("menus/storymenu/BG/sky"));
    sky.velocity.set(40, 0);
    insert(1, sky);

    bushes = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/BG/bushes"));
    insert(2, bushes);

    housething = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/BG/house_thing"));
    insert(3, housething);

    grass = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/BG/grass"));
    grass.scale.set(0.2, 0.2);
    insert(3, grass);

    tree = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/BG/tree"));
    tree.scale.set(1, 1);
    insert(4, tree);

    // POSITIONING
    sky.y -= 100;

    bushes.x += 55;
    bushes.y += 150;

    housething.x -= 60;
    housething.y += 250;

    grass.x -= 3250; // THE GRASS IS TOO BIGG
    grass.y -= 1100;

    tree.x -= 175;
    tree.y -= 100;

    // USER INTERFACE! (this what make it cool i think)
    blackDots = new FlxBackdrop().loadGraphic(Paths.image('menus/freeplaymenu/blackDots'));
	blackDots.velocity.set(40, 0);
	add(blackDots);

    blackDots2 = new FlxBackdrop().loadGraphic(Paths.image('menus/freeplaymenu/blackDots'));
	blackDots2.velocity.set(-40, 0);
    blackDots2.angle -= 180;
	add(blackDots2);

    split = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/split"));
    split.alpha = 0.75;
    if (!showListen) add(split);

    play = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/play"));
    if (showListen) add(play);
    
    listen = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/listen"));
    if (showListen) add(listen);
    
    blueskied = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/blueskied"));
    add(blueskied);

    doubleDuo = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/double duo"));
    add(doubleDuo);

    #if mobile
    back = new FlxSprite().loadGraphic(Paths.image("mobile/virtualpad/arrow"));
    back.angle -= 90;
    back.alpha = 0.5;
    add(back);
    #end

    // USER INTERFACE POSITIONING :sillycat:
    play.screenCenter(FlxAxes.X);
    play.x += 100;
    play.y += 720 - 190 - 30;
    
    listen.screenCenter(FlxAxes.X);
    listen.x -= 100;
    listen.y += 720 - 190 - 30;

    blueskied.screenCenter(FlxAxes.X);
    blueskied.screenCenter(FlxAxes.Y);
    blueskied.x -= 350;

    doubleDuo.screenCenter(FlxAxes.X);
    doubleDuo.screenCenter(FlxAxes.Y);
    doubleDuo.x += 350;
}

function update(elapsed:Float) {
    if (controls.BACK && !selectedPlay)
		FlxG.switchState(new ModState("BlueyMenuState"));
    #if mobile
    else-if (FlxG.mouse.justReleased && curSelect == 3 && !selectedPlay)
        FlxG.switchState(new ModState("BlueyMenuState"));
    #end

    if (!selectedPlay) {
        mouseHover();
        if (showListen) {
            if (curSelect != 0 && curSongSelect != 0 && FlxG.mouse.justReleased)
                mouseSelect();
        } else {
            if (curSongSelect != 0 && FlxG.mouse.justReleased)
                mouseSelect();
        }
    }
}

function beatHit(curBeat) {
	if (!selectedPlay) {
		if (zoomCameraBeat != null) zoomCameraBeat.cancel();
		zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1.01}, 0.001);
		zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.expoOut});
	}
}

function mouseHover() {
    var playX = play.x;
    var playY = play.y;
    var playWidth = play.width;
    var playHeight = play.height;

    var listenX = listen.x;
    var listenY = listen.y;
    var listenWidth = listen.width;
    var listenHeight = listen.height;

    #if mobile
    var backX = back.x;
    var backY = back.y;
    var backWidth = back.width;
    var backHeight = back.height;
    #end

    var blueskiedX = blueskied.x;
    var blueskiedY = blueskied.y;
    var blueskiedWidth = blueskied.width;
    var blueskiedHeight = blueskied.height;
 
    var doubleDuoX = doubleDuo.x;
    var doubleDuoY = doubleDuo.y;
    var doubleDuoWidth = doubleDuo.width;
    var doubleDuoHeight = doubleDuo.height;

    var mouseX = FlxG.mouse.x;
	var mouseY = FlxG.mouse.y;

    // CANCELS THE TWEEN
    if (playHoverW != null) playHoverW.cancel();
    if (playHoverH != null) playHoverH.cancel();

    if (listenHoverW != null) listenHoverW.cancel();
    if (listenHoverH != null) listenHoverH.cancel();

    #if mobile
    if (backHoverW != null) backHoverW.cancel();
    if (backHoverH != null) backHoverH.cancel();
    #end

    if (blueskiedHoverW != null) blueskiedHoverW.cancel();
    if (blueskiedHoverH != null) blueskiedHoverH.cancel();

    if (doubleDuoHoverW != null) doubleDuoHoverW.cancel();
    if (doubleDuoHoverH != null) doubleDuoHoverH.cancel();

    // RESETS IF NOT SELECTED ANYTHING (THE BUTTONS)
    if (!showListen) curSongSelect = 0;
    curSelect = 0;

    // THE BUTTON HOVERS
    // <---- PLAY ---->
    if (mouseX > playX && mouseX < playX + playWidth &&
        mouseY > playY && mouseY < playY + playHeight) {
        playHoverH = FlxTween.tween(play, {"scale.x": 1.1}, 0.1);
        playHoverW = FlxTween.tween(play, {"scale.y": 1.1}, 0.1);

        curSelect = 1;
    } else {
        playHoverH = FlxTween.tween(play, {"scale.x": 1}, 0.1);
        playHoverW = FlxTween.tween(play, {"scale.y": 1}, 0.1);
    }

    // <---- LISTEN ---->
    if (mouseX > listenX && mouseX < listenX + listenWidth &&
        mouseY > listenY && mouseY < listenY + listenHeight) {
        listenHoverH = FlxTween.tween(listen, {"scale.x": 1.1}, 0.1);
        listenHoverW = FlxTween.tween(listen, {"scale.y": 1.1}, 0.1);

        curSelect = 2;
    } else {
        listenHoverH = FlxTween.tween(listen, {"scale.x": 1}, 0.1);
        listenHoverW = FlxTween.tween(listen, {"scale.y": 1}, 0.1);
    }

    #if mobile
    // <---- BACK ---->
    if (mouseX > backX && mouseX < backX + backWidth &&
        mouseY > backY && mouseY < backY + backHeight) {
        backHoverH = FlxTween.tween(back, {"scale.x": 1.1}, 0.1);
        backHoverW = FlxTween.tween(back, {"scale.y": 1.1}, 0.1);

        curSelect = 3;
    } else {
        backHoverH = FlxTween.tween(back, {"scale.x": 1}, 0.1);
        backHoverW = FlxTween.tween(back, {"scale.y": 1}, 0.1);
    }
    #end

    // <---- BLUESKIED ---->
    if (mouseX > blueskiedX && mouseX < blueskiedX + blueskiedWidth &&
        mouseY > blueskiedY && mouseY < blueskiedY + blueskiedHeight) {
        blueskiedHoverH = FlxTween.tween(blueskied, {"scale.x": 1.1}, 0.1);
        blueskiedHoverW = FlxTween.tween(blueskied, {"scale.y": 1.1}, 0.1);

        curSongSelect = 1;
    } else {
        blueskiedHoverH = FlxTween.tween(blueskied, {"scale.x": 1}, 0.1);
        blueskiedHoverW = FlxTween.tween(blueskied, {"scale.y": 1}, 0.1);
    }

    // <---- DOUBLE DUO ---->
    if (mouseX > doubleDuoX && mouseX < doubleDuoX + doubleDuoWidth &&
        mouseY > doubleDuoY && mouseY < doubleDuoY + doubleDuoHeight) {
        doubleDuoHoverH = FlxTween.tween(doubleDuo, {"scale.x": 1.1}, 0.1);
        doubleDuoHoverW = FlxTween.tween(doubleDuo, {"scale.y": 1.1}, 0.1);

        curSongSelect = 2;
    } else {
        doubleDuoHoverH = FlxTween.tween(doubleDuo, {"scale.x": 1}, 0.1);
        doubleDuoHoverW = FlxTween.tween(doubleDuo, {"scale.y": 1}, 0.1);
    }
}

function mouseSelect() {
    if (showListen) {
        if (curSelect == 1) {
            selectedPlay = true;
            FlxG.sound.music.fadeOut(2);
            FlxG.sound.play(Paths.sound("menu/confirm"));
            FlxTween.tween(FlxG.camera, {zoom: 10, angle: 180, alpha: 0}, 2, {ease: FlxEase.expoIn});

            if (curSongSelect == 1) {
                PlayState.loadSong("blueskied", "Blue", false, false);
                FlxTween.tween(blueskied, {x: 1280 / 2 - 120}, 1, {ease: FlxEase.expoOut});
                FlxTween.tween(doubleDuo, {alpha: 0}, 1);
            }
            else if (curSongSelect == 2) {
                PlayState.loadSong("double duo", "Blue", false, false);
                FlxTween.tween(doubleDuo, {x: 1280 / 2 - 120}, 1, {ease: FlxEase.expoOut});
                FlxTween.tween(blueskied, {alpha: 0}, 1);
            }
            new FlxTimer().start(2, function(tmr:FlxTimer){
                FlxG.camera.visible = false;
                FlxG.switchState(new PlayState());
            });
        } else if (curSelect == 2) {
            if (curSongSelect == 1)
                FlxG.sound.playMusic(Paths.inst("blueskied", "Blue"), 0);
            else if (curSongSelect == 2)
                FlxG.sound.playMusic(Paths.inst("double duo", "Blue"), 0);
        }
    }

    if (!showListen) {
        if (curSongSelect == 1) {
            PlayState.loadSong("blueskied", "Blue", false, false);
            FlxTween.tween(blueskied, {x: 1280 / 2 - 120}, 1, {ease: FlxEase.expoOut});
            FlxTween.tween(doubleDuo, {alpha: 0}, 1);
        }
        else if (curSongSelect == 2) {
            PlayState.loadSong("double duo", "Blue", false, false);
            FlxTween.tween(doubleDuo, {x: 1280 / 2 - 120}, 1, {ease: FlxEase.expoOut});
            FlxTween.tween(blueskied, {alpha: 0}, 1);
        }

        selectedPlay = true;
        FlxG.sound.music.fadeOut(2);
        FlxG.sound.play(Paths.sound("menu/confirm"));
        FlxTween.tween(FlxG.camera, {zoom: 10, angle: 180, alpha: 0}, 2, {ease: FlxEase.expoIn});
        new FlxTimer().start(2, function(tmr:FlxTimer){
            FlxG.camera.visible = false;
            FlxG.switchState(new PlayState());
        });
    }
}