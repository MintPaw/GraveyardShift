package game;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.loaders.TexturePackerData;

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
		loadGraphicFromTexture(new TexturePackerData("img/bullets/explosion.json", "img/bullets/explosion.png"));
		animation.addByPrefix("default", "stickyExplosion", 30, false);
		animation.play("default");
	}
	
	override public function update():Void 
	{
		super.update();
		
		noHit = false;
		
		if (animation.finished) kill();
	}
	
}