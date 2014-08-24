package ;

import flixel.addons.effects.FlxGlitchSprite;
import flixel.addons.effects.FlxWaveSprite;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import polish.Fx;
import states.EndState;

/**
 * ...
 * @author Phillip Napieralski
 */
class Invader extends FlxGlitchSprite
{
	private var timer:Int = 0;
	private var fx:Fx = new Fx();
	private var impact:FlxSprite = null;
	
	public function new() 
	{
		var baseSprite:FlxSprite = new FlxSprite();
		baseSprite.loadGraphic(AssetPaths.ImgEnemy);
		baseSprite.scale.set(0.5, 0.5);
		super(baseSprite, 2, 1, 0.05);
		
		scrollFactor.set(0.1, 0.1);
		
		impact = new FlxSprite();
		impact.loadGraphic(AssetPaths.ImgImpact, true, 128, 128);
		impact.x = 100;
		impact.y = 30;
		impact.scale.set(0.5, 0.5);
		impact.animation.add("on", [0, 1, 2], 10);
		impact.scrollFactor.set(0.1, 0.1);
		impact.animation.play("on");
		
		FlxG.sound.playMusic(AssetPaths.MscBoss);
		
		//loadGraphic(AssetPaths.ImgEnemy);
		
		// long enough
		(new FlxTimer(12, function(f:FlxTimer) { 
			Reg.loseTheGame = true;
			
			FlxG.camera.fade(FlxColor.BLACK, 3, false, function() {
				FlxG.switchState(new EndState()); 
			});			
		} ));
		
		FlxG.camera.shake(0.01, 15);
	}
	
	override public function update():Void
	{
		super.update();
		
		var EXPLOSION_TIME:Int = 40;
		
		if ( ++ timer >= EXPLOSION_TIME )
		{
			timer = 0;
			
			fx.explodeBigger(x + FlxG.random.float(0, width) + FlxG.camera.scroll.x, y + FlxG.random.float(0, height / 3) + FlxG.camera.scroll.y);
			FlxG.sound.play(AssetPaths.SndExplosion, 0.05);
		}
		
		fx.update();
		impact.update();
	}
	
	override public function draw():Void
	{
		super.draw();
		
		if ( Reg.earthModel.GetObjectOnCount("lasergun") > 0 )
		{
			impact.scale.x = Reg.earthModel.GetObjectOnCount("lasergun") / 7;
			impact.scale.y = Reg.earthModel.GetObjectOnCount("lasergun") / 7;
			impact.draw();
		}
		
		fx.draw();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
}