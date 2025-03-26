var blueysWorldFollowDirectionCam = FlxG.save.data.blueysWorldFollowDirectionCam;

function postCreate() {
    // SKRIPTS
    importScript("data/scripts/BlueyHud.hx");
    // importScript("data/scripts/BlueyComboCounter.hx");
    if (blueysWorldFollowDirectionCam)
        importScript("data/scripts/CamFollow.hx");
    importScript("data/scripts/SmoothHealthbar.hx");
    importScript("data/scripts/SongNames.hx");
}

function onDadHit(event) {
    if (health > 0.1) // Limit so player dont die
        health -= 0.02; // Drain player health when dad hit 
}