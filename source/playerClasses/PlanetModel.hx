package playerClasses;
import adventureObjects.LaserGun;
import adventureObjects.Satellite;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import haxe.ds.StringMap;

/**
 * ...
 * @author Phillip Napieralski
 */
class PlanetModel
{
	public function new(){}

	public var playerPosition:FlxPoint = new FlxPoint();
	
	public var objectsOn:StringMap<Bool> = new StringMap<Bool>();
	public var numObjectsOn:StringMap<Int> = new StringMap<Int>();
	
	public function SetObjectOn(obj:FlxSprite):Void
	{
		objectsOn.set(Std.string(obj.x) + Std.string(obj.y), true);
		
		
		var keyCountMap:String = "powershaft";
		
		if ( Std.is(obj, Satellite) )
			keyCountMap = "satellite";
		else if ( Std.is(obj, LaserGun) )
			keyCountMap = "lasergun";
			
		var numObj:Null<Int> = numObjectsOn.get(keyCountMap);
		var count:Int = 0;
		if ( numObj != null )
		{
			count = numObj;
		}

		numObjectsOn.set(keyCountMap, ++count );
	}
	
	public function SetObjectOff(obj:FlxSprite):Void
	{
		objectsOn.set(Std.string(obj.x) + Std.string(obj.y), false);
		
		var keyCountMap:String = "powershaft";
		
		if ( Std.is(obj, Satellite) )
			keyCountMap = "satellite";
		else if ( Std.is(obj, LaserGun) )
			keyCountMap = "lasergun";
		
		var numObj:Null<Int> = numObjectsOn.get(keyCountMap);
		var count:Int = 0;
		if ( numObj != null )
		{
			count = numObj;
		}
		
		count--;
		
		if ( count < 0 )
			count = 0;
		
		numObjectsOn.set(keyCountMap, count );
	}	
	
	public function IsObjectOn(obj:FlxSprite):Bool
	{
		var val:Null<Bool> = objectsOn.get(Std.string(obj.x) + Std.string(obj.y));
		
		if ( val == null )
		{
			return false;
		}
		
		return val;
	}
	
	public function GetObjectOnCount(objType:String):Int
	{
		var count:Null<Int> = numObjectsOn.get(objType);
		
		if ( count == null ) 
		{
			return 0;
		}
		
		return count;
	}
	
	public function SetObjectStateFromCache(obj:FlxSprite):Void
	{
		if ( IsObjectOn(obj) )
		{
			obj.animation.play("on");
		}
		else
		{
			obj.animation.play("off");
		}
	}
	
}