package menu.substates;
import flixel.FlxG;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import input.InputLayout;
import input.InputManager;
import menu.PlayerSelectSlot;

/**
 * ...
 * @author MintPaw
 */
class PlayerSelectSubState extends MintSubState
{
	private var _slots:Array<PlayerSelectSlot>;
	private var _layoutOn:Array<InputLayout>;
	
	private var _coloursAval:Array<Bool>;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		if (Reg.menuGoingToVersus) noAnimation = true;
		super.create();
		
		if (Reg.menuGoingToVersus)
		{
			noAnimation = false;
			openSubState(new VersusSubState());
		}
		
		_slots = [];
		_layoutOn = [];
		_coloursAval = [true, true, true, true, true];
		
		var slotSpacing:Float = 20;
		var bottomSpacing:Float = 170;
		
		for (i in 0...4)
		{
			var s:PlayerSelectSlot = new PlayerSelectSlot(i);
			s.x = (s.width + slotSpacing) * i + (FlxG.width - (s.width + slotSpacing) * 4) / 2;
			s.y = FlxG.height - s.height - bottomSpacing;
			_container.add(s);
			
			_slots.push(s);
		}
		
		var s:FlxText = new FlxText(0, 0, FlxG.width, "Player Select", 70);
		s.font = "zombie";
		s.y = 100;
		s.alignment = "center";
		s.color = Reg.isSnowing ? 0xFF000000 : 0xFFFFFFFF;
		_container.add(s);
		makePrompt(2);
	}
	
	override public function updateInput():Void 
	{
		for (i in 0...4)
		{
			var pad:FlxGamepad = FlxG.gamepads.getByID(i);
			if (pad == null) continue;
			
			if (pad.justPressed(InputLayout.CONFIRM))
			{
				join(i, -1);
				_controllerDelay = .1;
				return;
			}
		}
		
		if (FlxG.keys.checkStatus(InputManager.keyboard1.moveUp, FlxInputState.JUST_RELEASED)) join( -1, 0);
		if (FlxG.keys.checkStatus(InputManager.keyboard2.moveUp, FlxInputState.JUST_RELEASED)) join( -1, 1);
		
		var readyToGo:Bool = true;
		
		_coloursAval = [true, true, true, true, true];
		
		if (GameRules.gameMode == GameRules.VERSUS && _layoutOn.length < 2) readyToGo = false;
		if (GameRules.gameMode == GameRules.EXTERMINATION && _layoutOn.length < 1) readyToGo = false;
		for (i in 0..._slots.length)
		{
			if (_slots[i].joined && !_slots[i].ready) readyToGo = false;
			
			if (_slots[i].ready) _coloursAval[_slots[i].selectedColour] = false;
			
			_slots[i].avalColours = _coloursAval;
		}
		
		if (readyToGo)
		{
			for (i in 0..._slots.length)
			{
				if (_slots[i].joined) Reg.players[i] = _slots[i].selectedColour;
			}
			openSubState(GameRules.gameMode == GameRules.VERSUS ? new VersusSubState() : new ExterminateSubState());
		}
		
		if (goBack) close();
		
		super.updateInput();
	}
	
	private function join(padID:Int, keyboardID:Int):Void
	{
		if (_layoutOn.length >= 4) return;
		
		var currentLayout:InputLayout = new InputLayout();
		
		if (padID == 0) currentLayout = InputManager.controller1;
		if (padID == 1) currentLayout = InputManager.controller2;
		if (padID == 2) currentLayout = InputManager.controller3;
		if (padID == 3) currentLayout = InputManager.controller4;
		
		if (keyboardID == 0) currentLayout = InputManager.keyboard1;
		if (keyboardID == 1) currentLayout = InputManager.keyboard2;
		
		if (_layoutOn.indexOf(currentLayout) >= 0) return;
		
		_layoutOn.push(currentLayout);
		
		InputManager.currentDevicesIDs[_layoutOn.length - 1] = padID;
		InputManager.layouts[_layoutOn.length - 1] = currentLayout;
		_slots[_layoutOn.length - 1].join(currentLayout, padID);
	}
	
	public function resetSelf():Void
	{
		for (i in 0..._slots.length)
		{
			remove(_slots[i]);
		}
		
		noAnimation = true;
		kill();
		create();
		noAnimation = false;
	}
	
}