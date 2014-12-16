package menu.substates;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

/**
 * ...
 * @author MintPaw
 */
class HelpSubState extends MintSubState
{
	private var _help:FlxSprite;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		_help = new FlxSprite();
		_help.frames = FlxAtlasFrames.fromTexturePackerJson("img/menu/help.png", "img/menu/help.json");
		
		#if fire
		_help.animation.addByNames("default", [ "help0001_fire.png", "help0002.png", "help0003.png", "help0004.png", "help0005.png"], 0, false);
		#elseif ouya
		_help.animation.addByNames("default", [ "help0001_ouya.png", "help0002.png", "help0003.png", "help0004.png", "help0005.png"], 0, false);
		#elseif pc
		_help.animation.addByNames("default", [ "help0001.png", "help0002.png", "help0003.png", "help0004.png", "help0005.png"], 0, false);
		#end
		_help.animation.play("default");
		_help.x = FlxG.width / 2 - _help.width / 2;
		_help.y = FlxG.height / 2 - _help.height / 2;
		_container.add(_help);
		
		makePrompt(2);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (goRight && _help.animation.frameIndex < _help.animation.curAnim.numFrames - 1) _help.animation.frameIndex++;
		if (goLeft && _help.animation.frameIndex > 0) _help.animation.frameIndex--;
		if (goBack) close();
	}
	
}