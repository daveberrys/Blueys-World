function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 356: {
            FlxTween.tween(healthBar, {alpha: 0}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});
            FlxTween.tween(healthBarBG, {alpha: 0}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});
            FlxTween.tween(fakeIconOpponent, {alpha: 0}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});
            FlxTween.tween(fakeIconPlayer, {alpha: 0}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});

            FlxTween.tween(scoreText, {alpha: 0.1}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});
            FlxTween.tween(missText, {alpha: 0.1}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});
            FlxTween.tween(accuracyText, {alpha: 0.1}, 8 * Conductor.crochet * 0.001, {ease: FlxEase.linear});
        }
    }
}