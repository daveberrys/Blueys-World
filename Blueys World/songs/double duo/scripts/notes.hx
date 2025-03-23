function onNoteCreation(e) {
    if (e.strumLineID == 0)
        e.noteSprite = "game/notes/bluey";
    else if (e.strumLineID == 2)
        e.noteSprite = "game/notes/bingo";
    else
        e.noteSprite = "game/notes/default";
}

function onStrumCreation(e) {
    if (e.player == 0)
        e.sprite = "game/notes/bluey";
    else if (e.player == 2)
        e.sprite = "game/notes/bingo";
    else
        e.sprite = "game/notes/default";
}