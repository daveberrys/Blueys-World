function postUpdate() {
    FlxG.camera.visible = false;
    FlxG.switchState(new ModState("BlueyMenuState"));
}