function onEvent(e) {
    if (e.event.name == "Alpha Notes") {
        var params:Array = e.event.params;

        var strumLine:Int = params[0];
        var alpha:Float = params[1];
        var duration:Int = params[2];

        // lmao
        // i know theres probably a better way, but leave me alone :sob:
        FlxTween.tween(strumLines.members[strumLine].members[0], {alpha: alpha}, duration * Conductor.crochet * 0.001);
        FlxTween.tween(strumLines.members[strumLine].members[1], {alpha: alpha}, duration * Conductor.crochet * 0.001);
        FlxTween.tween(strumLines.members[strumLine].members[2], {alpha: alpha}, duration * Conductor.crochet * 0.001);
        FlxTween.tween(strumLines.members[strumLine].members[3], {alpha: alpha}, duration * Conductor.crochet * 0.001);
    }
}