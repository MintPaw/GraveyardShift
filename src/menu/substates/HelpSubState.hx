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
		trace("f");
		_help.animation.addByNames("d", [ "firehelp.png", "help0002.png", "help0003.png", "help0004.png", "help0005.png"], 0, false);
		#end
		#if ouya
		trace("o");
		_help.animation.addByNames("d", [ "ouyahelp.png", "help0002.png", "help0003.png", "help0004.png", "help0005.png"], 0, false);
		#end
		#if pc
		trace("p");
		_help.animation.addByNames("d", [ "pchelp.png", "help0002.png", "help0003.png", "help0004.png", "help0005.png"], 0, false);
		#end
		
		
		_help.animation.play("d");
		_help.x = FlxG.width / 2 - _help.width / 2;
		_help.y = FlxG.height / 2 - _help.height / 2;
		_container.add(_help);
		
		makePrompt(2);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.log.add(_help.animation.frameName);
		if (goRight && _help.animation.frameIndex < _help.animation.curAnim.numFrames - 1) _help.animation.frameIndex++;
		if (goLeft && _help.animation.frameIndex > 0) _help.animation.frameIndex--;
		if (goBack) close();
	}
	
}