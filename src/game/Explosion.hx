package game;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author MintPaw
 */
class Explosion extends FlxSprite
{
	public var playerThatShot:Player;
	public var noHit:Bool = true;

	public function new() 
	{
		super();
		frames = FlxAtlasFrames.fromTexturePackerJson("img/bullets/explosion.png", "img/bullets/explosion.json");
		animation.addByPrefix("default", "stickyExplosion", 30, false);
		animation.play("default");
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		noHit = false;
		
		if (animation.finished) kill();
	}
	
}