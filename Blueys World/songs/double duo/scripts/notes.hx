var bfnotes = strumLines.members[1];
var blueynotes = strumLines.members[0];
var bingonotes = strumLines.members[2];
function onNoteCreation(e) {
    if (e.strumLineID == 0)
        e.noteSprite = "game/notes/bluey";
    else if (e.strumLineID == 2)
        e.noteSprite = "game/notes/bingo";
    else
        e.noteSprite = "game/notes/default";
}

function onStrumCreation(e) {
    if (e.player == 0) {
        e.sprite = "game/notes/bluey";
    } else if (e.player == 2) {
        e.sprite = "game/notes/bingo";
    } else {
        e.sprite = "game/notes/default";
    }
}

function postCreate() { 
    for (strum in bingonotes.members) {
        FlxTween.tween(strum, {x: strum.x - 640}, 0.01);
    }
}

function bingonoteon() {
    for (onstrum in bingonotes.members) {
        FlxTween.tween(onstrum , {x: onstrum .x / 1.15 + 500}, 2, {ease: FlxEase.expoOut});
        FlxTween.tween(onstrum.scale , {x: 0.65, y: 0.65}, 2, {ease: FlxEase.expoOut});
    }

    for (bfstrum in bfnotes.members) {
        FlxTween.tween(bfstrum , {x: bfstrum .x / 1.15 + 210}, 2, {ease: FlxEase.expoOut});
        FlxTween.tween(bfstrum.scale , {x: 0.65, y: 0.65}, 2, {ease: FlxEase.expoOut});
    }

    for (dadstrum in blueynotes.members) {
        FlxTween.tween(dadstrum , {x: dadstrum .x / 1.15 + 350}, 2, {ease: FlxEase.expoOut});
        FlxTween.tween(dadstrum.scale , {x: 0.65, y: 0.65}, 2, {ease: FlxEase.expoOut});
    }
}