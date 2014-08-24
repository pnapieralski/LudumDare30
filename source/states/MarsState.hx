package states;

import adventureObjects.BaseAdventureObject;
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
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flxAdditions.FlxExtendedButton;
import playerClasses.MarsPlayer;
import adventureObjects.Rocket;

/**
 * ...
 * @author Phillip Napieralski
 */
class MarsState extends BasePlanetState
{
	public static var notDoneThisBefore:Bool = true;
	public static var lastStory:Int = 0;
	
	private var toEarthBtn:FlxExtendedButton = null;

	private var rocket:Rocket = null;
	
	private var earth:FlxSprite = new FlxSprite(400, 0);
	
	override public function create():Void
	{
		super.create();
	
		// BG stuff		
		var stars:FlxStarField2D = new FlxStarField2D(0, 0, 1920, FlxG.height, 500);
		stars.scrollFactor.set(0.4, 0.4);
		stars.setStarSpeed(1, 3);
		add(stars);
		
		earth = new FlxSprite(400, 0);
		earth.loadGraphic(AssetPaths.ImgPlanetEarth, true, 128);
		earth.animation.add("off", [0], 1);
		earth.animation.add("on", [1], 1);
		earth.animation.play("off");
		
		earth.scrollFactor.set(0.1, 0.1);
		earth.scale.set(0.15, 0.15);
		add(earth);
		
		rocket = new Rocket(0, 0);
		add(rocket);
	
		init(Reg.marsModel, MarsPlayer, AssetPaths.MapMars, AssetPaths.TilesMars, onSwitchToEarthState);
		
		// STORY TIME
		addStory([". . .",
				  "Ground control, can you hear me?",
				  ". . .",
				  "This is bullshit...",
				  ],
				  function(tween:FlxTween) {  MarsState.lastStory++;  },
				  function(tween:FlxTween) {  },
				  MarsState.lastStory);
	}
	
	override public function placeEntities(entityName:String, entityData:Xml):Void
	{
		super.placeEntities(entityName, entityData);
		
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if (entityName == "rocket")
		{
			rocket.x = x;
			rocket.y = y;
		}
	}
	
	override public function update():Void
	{
		super.update();
		
		if ( Reg.marsModel.GetObjectOnCount("satellite") > 0 && 
		     Reg.earthModel.GetObjectOnCount("satellite") > 0 && 
			 Reg.spawnMonsterBloodBath == 0 && 
			 notDoneThisBefore &&
			 !doneOnce )
		{
			doneOnce = true;
			
			// Story time, you no switch planet
			_switchPlanetButton.visible = false;
			
			(new FlxTimer(4, function(f:FlxTimer) { 
				
				// Have enemy swoop in the BG to earth
				var bgBoss:FlxSprite = new FlxSprite(0,0,AssetPaths.ImgEnemy);
				bgBoss.x = earth.x;
				bgBoss.y = earth.y;
				bgBoss.scrollFactor.set(earth.scrollFactor.x, earth.scrollFactor.y);
				bgBoss.x -= 300;
				bgBoss.y -= 250;
				bgBoss.velocity.x = 15;
				bgBoss.velocity.y = 5;
				bgBoss.scale.set(0.05, 0.05);
				add(bgBoss);				
			} ) );
			
			addStory(["Larry, do you read me?", "Woo, yes, LOUD AND CLEAR", "WAIT... DO YOU SEE THAT?", ". . ."], 
					null, 
					 function(t:FlxTween) {						
						FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function() {
							FlxG.switchState(new EarthState()); 
						});
						notDoneThisBefore = false;
						Reg.spawnMonsterBloodBath = 1; // YAY
					}
			);			
		}
		
		
		if ( FlxG.mouse.pressed )
		{
			//FlxG.overlap(rocket, new FlxSprite(FlxG.mouse.getWorldPosition().x, FlxG.mouse.getWorldPosition().y), clickedTech);
		}
	}
	
	override private function shutoffPowerHogs():Void
	{
		super.shutoffPowerHogs();
		earth.animation.play("off");
	}
	
	override public function clickedTech(tech:Dynamic, mouse:Dynamic):Bool
	{
		if ( Std.is(mouse, FlxSprite) && Std.is(tech, FlxSprite) )
		{
			var spr:FlxSprite = cast tech;
			
			// Turning the tech ON
			if ( spr.animation.name == "off" )
			{
				// If satellite is turned on, make sure there is enough power
				// IF THERE IS NOT ENOUGH POWER, EVERYTHING SHUTS OFF
				if ( Std.is(spr, Satellite) || Std.is(spr, LaserGun) )
				{
					if ( _planetModel.GetObjectOnCount("satellite") + 
						 _planetModel.GetObjectOnCount("lasergun") <
						 _planetModel.GetObjectOnCount("powershaft") )
					{
						spr.animation.play("on");
						_planetModel.SetObjectOn(spr);
						
						if ( Std.is(spr, LaserGun) )
						{
							earth.animation.play("on");
						}
						
						FlxG.sound.play(AssetPaths.SndBootUp);
					}
					else
					{
						shutoffPowerHogs();
						FlxG.sound.play(AssetPaths.SndCantDoThat);
						
						addStory(["not enough power\nlooks like everything shut off"]);
					}
				}
				
				if ( Std.is(spr, PowerShaft) )
				{
					spr.animation.play("on");
					_planetModel.SetObjectOn(spr);
					
					FlxG.sound.play(AssetPaths.SndBootUp);
					
				}
			}
			else if ( spr.animation.name == "on" ) // Turning the tech OFF
			{
				if ( Std.is(spr, BaseAdventureObject) )
				{
					spr.animation.play("off");
					_planetModel.SetObjectOff(spr);	
					
					if ( Std.is(spr, LaserGun) )
					{
						earth.animation.play("off");
					}
				}
				
				// If they are turning off PowerShafts - make sure there is enough power to run things... otherwise everything shuts off!
				if ( Std.is(spr, PowerShaft) )
				{
					if ( _planetModel.GetObjectOnCount("satellite") +
						 _planetModel.GetObjectOnCount("lasergun") >=
						 _planetModel.GetObjectOnCount("powershaft") )
					{
						shutoffPowerHogs();
						FlxG.sound.play(AssetPaths.SndShutDown);
					}
				}
			}
		}
		
		return super.clickedTech(tech, mouse);
	}
	
	private function onSwitchToEarthState():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.25, false, function() {
			FlxG.switchState(new EarthState()); 
		});
	}
	
}