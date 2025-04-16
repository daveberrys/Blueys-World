import flixel.addons.display.FlxBackdrop;

var sky:FlxBackdrop;
var bushes:FlxSprite;
var grass:FlxSprite;
var housething:FlxSprite;
var tree:FlxSprite;

function create() {
    sky = new FlxBackdrop().loadGraphic(Paths.image("stages/heelerhouse/sky"));
    sky.velocity.set(40, 0);
    insert(1, sky);

    bushes = new FlxSprite().loadGraphic(Paths.image("stages/heelerhouse/bushes"));
    bushes.scale.set(2, 2);
    insert(2, bushes);

    housething = new FlxSprite().loadGraphic(Paths.image("stages/heelerhouse/house_thing"));
    housething.scale.set(1.5, 1.5);
    insert(3, housething);

    grass = new FlxSprite().loadGraphic(Paths.image("stages/heelerhouse/grass"));
    grass.scale.set(0.3, 0.3);
    insert(3, grass);

    tree = new FlxSprite().loadGraphic(Paths.image("stages/heelerhouse/tree"));
    tree.scale.set(1.5, 1.5);
    insert(4, tree);

    // POSITIONING
    sky.y -= 100;

    bushes.x += 55;
    bushes.y += 500;

    housething.x -= 400;
    housething.y += 700;

    grass.x -= 3250; // THE GRASS IS TOO BIGG
    grass.y -= 800;

    tree.x -= 250;
    tree.y += 100;
}

function postCreate() {
    dad.y += 300;
    dad.x += 100;

    boyfriend.y = dad.y;
    boyfriend.x = dad.x + 750;
    
    strumLines.members[2].characters[0].x = dad.x - 250;
    strumLines.members[2].characters[0].y = dad.y;
}

function update() {
    //camGame.zoom = 0.5;
}