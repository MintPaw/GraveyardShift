package game;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

/**
 * ...
 * @author MintPaw
 */
class Flare extends FlxSprite
{
	public var needToGoOff:Bool = false;
	
	public function new() 
	{
		super();
		
		frames = FlxAtlasFrames.fromTexturePackerJson("img/powerups/flare.png", "img/powerups/flare.json");
		animation.addByPrefix("default", "flareDrop");
		animation.play("default");
		
		health = 500;
		
		width = 1;
		height = 1;
		centerOffsets(true);
		
		var setOffTimer:FlxTimer = new FlxTimer();
		setOffTimer.start(1, setOff, 0);
	}
	
	private function setOff(timer:FlxTimer):Void
	{
		needToGoOff = true;
	}
	
}