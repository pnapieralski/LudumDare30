package states;

import adventureObjects.LaserGun;
import adventureObjects.PowerShaft;
import adventureObjects.Satellite;
import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxCamera;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flxAdditions.FlxExtendedButton;
import playerClasses.EarthPlayer;
import playerClasses.PlanetModel;

/**
 * ...
 * @author Phillip Napieralski
 */
class EarthState extends BasePlanetState
{
	private var marsBg:FlxSprite = null;
	
	private var mars:FlxSprite = null;
	
	private static var lastStory:Int = 0;
	
	override public function create():Void
	{
		super.create();
		
		var stars:FlxStarField2D = new FlxStarField2D(0, 0, 1920, FlxG.height, 500);
		stars.scrollFactor.set(0.3, 0.8);
		stars.setStarSpeed(0, 1);
		add(stars);
		
		mars = new FlxSprite(300, 50, AssetPaths.ImgPlanetMars);
		mars.scrollFactor.set(0.1, 0.8);
		mars.scale.set(0.15, 0.15);
		add(mars);
		
		var clouds:FlxSprite = new FlxSprite(0, -50, AssetPaths.ImgClouds);
		clouds.scrollFactor.set(0.4, 0.4);
		add(clouds);
		
		if ( Reg.marsModel.GetObjectOnCount("lasergun") > 0 )
		{
			var lightning:FlxSprite = new FlxSprite(660, 0, AssetPaths.ImgLightning);
			lightning.alpha = 0.5;
			add(lightning);
		}
		
		if ( Reg.spawnMonsterBloodBath > 0 )
		{
			add( new Invader() );	
		}
		
		init(Reg.earthModel, EarthPlayer, AssetPaths.MapEarth, AssetPaths.TilesEarth, onSwitchToMarsState, "Switch to John (Mars)");
		
		addStory(["Jesus, poor John", 
				"All alone on Mars with no communication",
				"Let's see if I can fix this"], 
				function(t:FlxTween) { lastStory++; }, 
				null, 
				lastStory);
				
				
		if (Reg.spawnMonsterBloodBath > 0)
		{
			_switchPlanetButton.visible = false;

			addStory(["WHAT THE SHIT?", "HOW THE HELL AM I SUPPOSED TO..."]);
			
			FlxG.sound.playMusic(AssetPaths.MscBoss);
		}
	}
	
	override public function update():Void
	{
		super.update();
	}
	
	override public function clickedTech(tech:Dynamic, mouse:Dynamic):Bool
	{
		if ( Std.is(mouse, FlxSprite) && Std.is(tech, FlxSprite) )
		{
			var spr:FlxSprite = cast tech;
			
			// Turning the tech ON
			if ( spr.animation.name == "off" )
			{
				// Powershafts will turn on IF the laser gun on mars is shooting towards earth
				if ( Std.is(spr, PowerShaft) )
				{
					if ( Reg.marsModel.GetObjectOnCount("lasergun") > 0 )
					{
						spr.animation.play("on");
						_planetModel.SetObjectOn(spr);
						
						FlxG.sound.play(AssetPaths.SndBootUp);
					}
					else
					{
						FlxG.sound.play(AssetPaths.SndCantDoThat);
						if ( lastStory >= 1 )
						{
							addStory(["All our power sources seem to be disrupted...",
									  "I need to get the satellite back online...",
									  ""], 
									  function(t:FlxTween) { }, 								  
									  function(t:FlxTween) { } 
									  );
						}
					}
				}
				else if ( Std.is(spr, LaserGun) )
				{
					if ( Reg.spawnMonsterBloodBath == 0 )
					{
						addStory(["That won't help me contact John"]);
					}
					else if ( _planetModel.GetObjectOnCount("satellite") + 
						 _planetModel.GetObjectOnCount("lasergun") <
						 _planetModel.GetObjectOnCount("powershaft") )
					{
						spr.animation.play("on");
						_planetModel.SetObjectOn(spr);
						
						FlxG.sound.play(AssetPaths.SndBootUp);
						
						if ( _planetModel.GetObjectOnCount("lasergun") >= 3 )
						{							
							FlxG.camera.fade(FlxColor.WHITE, 2, false, function() {
								Reg.loseTheGame = false;
								FlxG.switchState(new EndState()); 
							});			
						}
					}
					else
					{
						shutoffPowerHogs();
						FlxG.sound.play(AssetPaths.SndCantDoThat);
						
						addStory(["Shit, not enough power!\nI overloaded the power shafts!"]);
					}
				}
				else if ( Std.is(spr, Satellite) )
				{
					if ( _planetModel.GetObjectOnCount("powershaft") > 0 )
					{
						FlxG.sound.play(AssetPaths.SndBootUp);
						
						spr.animation.play("on");
						_planetModel.SetObjectOn(spr);
					}
					else
					{
						FlxG.sound.play(AssetPaths.SndCantDoThat);
						addStory(["Not enough power"]);
					}
				}
				else 
				{
					FlxG.sound.play(AssetPaths.SndCantDoThat);
				}
			}
			else if ( spr.animation.name == "on" ) // Turning the tech OFF
			{
				spr.animation.play("off");
				_planetModel.SetObjectOff(spr);
			}
		}
		
		return super.clickedTech(tech, mouse);
	}
	
	private function onSwitchToMarsState():Void
	{
							FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() {
								FlxG.switchState(new MarsState()); 
							});			
	}
	
}