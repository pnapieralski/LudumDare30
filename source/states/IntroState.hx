package states;

import flixel.addons.display.FlxStarField;
import flixel.addons.display.FlxStarField.FlxStarField2D;
import flixel.addons.effects.FlxGlitchSprite;
import flixel.addons.effects.FlxWaveSprite;
import flixel.addons.effects.FlxWaveSprite.FlxWaveMode;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the game's menu.
 */
class IntroState extends BaseState
{
	public static var lastStory:Int = 0;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		var stars:FlxStarField2D = new FlxStarField2D();
		stars.setStarSpeed(-5, -1);
		add(stars);
		
		//FlxG.switchState(new MarsState()); // XXX TODO TEMP
		
		FlxG.sound.play(AssetPaths.SndTakeOff);
		
		add(new Tutorial());
		
		addStory(["MARS COMMUNICATION SIMULATOR 2k14\nINSTRUCTIONS: Click stuff", "", 
			      "John! This is amazing, we landed on Mars!", 
				  "Be sure to **** a ***...", 
				  "",
				  "John, *** HEAR *** ME? *** . . .", ". . ."],
				  function(t:FlxTween)
					{						
						lastStory++;
						
						if ( lastStory == 2 )
						{
							FlxG.sound.play(AssetPaths.SndClap, 0.5);
						}

						
					}, // step callback
				  function(t:FlxTween) { 
						FlxG.camera.fade(FlxColor.BLACK, 1, false, function() {
							FlxG.switchState(new MarsState()); 
						});
					} // completed callback
				 );
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}