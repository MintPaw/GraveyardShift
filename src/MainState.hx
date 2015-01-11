package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.tweens.FlxTween;
import game.GameState;
import game.Player;
import game.Powerup;
import game.substates.ScoreboardSubState;
import input.InputManager;
import input.InputLayout;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.system.System;

/**
 * ...
 * @author MintPaw
 */
class MainState extends FlxState
{	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		FlxG.fixedTimestep = false;
		FlxG.sound.soundTrayEnabled = false;
		FlxG.mouse.visible = false;
		
		#if ouya
		FlxG.keys.enabled = false;
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		#end
		
		InputManager.init(FlxG.stage);
		FlxObject.SEPARATE_BIAS = 20;
		GameRules.setDefaults();
		InputManager.setToDefault();
		
		//Test scoreboard
		/*
		FlxG.cameras.bgColor = 0xFFFFFFFF;
		var player:Player = new Player(3, InputManager.keyboard1, -1, 0);
		player.score = 5;
		player.pointsToAdd = 5;
		GameRules.pointsToWin = 10;
		openSubState(new ScoreboardSubState([player, new Player(2, InputManager.keyboard2, -1, 1)]));
		return;
		*/
		
		//Test game
		
		/*
		Reg.players = [0, 3];
		GameRules.gameType = GameRules.SLAYER;
		GameRules.pointsToWin = 5;
		InputManager.layouts = [InputManager.keyboard1, InputManager.keyboard2];
		InputManager.currentDevicesIDs = [ -1, -1];
		GameRules.startingPowerup = Powerup.FLARE;
		GameRules.startingWeapon = Powerup.STICKY;
		Reg.skipCountdown = true;
		Reg.startGame(1);
		return;
		*/
		
		Sm.playSong(Sm.MAIN);
		Reg.startMenu();
	}
	
	private function onKeyUp(e:KeyboardEvent):Void 
	{
		if (e.keyCode == 16777234)
		{
			Reg.homePressed = true;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}