package adventureObjects;

import flixel.FlxSprite;

/**
 * ...
 * @author Phillip Napieralski
 */
class LaserGun extends BaseAdventureObject
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ImgLaserGun, true, 96, 96);
		
		animation.add("off", [0], 1);
		animation.add("on", [1], 1);
		
		animation.play("off");
	}
	
}