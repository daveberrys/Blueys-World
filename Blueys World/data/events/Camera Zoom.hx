var cameraZoom:FlxTween;

function onEvent(e) {
    if (e.event.name == "Camera Zoom") {
        if (cameraZoom != null) cameraZoom.cancel();
        var params:Array = e.event.params;
        cameraZoom = FlxTween.tween(camGame, {zoom: params[0]}, params[1], {ease: getTweenEaseByString(params[2])});
    }
}

public function getTweenEaseByString(?ease:String = '') {
    switch(StringTools.trim(ease.toLowerCase())) {
        case 'backin': return FlxEase.backIn;
        case 'backinout': return FlxEase.backInOut;
        case 'backout': return FlxEase.backOut;
        case 'bouncein': return FlxEase.bounceIn;
        case 'bounceinout': return FlxEase.bounceInOut;
        case 'bounceout': return FlxEase.bounceOut;
        case 'circin': return FlxEase.circIn;
        case 'circinout': return FlxEase.circInOut;
        case 'circout': return FlxEase.circOut;
        case 'cubein': return FlxEase.cubeIn;
        case 'cubeinout': return FlxEase.cubeInOut;
        case 'cubeout': return FlxEase.cubeOut;
        case 'elasticin': return FlxEase.elasticIn;
        case 'elasticinout': return FlxEase.elasticInOut;
        case 'elasticout': return FlxEase.elasticOut;
        case 'expoin': return FlxEase.expoIn;
        case 'expoinout': return FlxEase.expoInOut;
        case 'expoout': return FlxEase.expoOut;
        case 'quadin': return FlxEase.quadIn;
        case 'quadinout': return FlxEase.quadInOut;
        case 'quadout': return FlxEase.quadOut;
        case 'quartin': return FlxEase.quartIn;
        case 'quartinout': return FlxEase.quartInOut;
        case 'quartout': return FlxEase.quartOut;
        case 'quintin': return FlxEase.quintIn;
        case 'quintinout': return FlxEase.quintInOut;
        case 'quintout': return FlxEase.quintOut;
        case 'sinein': return FlxEase.sineIn;
        case 'sineinout': return FlxEase.sineInOut;
        case 'sineout': return FlxEase.sineOut;
        case 'smoothstepin': return FlxEase.smoothStepIn;
        case 'smoothstepinout': return FlxEase.smoothStepInOut;
        case 'smoothstepout': return FlxEase.smoothStepOut;
        case 'smootherstepin': return FlxEase.smootherStepIn;
        case 'smootherstepinout': return FlxEase.smootherStepInOut;
        case 'smootherstepout': return FlxEase.smootherStepOut;
    }
    return FlxEase.linear;
}
