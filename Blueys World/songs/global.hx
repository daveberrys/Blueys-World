function postCreate() {
    importScript("data/scripts/BlueyHud.hx"); // Activates the HUD Script
    // importScript("data/scripts/BlueyComboCounter.hx"); // Activates the ComboCounter Script
    importScript("data/scripts/CamFollow.hx"); // Activates the CamFollow Script
    importScript("data/scripts/SmoothHealthbar.hx"); // Activates the SmoothHealthbar Script
}

function onDadHit(event) {
    if (health > 0.1) // Limit so player dont die
        health -= 0.02; // Drain player health when dad hit 
}