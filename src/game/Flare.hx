package game;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import flixel.util.loaders.TexturePackerData;

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
		
		loadGraphicFromTexture(new TexturePackerData("img/powerups/flare.json", "img/powerups/flare.png"));
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