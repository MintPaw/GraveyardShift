package menu;

import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author MintPaw
 */
class MenuItem extends FlxSpriteGroup
{
	public var data:Dynamic;
	public var state:String;
	
	public function new() 
	{
		super();
		
	}
	
	public function up():Void
	{
		state = "up";
	}
	
	public function over():Void
	{
		state = "over";
	}
	
	public function down():Void
	{
		state = "down";
	}
	
}