function onEvent(e) {
    if (e.event.name == "Change Dad Icon") {
        var params:Array = e.event.params;

        #if !linux
        varFakeIconOpponent = params[0];
        #else
        if (params[0] == "Bingo")
            varFakeIconOpponent = "bingo";
        else if (params[0] == "Bluey")
            varFakeIconOpponent = "bluey";
        #end
    }
}
