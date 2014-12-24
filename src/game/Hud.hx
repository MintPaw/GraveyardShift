package game;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author MintPaw
 */
class Hud extends FlxSpriteGroup
{
	private var _powerupImages:Array<FlxSprite>;
	private var _texts:Array<FlxText> ;
	private var _bgs:Array<FlxSprite>;
	private var _players:Array<Player>;
	
	public function new(players:Array<Player>) 
	{
		super();
		
		_players = players;
		_powerupImages = [];
		_texts = [];
		
		var hudSpacing:Int = 95;
		for (i in 0..._players.length)
		{
			var bg:FlxSprite = new FlxSprite(0, 0, "img/gui/" + _players[i].modelNumber + "UI.png");
			bg.x = i * (bg.width + hudSpacing);
			add(bg);
			
			var powerup:FlxSprite = new FlxSprite();
			powerup.x = bg.x + 7;
			powerup.y = bg.y + 3;
			powerup.visible = false;
			add(powerup);
			
			_powerupImages.push(powerup);
			
			var text:FlxText = new FlxText(0, 0, bg.width, "TESTTEST", 22);
			text.alignment = "center";
			text.font = "impact";
			text.x = bg.x + bg.width - text.textField.textWidth - 50;
			text.y = 2;
			add(text);
			
			_texts.push(text);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		for (i in 0..._players.length)
		{
			if (_players[i].needToUpdatePowerup)
			{
				_players[i].needToUpdatePowerup = false;
				
				_powerupImages[i].visible = true;
				
				if (_players[i].storedPowerup == null)
				{
					_powerupImages[i].visible = false;
					return;
				}
				
				if (_players[i].storedPowerup.type == Powerup.SHIELD) _powerupImages[i].loadGraphic("img/gui/shieldIcon.png");
				if (_players[i].storedPowerup.type == Powerup.BURST) _powerupImages[i].loadGraphic("img/gui/burstIcon.png");
				if (_players[i].storedPowerup.type == Powerup.BEAST) _powerupImages[i].loadGraphic("img/gui/beastIcon.png");
				if (_players[i].storedPowerup.type == Powerup.FLARE) _powerupImages[i].loadGraphic("img/gui/flareIcon.png");
				if (_players[i].storedPowerup.type == Powerup.LOSE_ATTRACTION) _powerupImages[i].loadGraphic("img/gui/sightIcon.png");
				if (_players[i].storedPowerup.type == Powerup.FLASH) _powerupImages[i].loadGraphic("img/gui/flashIcon.png");
				if (_players[i].storedPowerup.type == Powerup.SPAWN) _powerupImages[i].loadGraphic("img/gui/increaseZombieIcon.png");
			}
			
			_texts[i].text = "";
			if (_players[i].currentWeapon == Player.BLASTER) _texts[i].text = "Blaster\n";
			if (_players[i].currentWeapon == Player.SMG) _texts[i].text = "SMG\n";
			if (_players[i].currentWeapon == Player.SHOTGUN) _texts[i].text += "Shotgun\n";
			if (_players[i].currentWeapon == Player.LASER) _texts[i].text += "Zapper\n";
			if (_players[i].currentWeapon == Player.STICKY) _texts[i].text += "Launcher\n";
			
			_texts[i].text += _players[i].ammo == -1 ? "Infinite" : "x" + Std.string(_players[i].ammo);
		}
	}
}