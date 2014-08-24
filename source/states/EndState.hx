package states;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flxAdditions.FlxExtendedButton;
import openfl.Lib;
import flash.net.URLRequest;

/**
 * ...
 * @author Phillip Napieralski
 */
class EndState extends BaseState
{

	override public function create():Void
	{
		FlxG.sound.playMusic(AssetPaths.Msc1);
		
		var _creditsBtn:FlxExtendedButton = new FlxExtendedButton(0, FlxG.height - 20, 
																function() {		
																	Lib.getURL(new URLRequest("http://fantongstudios.com")); 
																});
						
		_creditsBtn.visible = false;
		add(_creditsBtn);
		
		if ( Reg.loseTheGame )
		{
			addStory([". . .", ""], 
					  null,
					  function(f:FlxTween) {
						FlxG.camera.fade(FlxColor.BLACK, 1, false, function() {
							
							MarsState.notDoneThisBefore = true;
							Reg.spawnMonsterBloodBath = 0;
							
							FlxG.switchState(new MarsState()); 
						});
					  });
		}
		else
		{
			addStory(["I can't believe I killed it...",
				      "It looks like all of our communication gear was destroyed...",
					  "I hope John is all right...", 
					  "THE END"],
					  null,
					  function(t:FlxTween) { /*_creditsBtn.visible = true;*/ }
					);			
					
		}
	}
}