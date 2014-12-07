package menu.substates;
import flixel.FlxG;
import flixel.math.FlxMath;
import game.Player;
import game.Powerup;
import menu.Header;
import menu.MenuItem;
import menu.SelectorRectangle;
import menu.ToggleButton;

/**
 * ...
 * @author MintPaw
 */
class RulesSubState extends MintSubState
{
	private var _selectorRect:SelectorRectangle;
	private var _selectedIndex:Int;
	private var _selectedGroup:Int;
	
	private var _buttons:Array<MenuItem>;
	private var _buttonIndexGroups:Array<Array<Int>>;
	
	private var _sizeModifier:Float = .7;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		_buttons = [];
		_buttonIndexGroups = [];
		
		makeMenuGroup("Zombie Speed", ["snail", "classic", "flash", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Zombie Damage", ["wimp", "classic", "ouch", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Zombie Health", ["frail", "classic", "take a punch", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Zombie Awareness", ["blind", "classic", "focused", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Player Speed", ["snail", "classic", "flash", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Dash Recovery", ["who needs it", "classic", "agile", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Starting Weapon", ["blaster", "SMG", "shotgun", "zapper", "launcher"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Weapon Types", ["blaster", "SMG", "shotgun", "zapper", "launcher"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Starting powerups", ["none", "shield", "resurrect", "rage", "flare", "ghost", "flash", "spawn Z"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Powerup types", ["shield", "resurrect", "rage", "flare", "ghost", "flash", "spawn Z"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Powerup drop rate", ["low", "classic", "high", "insane"], 500, 90, 300, 90, 30, 100, 50, 30);
		makeMenuGroup("Reset to Defaults", ["Reset?"], 500, 90, 300, 90, 30, 100, 50, 30);
		
		_selectorRect = new SelectorRectangle();
		_container.add(_selectorRect);
		
		selectIndex(0, true);
		
		FlxG.camera.follow(_selectorRect);
		FlxG.camera.setScrollBounds(0, FlxG.width, 0, _buttons[_buttons.length - 1].y + _buttons[_buttons.length - 1].height + 50);
		
		setValues();
		makePrompt(0);
	}
	
	private function makeMenuGroup(groupTitle:String, lables:Array<String>, headerWidth:Float, headerHeight:Float, buttonWidth:Float, buttonHeight:Float, buttonSpacing:Int, xButtonPadding:Int, xHeaderPadding, yPadding:Int):Void
	{
		headerWidth *= _sizeModifier;
		headerHeight *= _sizeModifier;
		buttonWidth *= _sizeModifier;
		buttonHeight *= _sizeModifier;
		buttonSpacing =  Math.round(buttonSpacing * _sizeModifier);
		
		var extraHeaderYPadding:Float = 0;
		if (_buttons.length > 0) extraHeaderYPadding = _buttons[_buttons.length - 1].y + _buttons[_buttons.length - 1].height;
		
		var header:Header = new Header(groupTitle, headerWidth, headerHeight, Math.round(60 * _sizeModifier));
		header.x = xHeaderPadding;
		header.y = yPadding + extraHeaderYPadding;
		_container.add(header);
		
		var indexGroup:Array<Int> = [];
		
		for (i in 0...lables.length)
		{
			var b:ToggleButton;
			b = new ToggleButton(lables[i], buttonWidth, buttonHeight, Math.round(50 * _sizeModifier));
			b.x = (b.width + buttonSpacing) * i + xButtonPadding;
			b.y = header.y + headerHeight + yPadding;
			_container.add(b);
			
			_buttons.push(b);
			
			indexGroup.push(_buttons.length - 1);
		}
		
		_buttonIndexGroups.push(indexGroup);
	}
	
	override private function updateInput():Void 
	{
		if (goLeft) if (_buttonIndexGroups[_selectedGroup].indexOf(_selectedIndex) != 0) selectIndex(_selectedIndex - 1);
		if (goRight) if (_buttonIndexGroups[_selectedGroup].indexOf(_selectedIndex) != _buttonIndexGroups[_selectedGroup].length - 1) selectIndex(_selectedIndex + 1);
		if (goDown) if (_buttonIndexGroups[_selectedGroup + 1] != null) selectIndex(_buttonIndexGroups[_selectedGroup + 1][0]);
		if (goUp) if (_buttonIndexGroups[_selectedGroup - 1] != null) selectIndex(_buttonIndexGroups[_selectedGroup - 1][0]);
		if (goBack) close();
		
		if (goConfirm)
		{
			if (_selectedIndex == 0) GameRules.zombieSpeed = GameRules.LOW;
			if (_selectedIndex == 1) GameRules.zombieSpeed = GameRules.MEDIUM;
			if (_selectedIndex == 2) GameRules.zombieSpeed = GameRules.HIGH;
			if (_selectedIndex == 3) GameRules.zombieSpeed = GameRules.INSANE;
			if (_selectedIndex == 4) GameRules.zombieDamage = GameRules.LOW;
			if (_selectedIndex == 5) GameRules.zombieDamage = GameRules.MEDIUM;
			if (_selectedIndex == 6) GameRules.zombieDamage = GameRules.HIGH;
			if (_selectedIndex == 7) GameRules.zombieDamage = GameRules.INSANE;
			if (_selectedIndex == 8) GameRules.zombieHealth = GameRules.LOW;
			if (_selectedIndex == 9) GameRules.zombieHealth = GameRules.MEDIUM;
			if (_selectedIndex == 10) GameRules.zombieHealth = GameRules.HIGH;
			if (_selectedIndex == 11) GameRules.zombieHealth = GameRules.INSANE;
			if (_selectedIndex == 12) GameRules.zombieChaseRadius = GameRules.LOW;
			if (_selectedIndex == 13) GameRules.zombieChaseRadius = GameRules.MEDIUM;
			if (_selectedIndex == 14) GameRules.zombieChaseRadius = GameRules.HIGH;
			if (_selectedIndex == 15) GameRules.zombieChaseRadius = GameRules.INSANE;
			if (_selectedIndex == 16) GameRules.playerSpeed = GameRules.LOW;
			if (_selectedIndex == 17) GameRules.playerSpeed = GameRules.MEDIUM;
			if (_selectedIndex == 18) GameRules.playerSpeed = GameRules.HIGH;
			if (_selectedIndex == 19) GameRules.playerSpeed = GameRules.INSANE;
			if (_selectedIndex == 20) GameRules.dashRecovery = GameRules.LOW;
			if (_selectedIndex == 21) GameRules.dashRecovery = GameRules.MEDIUM;
			if (_selectedIndex == 22) GameRules.dashRecovery = GameRules.HIGH;
			if (_selectedIndex == 23) GameRules.dashRecovery = GameRules.INSANE;
			if (_selectedIndex == 24) GameRules.startingWeapon = Powerup.BLASTER;
			if (_selectedIndex == 25) GameRules.startingWeapon = Powerup.SMG;
			if (_selectedIndex == 26) GameRules.startingWeapon = Powerup.SHOTGUN;
			if (_selectedIndex == 27) GameRules.startingWeapon = Powerup.LASER;
			if (_selectedIndex == 28) GameRules.startingWeapon = Powerup.STICKY;
			
			if (_selectedIndex == 29 && _buttons[_selectedIndex].state == "up") GameRules.weaponTypes.push(Powerup.BLASTER);
			if (_selectedIndex == 30 && _buttons[_selectedIndex].state == "up") GameRules.weaponTypes.push(Powerup.SMG);
			if (_selectedIndex == 31 && _buttons[_selectedIndex].state == "up") GameRules.weaponTypes.push(Powerup.SHOTGUN);
			if (_selectedIndex == 32 && _buttons[_selectedIndex].state == "up") GameRules.weaponTypes.push(Powerup.LASER);
			if (_selectedIndex == 33 && _buttons[_selectedIndex].state == "up") GameRules.weaponTypes.push(Powerup.STICKY);
			
			if (_selectedIndex == 29 && _buttons[_selectedIndex].state == "down") GameRules.weaponTypes.splice(GameRules.weaponTypes.indexOf(Powerup.BLASTER), 1);
			if (_selectedIndex == 30 && _buttons[_selectedIndex].state == "down") GameRules.weaponTypes.splice(GameRules.weaponTypes.indexOf(Powerup.SMG), 1);
			if (_selectedIndex == 31 && _buttons[_selectedIndex].state == "down") GameRules.weaponTypes.splice(GameRules.weaponTypes.indexOf(Powerup.SHOTGUN), 1);
			if (_selectedIndex == 32 && _buttons[_selectedIndex].state == "down") GameRules.weaponTypes.splice(GameRules.weaponTypes.indexOf(Powerup.LASER), 1);
			if (_selectedIndex == 33 && _buttons[_selectedIndex].state == "down") GameRules.weaponTypes.splice(GameRules.weaponTypes.indexOf(Powerup.STICKY), 1);
			
			if (_selectedIndex == 34) GameRules.startingPowerup = -1;
			if (_selectedIndex == 35) GameRules.startingPowerup = Powerup.SHIELD;
			if (_selectedIndex == 36) GameRules.startingPowerup = Powerup.BURST;
			if (_selectedIndex == 37) GameRules.startingPowerup = Powerup.BEAST;
			if (_selectedIndex == 38) GameRules.startingPowerup = Powerup.FLARE;
			if (_selectedIndex == 39) GameRules.startingPowerup = Powerup.LOSE_ATTRACTION;
			if (_selectedIndex == 40) GameRules.startingPowerup = Powerup.FLASH;
			if (_selectedIndex == 41) GameRules.startingPowerup = Powerup.SPAWN;
			
			if (_selectedIndex == 42 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.SHIELD);
			if (_selectedIndex == 43 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.BURST);
			if (_selectedIndex == 44 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.BEAST);
			if (_selectedIndex == 45 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.FLARE);
			if (_selectedIndex == 46 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.LOSE_ATTRACTION);
			if (_selectedIndex == 47 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.FLASH);
			if (_selectedIndex == 48 && _buttons[_selectedIndex].state == "up") GameRules.powerupTypes.push(Powerup.SPAWN);
			
			if (_selectedIndex == 42 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.SHIELD), 1);
			if (_selectedIndex == 43 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.BURST), 1);
			if (_selectedIndex == 44 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.BEAST), 1);
			if (_selectedIndex == 45 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.FLARE), 1);
			if (_selectedIndex == 46 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.LOSE_ATTRACTION), 1);
			if (_selectedIndex == 47 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.FLASH), 1);
			if (_selectedIndex == 48 && _buttons[_selectedIndex].state == "down") GameRules.powerupTypes.splice(GameRules.powerupTypes.indexOf(Powerup.SPAWN), 1);
			
			if (_selectedIndex == 49) GameRules.dropChance = GameRules.LOW;
			if (_selectedIndex == 50) GameRules.dropChance = GameRules.MEDIUM;
			if (_selectedIndex == 51) GameRules.dropChance = GameRules.HIGH;
			if (_selectedIndex == 52) GameRules.dropChance = GameRules.INSANE;
			
			if (_selectedIndex == 53) GameRules.setDefaults();
			
			FlxG.log.clear();
			FlxG.log.add(GameRules.powerupTypes);
			FlxG.log.add(GameRules.weaponTypes);
			
			setValues();
		}
		
		super.updateInput();
	}
	
	private function setValues():Void
	{
		for (i in 0..._buttons.length) _buttons[i].up();
		
		if (GameRules.zombieSpeed == GameRules.LOW) _buttons[0].down();
		if (GameRules.zombieSpeed == GameRules.MEDIUM) _buttons[1].down();
		if (GameRules.zombieSpeed == GameRules.HIGH) _buttons[2].down();
		if (GameRules.zombieSpeed == GameRules.INSANE) _buttons[3].down();
		if (GameRules.zombieDamage == GameRules.LOW) _buttons[4].down();
		if (GameRules.zombieDamage == GameRules.MEDIUM) _buttons[5].down();
		if (GameRules.zombieDamage == GameRules.HIGH) _buttons[6].down();
		if (GameRules.zombieDamage == GameRules.INSANE) _buttons[7].down();
		if (GameRules.zombieHealth == GameRules.LOW) _buttons[8].down();
		if (GameRules.zombieHealth == GameRules.MEDIUM) _buttons[9].down();
		if (GameRules.zombieHealth == GameRules.HIGH) _buttons[10].down();
		if (GameRules.zombieHealth == GameRules.INSANE) _buttons[11].down();
		if (GameRules.zombieChaseRadius == GameRules.LOW) _buttons[12].down();
		if (GameRules.zombieChaseRadius == GameRules.MEDIUM) _buttons[13].down();
		if (GameRules.zombieChaseRadius == GameRules.HIGH) _buttons[14].down();
		if (GameRules.zombieChaseRadius == GameRules.INSANE) _buttons[15].down();
		if (GameRules.playerSpeed == GameRules.LOW) _buttons[16].down();
		if (GameRules.playerSpeed == GameRules.MEDIUM) _buttons[17].down();
		if (GameRules.playerSpeed == GameRules.HIGH) _buttons[18].down();
		if (GameRules.playerSpeed == GameRules.INSANE) _buttons[19].down();
		if (GameRules.dashRecovery == GameRules.LOW) _buttons[20].down();
		if (GameRules.dashRecovery == GameRules.MEDIUM) _buttons[21].down();
		if (GameRules.dashRecovery == GameRules.HIGH) _buttons[22].down();
		if (GameRules.dashRecovery == GameRules.INSANE) _buttons[23].down();
		if (GameRules.startingWeapon == Powerup.BLASTER) _buttons[24].down();
		if (GameRules.startingWeapon == Powerup.SMG) _buttons[25].down();
		if (GameRules.startingWeapon == Powerup.SHOTGUN) _buttons[26].down();
		if (GameRules.startingWeapon == Powerup.LASER) _buttons[27].down();
		if (GameRules.startingWeapon == Powerup.STICKY) _buttons[28].down();
		if (GameRules.weaponTypes.indexOf(Powerup.BLASTER) >= 0) _buttons[29].down();
		if (GameRules.weaponTypes.indexOf(Powerup.SMG) >= 0) _buttons[30].down();
		if (GameRules.weaponTypes.indexOf(Powerup.SHOTGUN) >= 0) _buttons[31].down();
		if (GameRules.weaponTypes.indexOf(Powerup.LASER) >= 0) _buttons[32].down();
		if (GameRules.weaponTypes.indexOf(Powerup.STICKY) >= 0) _buttons[33].down();
		
		if (GameRules.startingPowerup == -1) _buttons[34].down();
		if (GameRules.startingPowerup == Powerup.SHIELD) _buttons[35].down();
		if (GameRules.startingPowerup == Powerup.BURST) _buttons[36].down();
		if (GameRules.startingPowerup == Powerup.BEAST) _buttons[37].down();
		if (GameRules.startingPowerup == Powerup.FLARE) _buttons[38].down();
		if (GameRules.startingPowerup == Powerup.LOSE_ATTRACTION) _buttons[39].down();
		if (GameRules.startingPowerup == Powerup.FLASH) _buttons[40].down();
		if (GameRules.startingPowerup == Powerup.SPAWN) _buttons[41].down();
		if (GameRules.powerupTypes.indexOf(Powerup.SHIELD) >= 0) _buttons[42].down();
		if (GameRules.powerupTypes.indexOf(Powerup.BURST) >= 0) _buttons[43].down();
		if (GameRules.powerupTypes.indexOf(Powerup.BEAST) >= 0) _buttons[44].down();
		if (GameRules.powerupTypes.indexOf(Powerup.FLARE) >= 0) _buttons[45].down();
		if (GameRules.powerupTypes.indexOf(Powerup.LOSE_ATTRACTION) >= 0) _buttons[46].down();
		if (GameRules.powerupTypes.indexOf(Powerup.FLASH) >= 0) _buttons[47].down();
		if (GameRules.powerupTypes.indexOf(Powerup.SPAWN) >= 0) _buttons[48].down();
		
		if (GameRules.dropChance == GameRules.LOW) _buttons[49].down();
		if (GameRules.dropChance == GameRules.MEDIUM) _buttons[50].down();
		if (GameRules.dropChance == GameRules.HIGH) _buttons[51].down();
		if (GameRules.dropChance == GameRules.INSANE) _buttons[52].down();
	}
	
	private function selectIndex(index:Int, force:Bool = false):Void
	{
		_selectedIndex = index;
		
		for (i in 0..._buttonIndexGroups.length) if (_buttonIndexGroups[i].indexOf(_selectedIndex) >= 0) _selectedGroup = i;
		
		_selectorRect.gotoItem(_buttons[_selectedIndex], force);
	}
	
}