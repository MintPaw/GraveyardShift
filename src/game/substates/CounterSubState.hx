package game.substates;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

/**
 * ...
 * @author MintPaw
 */
class CounterSubState extends MintSubState
{
	private var _counter1:FlxSprite;
	private var _counter2:FlxSprite;
	private var _isSnow:Bool;
	
	public function new(isSnow:Bool = false) 
	{
		super();
		_isSnow = isSnow;
	}
	
	override public function create():Void 
	{
		super.create();
		_bg.kill();
		
		_counter1 = new FlxSprite();
		_counter1.frames = FlxAtlasFrames.fromTexturePackerJson("img/gui/Get Ready 1.png", "img/gui/Get Ready 1.json");
		_counter1.animation.addByPrefix("default", "getReadyPart1_", 60, false);
		_counter1.animation.play("default");
		_counter1.x = FlxG.width / 2 - _counter1.width / 2 + 50;
		_counter1.y = FlxG.height / 2 - _counter1.height / 2 - 150;
		add(_counter1);
		
		_counter2 = new FlxSprite();
		_counter2.frames = FlxAtlasFrames.fromTexturePackerJson("img/gui/Get Ready 2.png", "img/gui/Get Ready 2.json");
		_counter2.animation.addByPrefix("default", "getReadyPart2_", 60, false);
		_counter2.animation.play("default");
		_counter2.x = FlxG.width / 2 - _counter2.width / 2 + 50;
		_counter2.y = _counter1.y + _counter1.height - 100;
		add(_counter2);
		
		if (_isSnow)
		{
			_counter1.color = _counter2.color = 0x33000000;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (_counter2.animation.finished) close();
		
		super.update(elapsed);
	}
	
}