import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

var meidk:Bool = false;
var grid:FlxBackdrop;

function update(elapsed:Float) {
	if (!meidk) {
		if (controls.ACCEPT) {
			magenta.color = 0xFF419FFF;
			meidk = true;
			for (i => button in menuItems.members) {
				if (i == curSelected) {
					FlxTween.tween(button, {
						x: FlxG.width / 2 - button.width / 2,
						y: FlxG.height / 2 - button.height / 2
					}, 1, {ease: FlxEase.expoOut});
				} else {
					FlxTween.tween(button, {
						y: FlxG.height + 100
					}, 1, {ease: FlxEase.expoOut});
				}
			}
		}
		if (FlxG.keys.justPressed.B)
			FlxG.switchState(new ModState("BinguState"));
	}
}

function postCreate() {
	grid = new FlxBackdrop(FlxGridOverlay.createGrid(40, 40, 80, 80, true, 0x775419FFF, 0x335419FFF));
	grid.velocity.set(40, 40);
	insert(3, grid);
}
