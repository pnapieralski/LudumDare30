package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Phillip Napieralski
 */
class Tutorial extends FlxTypedGroup<FlxSprite>
{
	private var powershaft:FlxSprite = null;
	private var powerText:FlxText = null;
	
	private var lasergun:FlxSprite = null;
	private var laserText:FlxText = null;
	
	private var satellite:FlxSprite = null;
	private var satText:FlxText = null;
	
	public function new(MaxSize:Int=0) 
	{
		super(MaxSize);
		
		powershaft = new FlxSprite(5, FlxG.height - 64);
		powershaft.loadGraphic(AssetPaths.ImgPowerShaft, true, 32, 64);
		add(powershaft);
		
		lasergun = new FlxSprite(powershaft.x + 5, powershaft.y - 32);
		lasergun.loadGraphic(AssetPaths.ImgLaserGun, true, 96);
		add(lasergun);
		
		satellite = new FlxSprite(lasergun.x + 96, powershaft.y);
		satellite.loadGraphic(AssetPaths.ImgSatellite, true, 65);
		add(satellite);
		
		powerText = new FlxText(satellite.x + 64, satellite.y + satellite.height / 6.0 + 6, FlxG.width - 100, "Power shafts store energy that can be used", 8);
		add(powerText);
		
		laserText = new FlxText(satellite.x + 64, satellite.y + satellite.height / 6.0 + 18, FlxG.width - 100, "Laser guns shoot energy long distances", 8);
		add(laserText);
		
		satText = new FlxText(satellite.x + 64, satellite.y + satellite.height / 6.0 + 30, FlxG.width - 100, "Satellites use energy for communication", 8);
		add(satText);
		
		// No scrolling!
		forEach(function(spr:FlxSprite) { spr.scrollFactor.set(); FlxSpriteUtil.fadeIn(spr, 3, true); } );
	}
	
	override public function update():Void
	{
		super.update();
		
		forEach(function(spr:FlxSprite) {
			if ( spr.alpha > 0 )
			{
				spr.alpha -= 0.0015;
			}
		});
	}
	
}