import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

var ok:Bool = true;
var grid:FlxBackdrop;
var titlebg:FlxSprite;
var titlebluey:FlxSprite;
var titleLogo:FlxSprite;
var titlelogotween:FlxTween;
var titleText:FlxSprite;
var titleTextTween:FlxTween;
var titleblueytween:FlxTween;

function postCreate() {
    titleLogo = new FlxSprite(-40,0).loadGraphic(Paths.image('menus/titlescreen/titlelogo'));
	insert(3, titleLogo);

    titlebluey = new FlxSprite(500,0).loadGraphic(Paths.image('menus/titlescreen/titlebluey'));
	insert(2, titlebluey);

    titlebg = new FlxSprite(0,0).loadGraphic(Paths.image('menus/titlescreen/titlebg'));
	insert(1, titlebg);

    titleText = new FlxSprite(100,300).loadGraphic(Paths.image('menus/titlescreen/titletext'));
	insert(6, titleText);
    
    grid = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, 0x77FFFFFF, 0x335419FFF));
    grid.velocity.set(40, 40);
    insert(2, grid);
}

function update(elapsed:Float) {
    if (transitioning && ok){
        FlxTween.tween(FlxG.camera, {width:0}, 2, {ease: FlxEase.expoIn});
        new FlxTimer().start(2, function(tmr:FlxTimer){
            FlxG.camera.visible = false;
        });
        ok = false;
    }
}

function beatHit(curBeat) {
    if (skippedIntro == true) {
        FlxTween.tween(titlebluey, {x:0}, 2, {ease: FlxEase.expoOut});
    }
    
    titlebluey.y = 30;

    if (titleblueytween != null) titleblueytween.cancel();
    titleblueytween = FlxTween.tween(titlebluey, {y: 0}, 1, {ease: FlxEase.expoOut});

    titleText.scale.x = 1;
    titleText.scale.y = 1;

    if (titleTextTween != null) titleTextTween.cancel();
    titleTextTween = FlxTween.tween(titleText.scale, {x: 0.9, y: 0.9}, 1, {ease: FlxEase.expoOut});

    if (curBeat % 2 == 0) {
        titleLogo.scale.x = 1;
        titleLogo.scale.y = 1;

        if (titlelogotween != null) titlelogotween.cancel();
        titlelogotween = FlxTween.tween(titleLogo.scale, {x: 0.9, y: 0.9}, 1, {ease: FlxEase.expoOut});
    }
    
    switch (curBeat) {
        case 0:
    }
}
