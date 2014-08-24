package states;

import adventureObjects.BaseAdventureObject;
import adventureObjects.LaserGun;
import adventureObjects.PowerShaft;
import adventureObjects.Satellite;
import flash.filters.DropShadowFilter;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.effects.FlxWaveSprite;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.CompleteCallback;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flxAdditions.FlxExtendedButton;
import playerClasses.EarthPlayer;
import playerClasses.PlanetModel;
import states.BaseState;

/**
 * ...
 * @author Phillip Napieralski
 */
class BasePlanetState extends BaseState
{
	private var doneOnce:Bool = false;
	
	private var _player:Dynamic = null;
	private var _map:FlxOgmoLoader = null;
	private var _ground:FlxTilemap = null;
	private var _satellites:FlxTypedGroup<Satellite> = null;
	private var _laserguns:FlxTypedGroup<LaserGun> = null;
	private var _powershafts:FlxTypedGroup<PowerShaft> = null;
	
	private var _planetModel:PlanetModel = null;
	
	private var _switchPlanetButton:FlxExtendedButton = null;
	
	public function init(model:PlanetModel, playerType:Dynamic, mapAsset:Dynamic, tileGrounds:Dynamic, onButtonClick:Void->Void, buttonText:String = "Switch to Larry (Earth)"):Void
	{
		_planetModel = model; // IMPORTANT
		
		// load map
		_map = new FlxOgmoLoader(mapAsset);
		_ground = _map.loadTilemap(tileGrounds, 16, 16, "grounds");
		
		// Don't collide with angled tiles
		_ground.setTileProperties(4, FlxObject.NONE);
		_ground.setTileProperties(5, FlxObject.NONE);
		_ground.setTileProperties(6, FlxObject.NONE);
		_ground.setTileProperties(7, FlxObject.NONE);
		_ground.setTileProperties(8, FlxObject.NONE);
		_ground.setTileProperties(9, FlxObject.NONE);
		add(_ground);
		
		_satellites = new FlxTypedGroup<Satellite>();
		add(_satellites);
		
		_laserguns = new FlxTypedGroup<LaserGun>();
		add(_laserguns);
		
		_powershafts = new FlxTypedGroup<PowerShaft>();
		add(_powershafts);
		
		_player = Type.createInstance(playerType, []);
		add(_player);
		
		_map.loadEntities(placeEntities, "entities");
		
		_switchPlanetButton = new FlxExtendedButton(0, 0, onButtonClick, buttonText, 100, 25);
		_switchPlanetButton.scrollFactor.set();
		add(_switchPlanetButton);
		
		FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, new FlxPoint(0, 128));
		
		FlxG.sound.playMusic(AssetPaths.Msc1);
	}	
	
	public function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if (entityName == "player")
		{
			if ( _planetModel.playerPosition.x != 0 && _planetModel.playerPosition.y != 0 )
			{
				_player.x = _planetModel.playerPosition.x;
				_player.y = _planetModel.playerPosition.y;
			}
			else
			{
				_player.x = x;
				_player.y = y - 14;
			}
		}
		else if (entityName == "powershaft")
		{
			var p:PowerShaft = new PowerShaft(x, y);
			_planetModel.SetObjectStateFromCache(p);
			_powershafts.add(p);
		}
		else if (entityName == "satellite")
		{
			var s:Satellite = new Satellite(x, y);
			_planetModel.SetObjectStateFromCache(s);
			_satellites.add(s);
		}
		else if (entityName == "lasergun")
		{
			var lg:LaserGun = new LaserGun(x, y);
			_planetModel.SetObjectStateFromCache(lg);
			_laserguns.add(lg);
		}
	}
	
	override public function update():Void
	{
		super.update();
		
		FlxG.collide(_player, _ground);
		
		if ( FlxG.mouse.justPressed )
		{
			FlxG.overlap(_satellites, new FlxSprite(FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y), clickedTech);
			FlxG.overlap(_laserguns, new FlxSprite(FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y), clickedTech);
			FlxG.overlap(_powershafts, new FlxSprite(FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y), clickedTech);
		}
	}
	
	private function shutoffPowerHogs():Void
	{
		_laserguns.forEach(function(spr:FlxSprite) { 
			spr.animation.play("off"); 
			_planetModel.SetObjectOff(spr);
		} );
		_satellites.forEach(function(spr:FlxSprite) { 
			spr.animation.play("off"); 
			_planetModel.SetObjectOff(spr);
		} );
	}
	
	public function clickedTech(tech:Dynamic, mouse:Dynamic):Bool
	{		
		return true;
	}
	
}