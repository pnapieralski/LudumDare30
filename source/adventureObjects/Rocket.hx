package adventureObjects ;

import flixel.FlxSprite;

/**
 * ...
 * @author Phillip Napieralski
 */
class Rocket extends BaseAdventureObject
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, AssetPaths.ImgRocket);
	}
	
}