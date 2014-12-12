package game.substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import game.Player;
import input.InputLayout;
import input.InputManager;
import menu.Header;
import menu.MenuButton;
import menu.MenuItem;
import menu.MenuState;
import menu.SelectorRectangle;
import menu.ToggleButton;

/**
 * ...
 * @author MintPaw
 */
class PauseSubState extends MintSubState
{
	private var _player:Player;
	
	private var _buttons:Array<MenuItem>;
	private var _selectorRect:SelectorRectangle;
	private var _selectedIndex:Int;
	private var controllerDelay:Float = 0;
	
	public function new(player:Player = null) 
	{
		super();
		
		_player = player;
	}
	
	override public function create():Void 
	{
		super.create();
		
		_bg.makeGraphic(FlxG.width, FlxG.height, 0x88000000);
		
		/*var text:FlxText = new FlxText(0, 0, FlxG.width, "test\ntest\ntest\ntest", 20);
		text.alignment = "center";
		text.y = FlxG.height / 2 - text.height / 2;
		text.text = "The keyboard has paused\nEnter - Resume\nEscape - Back to Menu\nSpace - to mode select";
		if (_player != null) text.text = "Player " + Std.string(_player.playerNum + 1) + " has paused\nA - Resume\nB - Back to Menu\nY - to mode select";
		
		_container.add(text);*/
		
		_buttons = [];
		
		var lables:Array<String> = ["Resume", "Back to Main Menu"];
		
		var header:Header = new Header(_player != null ? "Player " + Std.string(_player.playerNum + 1) + " paused" : "Game paused", 600, 100, 40);
		header.spriteGraphic.color = 0xFFBF002F;
		header.x = FlxG.width / 2 - header.width / 2;
		header.y = FlxG.height / 2 - header.height / 2 - 100;
		add(header);
		
		for (i in 0...lables.length)
		{
			var b:ToggleButton = new ToggleButton(lables[i], header.width, header.height, 40);
			b.x = header.x;
			b.y = header.y + header.height + (b.height * i);
			add(b);
			
			_buttons.push(b);
		}
		
		_selectorRect = new SelectorRectangle();
		_selectorRect.makeGraphic(10, 10, 0xFFDB0036);
		add(_selectorRect);
		
		selectIndex(0, true);
		
		makePrompt(0);
	}
	
	override public function updateInput():Void 
	{
		super.updateInput();
		
		var toContinue:Bool = false;
		var toMenu:Bool = false;
		var toMode:Bool = false;
		
		var _goUp:Bool = false;
		var _goDown:Bool = false;
		var _goConfirm:Bool = false;
		var _goBack:Bool = false;
		
		if (animatingIn) return;
		
		controllerDelay -= FlxG.elapsed;
		
		for (i in 0...4)
		{
			var pad:FlxGamepad = FlxG.gamepads.getByID(i);
			if (pad == null) continue;
			
			#if fire
			if  (pad.getAxis(1) < -InputManager.deadZone) _goUp = true;
			if  (pad.getAxis(1) > InputManager.deadZone) _goDown = true;
			#else
			if  (pad.getYAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || pad.justReleased(InputLayout.DPAD_UP)) _goUp = true;
			if  (pad.getYAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || pad.justReleased(InputLayout.DPAD_DOWN)) _goDown = true;
			#end
			if  (pad.pressed(InputLayout.CONFIRM)) _goConfirm = true;
			if  (pad.pressed(InputLayout.DENY)) _goBack = true;
		}
		
		if (_player == null)
		{
			if (FlxG.keys.justPressed.UP) _goUp = true;
			if (FlxG.keys.justPressed.DOWN) _goDown = true;
			if (FlxG.keys.justPressed.ENTER) _goConfirm = true;
			if (FlxG.keys.justPressed.ESCAPE) _goBack = true;
		}
		
		if (!_goUp && !_goDown && !_goConfirm) controllerDelay = 0;
		
		if (controllerDelay > 0)
		{
			_goUp = _goDown = _goConfirm = _goBack = false;
			return;
		}
		
		if (_goUp || _goDown || _goConfirm || _goBack) controllerDelay = .2;
		
		if (_goUp && _selectedIndex > 0) selectIndex(_selectedIndex - 1);
		if (_goDown && _selectedIndex < 1) selectIndex(_selectedIndex + 1);
		
		if (_goConfirm)
		{
			if (_selectedIndex == 0) toContinue = true;
			if (_selectedIndex == 1) toMenu = true;
			if (_selectedIndex == 2) toMode = true;
		}
		
		if (toContinue) close();
		if (toMenu) FlxG.camera.fade(FlxColor.BLACK, 1, false, FlxG.switchState.bind(new MenuState()));
		
		if (toMode)
		{
			Reg.menuGoingToVersus = true;
			FlxG.camera.fade(FlxColor.BLACK, 1, false, FlxG.switchState.bind(new MenuState()));
		}
	}
	
	private function selectIndex(index:Int, force:Bool = false):Void
	{
		_selectedIndex = index;
		_selectorRect.gotoItem(_buttons[_selectedIndex], force, true);
	}
	
}