package playerClasses;

import flixel.addons.display.FlxExtendedSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Phillip Napieralski
 */
class Player extends FlxSprite
{
	private var canJump:Bool = true;
	
	public function new() 
	{
		super();		
		drag.set(50, 0);
	}
	
	private function setupAnimations():Void
	{
		animation.add("idle", [0], 1);
		animation.add("run", [1, 2, 3], 6);
		animation.add("jump", [4, 5, 6, 7], 4);
		animation.play("idle");
	}
	
	override public function update():Void
	{		
		super.update();
		
		var X_SPEED:Int = 100;
		var JUMP_SPEED:Int = 110;
		
		if ( FlxG.mouse.pressed )
		{
			velocity.x = FlxMath.bound(FlxG.mouse.x - x, -X_SPEED, X_SPEED);
		}
		else if ( FlxG.keys.pressed.D )
		{
			velocity.x = X_SPEED;
		}
		else if ( FlxG.keys.pressed.A )
		{
			velocity.x = -X_SPEED;
		}
		
		if ( (FlxG.keys.pressed.SPACE || FlxG.keys.pressed.W) && canJump == true)
		{
			y -= 1; // nudge off the tilemap
			velocity.y = -JUMP_SPEED;
			canJump = false;
			
			(new FlxTimer()).start(0.5, function(timer:FlxTimer) { canJump = true; } );
		}
		
		// Set animation
		if ( velocity.y < -5 )
		{
			animation.play("jump");
		}
		else if ( Math.abs(velocity.x) > 1 )
		{
			animation.play("run");
		}
		else
		{
			animation.play("idle");
		}
		
		// Face him the correct way
		if (velocity.x < -1)
		{
			facing = FlxObject.LEFT;
			flipX = true;
		}
		else if ( velocity.x > 1 )
		{
			facing = FlxObject.RIGHT;
			flipX = false;
		}
		
		
		// SLOW him down!
		if ( velocity.x > 0 )
		{
			acceleration.x = -drag.x;
		}
		else 
		{
			acceleration.x = drag.x;
		}
	}
}