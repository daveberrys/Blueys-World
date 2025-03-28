import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

var ok:Bool = true;

var grid:FlxBackdrop;
var titleBg:FlxSprite;
var titleBluey:FlxSprite;
var titleLogo:FlxSprite;
var titleText:FlxSprite;
var titleLogoTween:FlxTween;
var titleTextTween:FlxTween;
var titleBlueyTween:FlxTween;

var zoomCameraIn:FlxTween;
var zoomCameraBeat:FlxTween;

function postCreate() {
    titleBg = new FlxSprite(0,0).loadGraphic(Paths.image('menus/titlescreen/titlebg'));
	insert(1, titleBg);
    
    grid = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, 0x77FFFFFF, 0x335419FFF));
    grid.velocity.set(40, 40);
    insert(2, grid);

    blackDots = new FlxBackdrop().loadGraphic(Paths.image('menus/titlescreen/blackDots'));
    blackDots.velocity.set(40, 0);
    insert(3, blackDots);

    blackDots2 = new FlxBackdrop().loadGraphic(Paths.image('menus/titlescreen/blackDots'));
    blackDots2.angle = 180;
    blackDots2.velocity.set(-40, 0);
    insert(3, blackDots2);

    titleBluey = new FlxSprite(500,0).loadGraphic(Paths.image('menus/titlescreen/titlebluey'));
	insert(5, titleBluey);

    titleLogo = new FlxSprite(-1000,0).loadGraphic(Paths.image('menus/titlescreen/titlelogo'));
	insert(6, titleLogo);

    titleText = new FlxSprite(-1000,300).loadGraphic(Paths.image('menus/titlescreen/titletext'));
	insert(7, titleText);
}

function update(elapsed:Float) {
    if (transitioning && ok){
        //FlxTween.tween(FlxG.camera, {width:0}, 2, {ease: FlxEase.expoIn});
        if (zoomCameraBeat != null) zoomCameraBeat.cancel();
        FlxTween.tween(FlxG.camera, {zoom: 10, angle: 180, alpha: 0}, 2, {ease: FlxEase.expoIn});
        new FlxTimer().start(2, function(tmr:FlxTimer){
            FlxG.camera.visible = false;
        });
        ok = false;
    }
}

function beatHit(curBeat) {
    if (skippedIntro == true) {
        FlxTween.tween(titleLogo, {x:-40}, 2, {ease: FlxEase.expoOut});
        FlxTween.tween(titleText, {x:100}, 2, {ease: FlxEase.expoOut});
        FlxTween.tween(titleBluey, {x:0}, 2, {ease: FlxEase.expoOut});
    }
    
    titleBluey.y = 30;

    if (titleBlueyTween != null) titleBlueyTween.cancel();
    titleBlueyTween = FlxTween.tween(titleBluey, {y: 0}, 1, {ease: FlxEase.expoOut});

    titleText.scale.x = 1;
    titleText.scale.y = 1;

    if (titleTextTween != null) titleTextTween.cancel();
    titleTextTween = FlxTween.tween(titleText.scale, {x: 0.9, y: 0.9}, 1, {ease: FlxEase.expoOut});

    if (ok) {
        if (zoomCameraBeat != null) zoomCameraBeat.cancel();
        zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.01);
        zoomCameraBeat = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.expoOut});
    }

    if (curBeat % 2 == 0) {
        titleLogo.scale.x = 1;
        titleLogo.scale.y = 1;

        if (titleLogoTween != null) titleLogoTween.cancel();
        titleLogoTween = FlxTween.tween(titleLogo.scale, {x: 0.9, y: 0.9}, 1, {ease: FlxEase.expoOut});
    }
    
    switch (curBeat) {
        case 0:
    }
}
