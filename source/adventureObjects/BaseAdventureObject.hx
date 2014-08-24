package adventureObjects;

import flixel.FlxSprite;
import playerClasses.PlanetModel;

/**
 * ...
 * @author Phillip Napieralski
 */
class BaseAdventureObject extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
	}
	
	public function toggleStateWithCache(planetModel:PlanetModel):Void
	{
		if ( animation.name == "off" )
		{
			animation.play("on");
			planetModel.SetObjectOn(this);
		}
		else if ( animation.name == "on" )
		{
			animation.play("off");
			planetModel.SetObjectOff(this);
		}
	}
	
}