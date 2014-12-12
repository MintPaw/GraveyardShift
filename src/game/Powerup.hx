package game;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;

/**
 * ...
 * @author MintPaw
 */
class Powerup extends FlxSprite
{
	public static inline var BLASTER:Int = 0;
	public static inline var SMG:Int = 1;
	public static inline var SHOTGUN:Int = 2;
	public static inline var LASER:Int = 3;
	public static inline var STICKY:Int = 4;
	
	public static inline var SHIELD:Int = 5;
	public static inline var BURST:Int = 6;
	public static inline var BEAST:Int = 7;
	public static inline var FLARE:Int = 8;
	public static inline var LOSE_ATTRACTION:Int = 9;
	public static inline var FLASH:Int = 10;
	public static inline var SPAWN:Int = 11;
	
	public var isWeapon:Bool;
	public var type:Int;
	
	private var _shineTimer:FlxTimer;
	
	public function new(forcePowerup:Bool = false) 
	{
		super();
		
		isWeapon = Reg.random.bool();
		
		if (forcePowerup) isWeapon = false;
		
		if (isWeapon)
		{
			type = Reg.random.getObject(GameRules.weaponTypes, 0, GameRules.weaponTypes.length - 1);
		} else {
			type = Reg.random.getObject(GameRules.powerupTypes, 0, GameRules.powerupTypes.length - 1);
		}
		
		frames = FlxAtlasFrames.fromTexturePackerJson("img/items.png", "img/items.json");
		animation.addByPrefix("blaster", "orangeAmmoBox_", 30, false);
		animation.addByPrefix("SMG", "GreenAmmoBox_", 30, false);
		animation.addByPrefix("shotgun", "redAmmoBox_", 30, false);
		animation.addByPrefix("laser", "blueAmmoBox_", 30, false);
		animation.addByPrefix("sticky", "yellowAmmoBox_", 30, false);
		animation.addByPrefix("shield", "shield_powerUp", 30, false);
		animation.addByPrefix("burst", "burst_powerUp", 30, false);
		animation.addByPrefix("beast", "beast_powerUp", 30, false);
		animation.addByPrefix("flare", "flare_powerUp", 30, false);
		animation.addByPrefix("attr", "invisible_powerUp", 30, false);
		animation.addByPrefix("flash", "flash_powerUp", 30, false);
		animation.addByPrefix("spawn", "zombie_powerUp", 30, false);
		
		if (type == BLASTER) animation.play("blaster");
		else if (type == SMG) animation.play("SMG")
		else if (type == SHOTGUN) animation.play("shotgun")
		else if (type == LASER) animation.play("laser")
		else if (type == STICKY) animation.play("sticky")
		else if (type == SHIELD) animation.play("shield")
		else if (type == BURST) animation.play("burst")
		else if (type == BEAST) animation.play("beast")
		else if (type == FLARE) animation.play("flare")
		else if (type == LOSE_ATTRACTION) animation.play("attr")
		else if (type == FLASH) animation.play("flash")
		else if (type == SPAWN) animation.play("spawn");
		
		_shineTimer = new FlxTimer();
		_shineTimer.start(3, shine, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (animation.finished) animation.pause();
	}
	
	private function shine(timer:FlxTimer):Void { animation.resume();  }
	
}