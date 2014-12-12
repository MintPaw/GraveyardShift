package game;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author MintPaw
 */
class Crate extends FlxSprite
{
	public var needToBreak:Bool = false;
	public function new() 
	{
		super(0, 0, "img/map/crate.png");
		
		health = 80;
	}
	
	override public function kill():Void 
	{
		super.kill();
		
		needToBreak = true;
	}
	
}