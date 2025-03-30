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
var weekBluey:FlxSprite;
var weekBlueySHADOW:FlxSprite;
var play:FlxSprite;
var storyText:FunkinText;

var playHoverH:FlxTween;
var playHoverW:FlxTween;

// the other boring stuff
var zoomCameraBeat:FlxTween;
var selectSomething:Bool = false;
var LH:FlxTween;

function postCreate() {
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

    bushes.x += 75;
    bushes.y += 150;

    housething.x -= 30;
    housething.y += 250;

    grass.x -= 3250; // THE GRASS IS TOO BIGG
    grass.y -= 1100;

    tree.x -= 175;
    tree.y -= 100;

    // USER INTERFACE! (this what make it cool i think)
    blackDots = new FlxBackdrop().loadGraphic(Paths.image('menus/storymenu/blackDots'));
	blackDots.velocity.set(40, 0);
	add(blackDots);

    blackDots2 = new FlxBackdrop().loadGraphic(Paths.image('menus/storymenu/blackDots'));
	blackDots2.velocity.set(-40, 0);
    blackDots2.angle -= 180;
	add(blackDots2);

    weekBlueySHADOW = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/weekbluey"));
    weekBlueySHADOW.color = 0xFF000000;
    add(weekBlueySHADOW);

    weekBluey = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/weekbluey"));
    add(weekBluey);

    play = new FlxSprite().loadGraphic(Paths.image("menus/storymenu/play"));
    play.scale.set(0.5, 0.5);
    add(play);

    storyText = new FunkinText(0, 0, 1000, 'Isn\'t this the best world?');
	storyText.setFormat(Paths.font("bluey.ttf"), 40, 0xFFFFFFFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
	storyText.antialiasing = true;
	add(storyText);

    LH = new FlxSprite(0, 0).loadGraphic(Paths.image("menus/LineHelper"));
    LH.scale.set(1, 1);
    //add(LH);

    // POSITIONINING  USER INTERFACE
    weekBluey.x += 25;
    weekBluey.y += 720 - 115;

    weekBlueySHADOW.x = weekBluey.x + 5;
    weekBlueySHADOW.y = weekBluey.y + 5;

    play.x += 1050;
    play.y += 450;
    
    storyText.x += 145;
}

function update(elapsed:Float) {
    if (controls.BACK)
		FlxG.switchState(new ModState("BlueyMenuState"));

    if (FlxG.mouse.pressed && !selectSomething) playButton();
    if (!selectSomething) playHover();
}

function beatHit(curBeat) {
    if (!selectSomething) {
        if (zoomCameraBeat != null) zoomCameraBeat.cancel();
        zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1.01}, 0.001);
        zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.expoOut});
    }
}

function playButton() {
    var playX = play.x;
	var playY = play.y;
	var playWidth = play.width;
	var playHeight = play.height;

	var mouseX = FlxG.mouse.x;
	var mouseY = FlxG.mouse.y;

    if (mouseX > playX && mouseX < playX + playWidth &&
		mouseY > playY && mouseY < playY + playHeight) {
        FlxG.sound.play(Paths.sound("menu/confirm"));
        selectSomething = true;
        if (zoomCameraBeat != null) zoomCameraBeat.cancel();

        FlxTween.tween(FlxG.camera, {zoom: 10, angle: 180, alpha: 0}, 2, {ease: FlxEase.expoIn});
        new FlxTimer().start(2, function(tmr:FlxTimer){
            FlxG.camera.visible = false;
            PlayState.loadWeek({
                name: "weekBluey",
                id: "weekBluey",
                sprite: null,
                chars: [null, null, null],
                songs: [{name: 'blueskied', hide: false},
                        {name: 'double duo', hide: false}],
                difficulties: ['Blue']
                }, "Blue");
            FlxG.switchState(new PlayState());
        });
	}
}

function playHover() {
    var playX = play.x;
	var playY = play.y;
	var playWidth = play.width;
	var playHeight = play.height;

	var mouseX = FlxG.mouse.x;
	var mouseY = FlxG.mouse.y;

    if (playHoverH != null) playHoverH.cancel();
    if (playHoverW != null) playHoverW.cancel();

    if (mouseX > playX && mouseX < playX + playWidth &&
		mouseY > playY && mouseY < playY + playHeight) {
        playHoverH = FlxTween.tween(play, {"scale.x": 0.5 + 0.1}, 0.1);
        playHoverW = FlxTween.tween(play, {"scale.y": 0.5 + 0.1}, 0.1);
	} else {
        playHoverH = FlxTween.tween(play, {"scale.x": 0.5}, 0.1);
        playHoverW = FlxTween.tween(play, {"scale.y": 0.5}, 0.1); 
    }
}