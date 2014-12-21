package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import game.GameState;
import input.InputManager;
import openfl.display.FPS;
import openfl.text.TextField;

/**
 * ...
 * @author MintPaw
 */

class Main extends Sprite 
{
	public var flixel:FlxGame;

	public function new() 
	{
		super();	
		
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	public function init(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		startGame();
	}
	
	private function startGame():Void
	{
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		
		flixel = new FlxGame(1920, 1080, MainState, 1, 60, 60, true, true);
		addChild(flixel);
		
		Reg.debugBox = new TextField();
		Reg.debugBox.width = 1920;
		Reg.debugBox.height = 500;
		Reg.debugBox.textColor = 0xFFFFFF;
		//stage.addChild(Reg.debugBox);
		
		//addChild(new FPS(10, 10, 0xFFFFFF));
	}
}
