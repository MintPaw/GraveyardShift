package menu.substates;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;
import menu.Header;
import menu.MapSelector;
import menu.MenuItem;
import menu.SelectorRectangle;
import menu.ToggleButton;

/**
 * ...
 * @author MintPaw
 */
class VersusSubState extends MintSubState
{
	private var _buttons:Array<MenuItem>;
	private var _mapSelector:MapSelector;
	private var _selectorRect:SelectorRectangle;
	private var _selectedIndex:Int;
	private var _map:Int = 0;
	private var _frameCount:Int = 0;
	
	private var _mapNameHeader:Header;
	
	private var _mapNames:Array<String> = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"];
	
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
			Reg.menuGoingToVersus = false;
		}
		
		_buttons = [];
		
		_container.scrollFactor.set();
		
		var modeHeader:Header = new Header("Mode Select", 780, 82, 60);
		modeHeader.x = FlxG.width / 2 - modeHeader.width / 2;
		modeHeader.y = 50;
		_container.add(modeHeader);
		
		var modeLabels:Array<String> = ["Deathmatch", "Last Man Standing"];
		var buttonSpacing:Float = 30;
		for (i in 0...modeLabels.length)
		{
			var b:ToggleButton = new ToggleButton(modeLabels[i], 400, 90, 50);
			b.x = i * (b.width + buttonSpacing) + (FlxG.width - (b.width + buttonSpacing) * modeLabels.length) / 2 + 15;
			b.y = modeHeader.y + modeHeader.height + 10;
			_container.add(b);
			
			_buttons.push(b);
		}
		
		var ptwHeader:Header = new Header("Points To Win", 780, 82, 60);
		ptwHeader.x = FlxG.width / 2 - ptwHeader.width / 2;
		ptwHeader.y = _buttons[0].y + _buttons[0].height + 30;
		_container.add(ptwHeader);
		
		var pointsToWinLables:Array<String> = ["3", "5", "10", "25", "50"];
		var buttonSpacing:Float = 30;
		for (i in 0...pointsToWinLables.length)
		{
			var b:ToggleButton = new ToggleButton(pointsToWinLables[i], 180, 90, 50);
			b.x = i * (b.width + buttonSpacing) + (FlxG.width - (b.width + buttonSpacing) * pointsToWinLables.length) / 2;
			b.y = ptwHeader.y + ptwHeader.height + 10;
			_container.add(b);
			
			_buttons.push(b);
		}
		
		_mapNameHeader = new Header("Map Select", 753, 74, 60);
		_mapNameHeader.y = _buttons[_buttons.length - 1].y + _buttons[_buttons.length - 1].height + 30;
		_mapNameHeader.x = FlxG.width / 2 - _mapNameHeader.width / 2;
		_container.add(_mapNameHeader);
		
		_mapSelector = new MapSelector();
		_mapSelector.x = FlxG.width / 2 - _mapSelector.width / 2;
		_mapSelector.y = _mapNameHeader.y + _mapNameHeader.height;
		_container.add(_mapSelector);
		
		buttonSpacing = 20;
		for (i in 0...20)
		{
			var b:ToggleButton = new ToggleButton("", 45, 45, 50);
			b.x = i * (b.width + buttonSpacing) + (FlxG.width - (b.width + buttonSpacing) * 20) / 2;
			b.y = _mapSelector.y + _mapSelector.height + 20;
			_container.add(b);
			
			_buttons.push(b);
		}
		
		_selectorRect = new SelectorRectangle();
		_container.add(_selectorRect);
		
		selectIndex(0, true);
		
		var buttonsToAlpha:Array<Int> = [1, 2];
		for (i in 14..._buttons.length) buttonsToAlpha.push(i);
		if (Reg.isDemo) for (i in 0...buttonsToAlpha.length) _buttons[buttonsToAlpha[i]].alpha = .5;
		
		makePrompt(1);
	}
	
	private function selectIndex(index:Int, force:Bool = false):Void
	{
		_selectedIndex = index;
		
		_selectorRect.gotoItem(_buttons[_selectedIndex], force);
	}
	
	override private function updateInput():Void 
	{
		super.updateInput();
		_frameCount++;
		
		if (_selectedIndex >= 8)
		{
			_mapSelector.changeMap(_selectedIndex - 7 - 1);
			_mapNameHeader.changeText(_mapNames[_selectedIndex - 7 - 1]);
		}
		if (_selectedIndex == 7 && _frameCount % 4 == 0)
		{
			_mapNameHeader.changeText("???");
			_mapSelector.changeMap(Reg.random.int(0, 19));
		}
		
		var needToFinish:Bool = false;
		
		var canLeftFrom:Array<Int> = [1, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27];
		var canRightFrom:Array<Int> = [0, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];
		
		if (goLeft && canLeftFrom.indexOf(_selectedIndex) >= 0) selectIndex(_selectedIndex - 1);
		if (goRight && canRightFrom.indexOf(_selectedIndex) >= 0) selectIndex(_selectedIndex + 1);
		
		if (goConfirm)
		{
			if (_buttons[_selectedIndex].alpha == .5) return;
			
			if (_selectedIndex >= 0 && _selectedIndex <= 1)
			{
				_buttons[0].up(); _buttons[1].up();
				_buttons[_selectedIndex].down();
				
				if (_buttons[0].state == "down") GameRules.gameType = GameRules.SLAYER;
				if (_buttons[1].state == "down") GameRules.gameType = GameRules.SURVIVAL;
				
				changePointValues();
				
				selectIndex(2);
			} else if (_selectedIndex >= 2 && _selectedIndex <= 6) {
				_buttons[2].up(); _buttons[3].up(); _buttons[4].up(); _buttons[5].up(); _buttons[6].up();
				_buttons[_selectedIndex].down();
				selectIndex(8);
			} else {
				_buttons[_selectedIndex].down();
				needToFinish = true;
			}
		}
		
		if (needToFinish)
		{
			for (i in 2...6) if (_buttons[i].state == "down") GameRules.pointsToWin = Std.parseInt(cast(_buttons[i], ToggleButton).getText());
			for (i in 7..._buttons.length - 1) if (_buttons[i].state == "down") _map = _selectedIndex - 7 - 1;
			if (_buttons[7].state == "down") _map = Reg.random.int(0, 18);
			
			Reg.startGame(_map);
		}
		
		if (goBack)
		{
			if (_selectedIndex >= 0 && _selectedIndex <= 1)
			{
				close();
			} else if (_selectedIndex >= 2 && _selectedIndex <= 6) {
				selectIndex(0);
			} else if (_selectedIndex > 6) selectIndex(3);
		}
		
		if (goY) openSubState(new RulesSubState());
	}
	
	private function changePointValues():Void
	{
		if (GameRules.gameType == GameRules.SLAYER || GameRules.gameType == GameRules.SURVIVAL)
		{
			cast(_buttons[2], ToggleButton).setText("3");
			cast(_buttons[3], ToggleButton).setText("5");
			cast(_buttons[4], ToggleButton).setText("10");
			cast(_buttons[5], ToggleButton).setText("25");
			cast(_buttons[6], ToggleButton).setText("50");
		} else {
			cast(_buttons[2], ToggleButton).setText("300");
			cast(_buttons[3], ToggleButton).setText("500");
			cast(_buttons[4], ToggleButton).setText("1000");
			cast(_buttons[5], ToggleButton).setText("2500");
			cast(_buttons[6], ToggleButton).setText("5000");
		}
	}
	
}