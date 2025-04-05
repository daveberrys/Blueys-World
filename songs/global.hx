function postCreate() {
    // SKRIPTS
    importScript("data/scripts/BlueyHud.hx");
    // importScript("data/scripts/BlueyComboCounter.hx");
    importScript("data/scripts/CamFollow.hx");
    importScript("data/scripts/NoMovingIcon.hx");
    importScript("data/scripts/SongNames.hx");
}

function onDadHit(event) {
    if (health > 0.1) // Limit so player dont die
        health -= 0.02; // Drain player health when dad hit 
}