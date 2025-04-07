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

    play = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/play"));
    add(play);
    
    listen = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/listen"));
    add(listen);
    
    blueskied = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/blueskied"));
    add(blueskied);

    doubleDuo = new FlxSprite().loadGraphic(Paths.image("menus/freeplaymenu/double duo"));
    add(doubleDuo);

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
    if (controls.BACK)
		FlxG.switchState(new ModState("BlueyMenuState"));
}