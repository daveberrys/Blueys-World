import flixel.FlxObject;
import flixel.FlxCameraFollowStyle;
import flixel.math.FlxMath;

public var camfollow = true;
public var gffollow = false;
var bfCamOffset = [];
var dadCamOffset = [];
var curFocus:Int = 2;

function onCameraMove(event) {
    if (event.position.x == dad.getCameraPosition().x && event.position.y == dad.getCameraPosition().y)
    {
        camTarget = "dad";
        curFocus = 2;
    }
    else if (event.position.x == boyfriend.getCameraPosition().x && event.position.y == boyfriend.getCameraPosition().y)
    {
        camTarget = "boyfriend";
        curFocus = 1;
    }
}

function onNoteHit(event) {
    if (camfollow && !gffollow) {
        if (camTarget == "dad") {
            bfCamOffset = [0, 0];
            switch (event.direction) {
                case 0: dadCamOffset = [-40, 0];
                case 1: dadCamOffset = [0, 40];
                case 2: dadCamOffset = [0, -40];
                case 3: dadCamOffset = [40, 0];
            }
        } else if (camTarget == "boyfriend") {
            dadCamOffset = [0, 0];
            switch (event.direction) {
                case 0: bfCamOffset = [-40, 0];
                case 1: bfCamOffset = [0, 40];
                case 2: bfCamOffset = [0, -40];
                case 3: bfCamOffset = [40, 0];
            }
        }
    }
}

function postUpdate() {
    if (gffollow && gf != null) {
        camFolloww.x = FlxMath.lerp(camFolloww.x, 700, 0.1);  
        camFolloww.y = FlxMath.lerp(camFolloww.y, 500, 0.1);
    } else if (camfollow) {
        var targetOffset = camTarget == "dad" ? dadCamOffset : bfCamOffset;
        
        if ((camTarget == "dad" && dad.animation.curAnim.name == "idle") || (camTarget == "boyfriend" && boyfriend.animation.curAnim.name == "idle")) {
            targetOffset = [0, 0];
        }
        
        camFolloww.x = FlxMath.lerp(camFolloww.x, camFollow.x + targetOffset[0], 0.1);
        camFolloww.y = FlxMath.lerp(camFolloww.y, camFollow.y + targetOffset[1], 0.1);
    }
}

function toggleMovePress(event) {
    camfollow = !camfollow;
    gffollow = !gffollow;
}

function gfFollow(yes, event) {
    if (yes == "on") {
        gffollow = true;
        camfollow = false;
    } else if (yes == "off") {
        gffollow = false;
        camfollow = true;
    }
}

var camFolloww:FlxObject;

function postCreate() {
    var camPos = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

    camFolloww = new FlxObject(0, 0, 1, 1);
    camFolloww.setPosition(camFollow.x, camFollow.y);

    FlxG.camera.follow(camFolloww, FlxCameraFollowStyle.LOCKON, 0.05);
    FlxG.camera.focusOn(camFolloww.getPosition());
}
