package adventureObjects;

import flixel.FlxSprite;

/**
 * ...
 * @author Phillip Napieralski
 */
class PowerShaft extends BaseAdventureObject
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ImgPowerShaft, true, 32, 64);
		
		animation.add("off", [0], 1);
		animation.add("on", [1], 1);
		
		animation.play("off");
	}
	
}