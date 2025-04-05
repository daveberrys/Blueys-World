var bingus:FlxSprite;

function create() {
	bingus = new FlxSprite(0, 0).loadGraphic(Paths.image("BINGUS"));
	bingus.screenCenter();
	add(bingus);
}

function update(elapsed:Float) {
	if (controls.BACK)
		FlxG.switchState(new MainMenuState());
}
