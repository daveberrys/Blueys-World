import funkin.game.PlayState;

function onEvent(e) {
    if (e.event.name == "Change Icon") {
        var params:Array = e.event.params;
        trace(params[0]);
        trace(params[1]);
        trace(params[2]);

        var leftColor = dad.color;
        var rightColor = boyfriend.color;

        if (params[0] == "boyfriend") {
            varFakeIconPlayer = params[1];
            PlayState.rightColor = params[2];
            PlayState.healthBar.createFilledBar(leftColor, rightColor);
        }
        else if (params[0] == "dad") {
            varFakeIconOpponent = params[1];
            PlayState.leftColor = params[2];
            PlayState.healthBar.createFilledBar(leftColor, rightColor);
        }
    }
}