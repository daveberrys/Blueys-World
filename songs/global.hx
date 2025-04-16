var scripts:String<Array> = [
    "BlueyHud",
    "BlueyComboCounter",
    "CamFollow",
    "NoMovingIcon",
    "SongNames"
];

function postCreate() {
    for (script in scripts)
        importScript("data/scripts/" + script + ".hx");
}

function onDadHit(event) {
    if (health > 0.1)
        health -= 0.02;
}