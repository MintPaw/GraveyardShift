package game;

import flixel.FlxBasic;
import flixel.FlxSprite;

/**
 * ...
 * @author MintPaw
 */
class Shade extends FlxSprite
{
	public var parent:FlxSprite;
	
	public function new(parent:FlxSprite, type:Int = 0) 
	{
		super();
		
		this.parent = parent;
		
		if (type == 0) loadGraphic("img/map/crateShading.json");
		if (type == 1) loadGraphic("img/map/metalShading.json");
	}
	
	override public function draw():Void 
	{
		if (!parent.alive) kill();
		x = parent.x;
		y = parent.y + parent.height;
		
		super.draw();
	}
	
}