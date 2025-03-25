import funkin.game.PlayState;

function onEvent(e) {
    if (e.event.name == "Change Icon") {
        var params:Array = e.event.params;
        trace(params[0]);
        trace(params[1]);
        trace(params[2]);
        trace(params[3]);

        varFakeIconPlayer = params[0];
        varFakeIconOpponent = params[2];
    }
}