var meidk:Bool = false;

function update(elapsed:Float)
{
    if (!meidk)
    {
        if (controls.ACCEPT) { 
            meidk = true;
            for (i => button in menuItems.members)
            {
                if (i == curSelected)
                {
                    FlxTween.tween(button, { 
                        x: FlxG.width / 2 - button.width / 2, 
                        y: FlxG.height / 2 - button.height / 2
                    }, 1, {ease: FlxEase.expoOut});
                }
                else
                {
                    FlxTween.tween(button, { 
                        y: FlxG.height + 100 
                    }, 1, {ease: FlxEase.expoOut});
                }
            }
        }
    }
}
