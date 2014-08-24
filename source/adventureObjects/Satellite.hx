package adventureObjects;

import flixel.FlxSprite;

/**
 * ...
 * @author Phillip Napieralski
 */
class Satellite extends BaseAdventureObject
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.ImgSatellite, true, 65);
		
		animation.add("off", [0], 1);
		animation.add("on", [1], 1);
		
		animation.play("off");
	}
	
}