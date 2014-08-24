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
class EarthPlayer extends Player
{
	public function new() 
	{
		super();
		
		loadGraphic(AssetPaths.ImgEarthPlayer, true, 32, 64, true);
		setupAnimations();
	}
	
	override public function update():Void
	{
		super.update();
		
		acceleration.y = 220;
		
		Reg.earthModel.playerPosition.x = x;
		Reg.earthModel.playerPosition.y = y;
	}
	
}