var scripts:Array<String> = [
    "BlueyHud",
    "BlueyComboCounter",
    "CamFollow",
    "NoMovingIcon",
    "SongNames"
];

function postCreate()
    for (script in scripts)
        importScript("data/scripts/" + script + ".hx");

function update()
    camZooming = false;

function onDadHit(event)
    if (health > 0.1)
        health -= 0.02;