package playerClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * ...
 * @author Phillip Napieralski
 */
class MarsPlayer extends Player
{
	public function new() 
	{
		super();
		
		loadGraphic(AssetPaths.ImgMarsPlayer, true, 32, 80, true);
		setupAnimations();
	}	
	
	override public function update():Void
	{
		super.update();
		
		acceleration.y = 80;
		
		Reg.marsModel.playerPosition.x = x;
		Reg.marsModel.playerPosition.y = y;
	}
	
}