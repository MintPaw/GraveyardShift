package menu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.graphics.frames.FlxAtlasFrames;
import input.InputLayout;
import input.InputManager;
import openfl.Assets;

/**
 * ...
 * @author MintPaw
 */
class PlayerSelectSlot extends FlxSpriteGroup
{
	private var _background:FlxSprite;
	
	private var _joinConsoleKey:FlxSprite;
	private var _joinKeyboardKey:KeyboardButton;
	private var _joinKeyboardKey2:KeyboardButton;
	
	private var _layout:InputLayout;
	private var _controllerID:Int;
	
	private var _buttons:Array<MenuItem>;
	private var _selectedIndex:Int = -1;
	private var _controllerDelay:Float = 0;
	private var _selectorRect:SelectorRectangle;
	private var _playerText:FlxText;
	private var _canLeftFrom:Array<Int>;
	private var _canRightFrom:Array<Int>;
	
	public var ready:Bool = false;
	public var joined:Bool = false;
	public var selectedColour:Int = -1;
	public var avalColours:Array<Bool>;
	
	public function new(playerNum:Int) 
	{
		super();
		
		_background = new FlxSprite(0, 0, "img/menu/grey_join.json");
		add(_background);
		
		#if ouya
		_joinConsoleKey = new FlxSprite(0, 0, "img/menu/ouya_toJoin.json");
		_joinConsoleKey.x = width / 2 - _joinConsoleKey.width / 2;
		_joinConsoleKey.y = height / 2 - _joinConsoleKey.height / 2;
		add(_joinConsoleKey);
		#elseif fire
		_joinConsoleKey = new FlxSprite(0, 0, "img/menu/fire_toJoin.json");
		_joinConsoleKey.x = width / 2 - _joinConsoleKey.width / 2;
		_joinConsoleKey.y = height / 2 - _joinConsoleKey.height / 2;
		add(_joinConsoleKey);
		#elseif pc
		_joinConsoleKey = new FlxSprite(0, 0, "img/menu/xbox_a_button.json");
		_joinConsoleKey.x = width / 2 - 60 - _joinConsoleKey.width / 2;
		_joinConsoleKey.y = height / 2 - _joinConsoleKey.height / 2;
		add(_joinConsoleKey);
		
		_joinKeyboardKey = new KeyboardButton(InputManager.keyboard1.moveUp);
		_joinKeyboardKey.x = width / 2 - _joinKeyboardKey.width / 2;
		_joinKeyboardKey.y = height / 2 - _joinKeyboardKey.height / 2;
		add(_joinKeyboardKey);
		
		_joinKeyboardKey2 = new KeyboardButton(InputManager.keyboard2.moveUp);
		_joinKeyboardKey2.x = width / 2 + 60 - _joinKeyboardKey2.width / 2;
		_joinKeyboardKey2.y = height / 2 - _joinKeyboardKey2.height / 2;
		add(_joinKeyboardKey2);
		#end
		
		_playerText = new FlxText(10, 15, width, "Player " + Std.string(playerNum + 1), 40);
		_playerText.alignment = "center";
		_playerText.font = "dekar";
		add(_playerText);
	}
	
	public function join(layout:InputLayout, controllerID:Int):Void
	{
		_layout = layout;
		_controllerID = controllerID;
		_buttons = [];
		joined = true;
		
		#if ouya
		_joinConsoleKey.kill();
		#else
		_joinConsoleKey.kill(); _joinKeyboardKey.kill(); _joinKeyboardKey2.kill();
		#end
		
		_background.loadGraphic(Assets.getBitmapData("img/menu/0_join.json"));
		
		var buttonSpacing:Int = 10;
		
		for (i in 0...5)
		{
			var b:ToggleButton = new ToggleButton("", 45, 45, 10);
			b.button.frames = FlxAtlasFrames.fromTexturePackerJson("img/menu/Player Menu.png", "img/menu/Player Menu.json");
			b.button.animation.addByPrefix("default", "playerSelectBox_shine_" + i + "_", 60, false);
			b.button.animation.play("default", false);
			b.x = i * (b.width + buttonSpacing) + (width - (b.width + buttonSpacing) * 5) / 2;
			b.y = height / 2 - b.height / 2 - 150;
			add(b);
			
			_buttons.push(b);
		}
		
		_selectorRect = new SelectorRectangle();
		add(_selectorRect);
		
		selectIndex(0, true);
		
		var inputIcon:FlxSprite = new FlxSprite();
		if (_layout.isController) inputIcon.loadGraphic("img/gui/controller_p" + Std.string(_controllerID + 1) + ".json")
		else
		{
			if (_layout.moveUp == InputManager.keyboard1.moveUp) inputIcon.loadGraphic("img/gui/keyboard_p1.json");
			if (_layout.moveUp == InputManager.keyboard2.moveUp) inputIcon.loadGraphic("img/gui/keyboard_p2.json");
		}
		inputIcon.x = _background.width / 2 - inputIcon.width / 2;
		inputIcon.y = _background.height - inputIcon.height - 40;
		add(inputIcon);
		
		#if ouya
		var controls:FlxSprite = new FlxSprite(0, 0, "img/menu/controls_ouya.json");
		controls.x = _background.width / 2 - controls.width / 2;
		controls.y = 300;
		add(controls);
		#else
		if (_layout.isController)
		{
			var controls:FlxSprite = new FlxSprite(0, 0, "img/menu/controls_xbox.json");
			controls.x = _background.width / 2 - controls.width / 2;
			controls.y = 300;
			add(controls);
		} else {
			var controls:FlxSprite = new FlxSprite(0, 0, "img/menu/controls_keyboard.json");
			controls.x = _background.width / 2 - controls.width / 2;
			controls.y = 300;
			add(controls);
			
			var buttons:Array<KeyboardButton> = [];
			
			var keys:Array<Int> =
			[
				_layout.moveUp,
				_layout.moveDown,
				_layout.moveLeft,
				_layout.moveRight,
				_layout.shoot,
				_layout.dash,
				_layout.item
			];
			
			var poses:Array<FlxPoint> = 
			[
				new FlxPoint(-44, -203),
				new FlxPoint(-44, -160),
				new FlxPoint(-87, -160),
				new FlxPoint(-1, -160),
				new FlxPoint(-44, -110),
				new FlxPoint(-44, -60),
				new FlxPoint(-44, -15)
			];
			
			for (i in 0...7)
			{
				var b:KeyboardButton = new KeyboardButton(keys[i]);
				b.x = poses[i].x + _background.width / 2 - 100 + 20 - 1 - 1;
				b.y = poses[i].y + _background.height / 2 + 200 - 40 + 1;
				add(b);
			}
		}
		#end
		
		_controllerDelay = .2;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (_layout == null || ready) return;
		
		var goLeft:Bool = false;
		var goRight:Bool = false;
		var goConfirm:Bool = false;
		var goBack:Bool = false;
		
		_controllerDelay -= FlxG.elapsed;
		
		if (_layout.isController)
		{
			var pad:FlxGamepad = FlxG.gamepads.getByID(_controllerID);
			if (pad == null) return;
			
			#if fire
			if (pad.getAxis(0) < -InputManager.deadZone) goLeft = true;
			if (pad.getAxis(0) > InputManager.deadZone) goRight = true;
			#else
			if (pad.getXAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || pad.justReleased(InputLayout.DPAD_LEFT)) goLeft = true;
			if (pad.getXAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || pad.justReleased(InputLayout.DPAD_RIGHT)) goRight = true;
			#end
			
			if (pad.pressed(InputLayout.CONFIRM)) goConfirm = true;
			if (pad.pressed(InputLayout.DENY)) goBack = true;
			
		} else {
			if (FlxG.keys.checkStatus(_layout.moveLeft, FlxInputState.JUST_PRESSED)) goLeft = true;
			if (FlxG.keys.checkStatus(_layout.moveRight, FlxInputState.JUST_PRESSED)) goRight = true;
			if (FlxG.keys.checkStatus(_layout.shoot, FlxInputState.JUST_PRESSED)) goConfirm = true;
			if (FlxG.keys.checkStatus(_layout.dash, FlxInputState.JUST_PRESSED)) goBack = true;
		}
		
		if (_controllerDelay > 0) return;
		
		if (goLeft || goRight || goConfirm) _controllerDelay = .2;
		
		_canLeftFrom = [1, 2, 3, 4];
		_canRightFrom = [0, 1, 2, 3];
		
		if (goLeft && _canLeftFrom.indexOf(_selectedIndex) >= 0) selectIndex(_selectedIndex - 1);
		if (goRight && _canRightFrom.indexOf(_selectedIndex) >= 0) selectIndex(_selectedIndex + 1);
		
		if (_layout.isController) FlxG.log.add(goConfirm);
		
		if (goConfirm)
		{
			if (!avalColours[_selectedIndex]) return;
			//_buttons[_selectedIndex].down();
			
			FlxTween.tween(_buttons[_selectedIndex].scale, { x: 1.5, y: 1.5 }, .15);
			FlxTween.tween(_buttons[_selectedIndex].scale, { x: 1, y: 1 }, .15, { startDelay: .15 } );
			
			var readyCover:FlxSprite = new FlxSprite(0, 0, "img/menu/ready_join.json");
			readyCover.x -= (readyCover.width - _background.width) / 2;
			readyCover.y -= (readyCover.height - _background.height) / 2;
			readyCover.alpha = 0;
			add(readyCover);
			
			FlxTween.tween(readyCover, { alpha: 1 }, 1);
			
			new FlxTimer().start(.5, function c(t:FlxTimer):Void { ready = true; }, 1);
		}
		
		for (i in 0...avalColours.length) if (!avalColours[i]) _buttons[i].alpha = .5;
	}
	
	private function selectIndex(index:Int, force:Bool = false):Void
	{
		if (!avalColours[index])
		{
			if (_selectedIndex == -1) index++
			else if (index < _selectedIndex) if (_canLeftFrom.indexOf(index) >= 0) index-- else return
			else if (index > _selectedIndex) if (_canRightFrom.indexOf(index) >= 0) index++ else return;
		}
		
		_selectedIndex = index;
		selectedColour = index;
		
		_background.loadGraphic(Assets.getBitmapData("img/menu/" + _selectedIndex +  "_join.json"));
		cast(_buttons[_selectedIndex], ToggleButton).button.animation.play("default");
		
		_selectorRect.gotoItem(_buttons[_selectedIndex], force);
	}
	
}