package menu.substates;
import flash.display.StageDisplayState;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyboard.FlxKeyInput;

import flixel.math.FlxMath;
import input.InputManager;
import menu.Header;
import menu.MenuItem;
import menu.SelectorRectangle;
import menu.ToggleButton;

/**
 * ...
 * @author MintPaw
 */
class OptionsSubState extends MintSubState
{
	private var _selectorRect:SelectorRectangle;
	private var _selectedIndex:Int;
	private var _selectedGroup:Int;
	private var _settingKey:Int = -1;
	
	private var _buttons:Array<MenuItem>;
	private var _buttonIndexGroups:Array<Array<Int>>;
	private var _keyboardButtonHeaders:Array<Header>;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		_buttons = [];
		_buttonIndexGroups = [];
		_keyboardButtonHeaders = [];
		
		makeMenuGroup("Fullscreen", ["On", "Off"], 400, 90, 200, 90, 90, 20, 250, 120, 30);
		makeMenuGroup("Anti-Aliasing", ["On", "Off"], 400, 90, 200, 90, 90, 20, 250, 120, 30);
		makeMenuGroup("Music Volume", ["", "", "", "", "", "", "", "", "", "", ""], 400, 90, 30, 3, 80, 20, 250, 120, 30);
		makeMenuGroup("SFX Volume", ["", "", "", "", "", "", "", "", "", "", ""], 400, 90, 30, 3, 80, 20, 250, 120, 30);
		//makeMenuGroup("Brightness", ["", "", "", "", "", "", "", "", "", ""], 400, 90, 30, 3, 80, 20, 250, 120, 30);
		makeMenuGroup("Data", ["Reset To default"], 400, 90, 400, 90, 90, 20, 250, 120, 120);
		
		makeKeyboardGroup(0);
		makeKeyboardGroup(1);
		
		showKeys();
		
		_selectorRect = new SelectorRectangle();
		_container.add(_selectorRect);
		selectIndex(0, true);
		
		FlxG.camera.follow(_selectorRect);
		FlxG.camera.setScrollBounds(0, FlxG.width, 0, _buttons[_buttons.length - 1].y + _buttons[_buttons.length - 1].height + 50);
		
		setupValues();
		makePrompt(0);
	}
	
	override public function updateInput():Void 
	{
		super.updateInput();
		
		if (_settingKey != -1)
		{
			if (FlxG.keys.firstJustPressed() != "")
			{
				setKey(_settingKey, FlxG.keys.firstJustPressed());
				_settingKey = -1;
			}
			return;
		}
		
		if (goLeft) if (_buttonIndexGroups[_selectedGroup].indexOf(_selectedIndex) != 0) selectIndex(_selectedIndex - 1);
		if (goRight) if (_buttonIndexGroups[_selectedGroup].indexOf(_selectedIndex) != _buttonIndexGroups[_selectedGroup].length - 1) selectIndex(_selectedIndex + 1);
		if (goDown) if (_buttonIndexGroups[_selectedGroup + 1] != null) selectIndex(_buttonIndexGroups[_selectedGroup + 1][0]);
		if (goUp) if (_buttonIndexGroups[_selectedGroup - 1] != null) selectIndex(_buttonIndexGroups[_selectedGroup - 1][0]);
		if (goBack) close();
		
		if (goConfirm)
		{
			//keys
			if (_selectedGroup >= 6)
			{
				_settingKey = _selectedGroup;
				cast(_buttons[_buttonIndexGroups[_selectedGroup][0]].data, Header).changeText("Press a key");
				return;
			}
			
			//general
			for (i in 0..._buttonIndexGroups[_selectedGroup].length) _buttons[_buttonIndexGroups[_selectedGroup][i]].up();
			_buttons[_selectedIndex].down();
			
			if (_selectedIndex == 0)
			{
				Reg.fullscreen = true;
				FlxG.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			if (_selectedIndex == 1)
			{
				Reg.fullscreen = false;
				FlxG.stage.displayState = StageDisplayState.NORMAL;
			}
			if (_selectedIndex == 2) Reg.aa = true;
			if (_selectedIndex == 3) Reg.aa = false;
			if (_selectedIndex >= 4 && _selectedIndex <= 14) Reg.musicVolume = (_selectedIndex - 4) * 10;
			if (_selectedIndex >= 15 && _selectedIndex <= 25) Reg.sfxVolume = (_selectedIndex - 15) * 10;
			//if (_selectedIndex >= 26 && _selectedIndex <= 35) Reg.brightness = (_selectedIndex - 25) * 10;
			
			setupValues();
		}
	}
	
	private function setupValues():Void
	{
		_buttons[Reg.fullscreen? 0 : 1].down();
		_buttons[Reg.aa ? 2 : 3].down();
		
		for (i in 0...Math.round(Reg.musicVolume / 10)) _buttons[_buttonIndexGroups[2][i]].down();
		for (i in 0...Math.round(Reg.sfxVolume / 10)) _buttons[_buttonIndexGroups[3][i]].down();
		//for (i in 0...Math.round(Reg.brightness / 10)) _buttons[_buttonIndexGroups[4][i]].down();
	}
	
	private function setKey(groupIndex:Int, keycode:Int)
	{
		var start:Int = 4;
		if (groupIndex == start + 1) InputManager.keyboard1.moveUp = keycode;
		if (groupIndex == start + 2) InputManager.keyboard1.moveDown = keycode;
		if (groupIndex == start + 3) InputManager.keyboard1.moveLeft = keycode;
		if (groupIndex == start + 4) InputManager.keyboard1.moveRight = keycode;
		if (groupIndex == start + 5) InputManager.keyboard1.shoot = keycode;
		if (groupIndex == start + 6) InputManager.keyboard1.dash = keycode;
		if (groupIndex == start + 7) InputManager.keyboard1.item = keycode;
		if (groupIndex == start + 8) InputManager.keyboard2.moveUp = keycode;
		if (groupIndex == start + 9) InputManager.keyboard2.moveDown = keycode;
		if (groupIndex == start + 10) InputManager.keyboard2.moveLeft = keycode;
		if (groupIndex == start + 11) InputManager.keyboard2.moveRight = keycode;
		if (groupIndex == start + 12) InputManager.keyboard2.shoot = keycode;
		if (groupIndex == start + 13) InputManager.keyboard2.dash = keycode;
		if (groupIndex == start + 14) InputManager.keyboard2.item = keycode;
		showKeys();
	}
	
	private function selectIndex(index:Int, force:Bool = false):Void
	{
		_selectedIndex = index;
		
		for (i in 0..._buttonIndexGroups.length) if (_buttonIndexGroups[i].indexOf(_selectedIndex) >= 0) _selectedGroup = i;
		
		_selectorRect.gotoItem(_buttons[_selectedIndex], force);
	}
	
	private function makeMenuGroup(groupTitle:String, lables:Array<String>, headerWidth:Float, headerHeight:Float, buttonWidth:Float, buttonHeightMin:Float, buttonHeightMax:Float, buttonSpacing:Int, xButtonPadding:Int, xHeaderPadding, yPadding:Int):Void
	{
		var extraHeaderYPadding:Float = 0;
		if (_buttons.length > 0) extraHeaderYPadding = _buttons[_buttons.length - 1].y + _buttons[_buttons.length - 1].height;
		
		var header:Header = new Header(groupTitle, headerWidth, headerHeight, 60);
		header.x = xHeaderPadding;
		header.y = yPadding + extraHeaderYPadding;
		_container.add(header);
		
		var indexGroup:Array<Int> = [];
		
		for (i in 0...lables.length)
		{
			var b:ToggleButton;
			b = new ToggleButton(lables[i], buttonWidth, Math.round(FlxMath.lerp(buttonHeightMin, buttonHeightMax, i / lables.length)), 50);
			b.x = (b.width + buttonSpacing) * i + xButtonPadding;
			b.y = header.y + headerHeight + yPadding + (buttonHeightMax - b.height);
			_container.add(b);
			
			_buttons.push(b);
			
			indexGroup.push(_buttons.length - 1);
		}
		
		_buttonIndexGroups.push(indexGroup);
	}
	
	private function makeKeyboardGroup(num:Int):Void
	{
		var extraHeaderYPadding:Float = 0;
		if (_buttons.length > 0) extraHeaderYPadding = _buttons[_buttons.length - 1].y + _buttons[_buttons.length - 1].height;
		
		var header:Header = new Header("Keyboard layout " + (num + 1), 500, 90, 60);
		header.x = 120;
		header.y = 30 + extraHeaderYPadding;
		_container.add(header);
		
		var lables:Array<String> = ["Move Up", "Move Down", "Move Left", "Move Right", "Shoot", "Dash", "Item"];
		
		for (i in 0...lables.length)
		{
			var b:ToggleButton = new ToggleButton(lables[i], 330, 90, 50);
			b.x = 250;
			b.y = header.y + header.height + 120 * i + 30;
			_container.add(b);
			
			var h:Header = new Header("", 330, 90, 50, "arial");
			h.x = 800;
			h.y = b.y;
			b.data = h;
			_container.add(h);
			
			_buttons.push(b);
			_keyboardButtonHeaders.push(h);
			
			_buttonIndexGroups.push([_buttons.length - 1]);
		}
	}
	
	private function showKeys():Void
	{
		var values:Array<Int> =
		[
			InputManager.keyboard1.moveUp, 
			InputManager.keyboard1.moveDown, 
			InputManager.keyboard1.moveLeft, 
			InputManager.keyboard1.moveRight, 
			InputManager.keyboard1.shoot, 
			InputManager.keyboard1.dash, 
			InputManager.keyboard1.item, 
			InputManager.keyboard2.moveUp, 
			InputManager.keyboard2.moveDown, 
			InputManager.keyboard2.moveLeft, 
			InputManager.keyboard2.moveRight, 
			InputManager.keyboard2.shoot, 
			InputManager.keyboard2.dash, 
			InputManager.keyboard2.item
		];
		
		for (i in 0..._keyboardButtonHeaders.length)
		{
			_keyboardButtonHeaders[i].changeText(InputManager.keycodeToString(values[i]));
		}
	}
	
}