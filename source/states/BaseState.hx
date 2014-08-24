package states;

import flixel.addons.effects.FlxWaveSprite;
import flixel.addons.effects.FlxWaveSprite.FlxWaveMode;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.CompleteCallback;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Phillip Napieralski
 */
class BaseState extends FlxState
{	
	private function addStory(txts:Array<String>, ?onStep:CompleteCallback, ?onCompleted:CompleteCallback, which:Int = 0):Void
	{
		if ( which >= txts.length )
		{
			return ;
		}
		
		var newTxt:FlxText = new FlxText(FlxG.random.float(10, FlxG.width - 350), FlxG.random.float(10, FlxG.height - 100), 
										 FlxG.width - 100, txts[which], 16);	
		newTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE_FAST);
		newTxt.scrollFactor.set();
		
		var fxTxt:FlxWaveSprite = new FlxWaveSprite(newTxt, FlxWaveMode.BOTTOM, 10);
		fxTxt.alpha = 0;
		fxTxt.scrollFactor.set();
		add(fxTxt);
	
		FlxSpriteUtil.fadeIn(fxTxt, 2, true,  // should be 2
			function(tween:FlxTween) { 
				FlxSpriteUtil.fadeOut(fxTxt, 1.25, function (tween:FlxTween) { // should be 1.25
					if ( ++which >= txts.length )
					{	
						if( onStep != null )
							onStep(tween);
						if( onCompleted != null )
							onCompleted(tween);
					}
					else
					{
						if( onStep != null )
							onStep(tween);
						addStory(txts, onStep, onCompleted, which);	
					}
				});
			});	
	}	
}