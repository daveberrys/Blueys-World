function onNoteCreation(e) {
    if (e.strumLineID == 0)
        e.noteSprite = "game/notes/Heeler_NOTE";
    else
        e.noteSprite = "game/notes/default";
}

function onStrumCreation(e) {
    if (e.player == 0)
        e.sprite = "game/notes/Heeler_NOTE";
    else
        e.sprite = "game/notes/default";
}