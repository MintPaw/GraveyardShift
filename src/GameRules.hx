package;
import game.Player;
import game.Powerup;

/**
 * ...
 * @author MintPaw
 */
class GameRules
{
	public static var zombieSpeed:Int;
	public static var zombieDamage:Int;
	public static var zombieHealth:Int;
	public static var zombieChaseRadius:Int;
	public static var playerSpeed:Int;
	public static var dashRecovery:Int;
	public static var startingWeapon:Int;
	public static var startingPowerup:Int;
	public static var weaponTypes:Array<Int>;
	public static var powerupTypes:Array<Int>;
	public static var dropChance:Int;
	
	public static inline var LOW:Int = 0;
	public static inline var MEDIUM:Int = 1;
	public static inline var HIGH:Int = 2;
	public static inline var INSANE:Int = 3;
	
	public static inline var VERSUS:Int = 0;
	public static inline var EXTERMINATION:Int = 1;
	
	public static inline var SLAYER:Int = 0;
	public static inline var SURVIVAL:Int = 1;
	public static inline var POINT:Int = 2;
	
	public static var gameMode:Int;
	public static var gameType:Int;
	
	public static var pointsToWin:Int = 10;
	
	private static var ZOMBIE_SPEEDS:Array<Int> = [10, 200, 300, 500];
	private static var ZOMBIE_DAMAGES:Array<Int> = [1, 15, 30, 51];
	private static var ZOMBIES_HEALTHS:Array<Int> = [25, 100, 300, 1000];
	private static var ZOMBIES_CHASE_RADIUS:Array<Int> = [200, 500, 1000, 2000];
	private static var PLAYER_SPEEDS:Array<Float> = [.5, 1, 2, 6];
	private static var DASH_RECOVER:Array<Float> = [5, 1, .5, .1];
	private static var DROP_CHANCES:Array<Float> = [20, 45, 80, 99];
	
	public function new() 
	{
		
	}
	
	public static function getZombieSpeed():Int { return ZOMBIE_SPEEDS[zombieSpeed]; }
	public static function getZombieDamage():Int { return ZOMBIE_DAMAGES[zombieDamage]; }
	public static function getZombieHealth():Int { return ZOMBIES_HEALTHS[zombieHealth]; }
	public static function getZombieChaseRadius():Int { return ZOMBIES_CHASE_RADIUS[zombieChaseRadius]; }
	public static function getPlayerSpeed():Float { return PLAYER_SPEEDS[playerSpeed]; }
	public static function getDashRecovery():Float { return DASH_RECOVER[dashRecovery]; }
	public static function getDropChance():Float { return DROP_CHANCES[dropChance]; }
	
	static public function setDefaults():Void
	{
		zombieSpeed = MEDIUM;
		zombieDamage = MEDIUM;
		zombieHealth = MEDIUM;
		zombieChaseRadius = MEDIUM;
		playerSpeed = MEDIUM;
		dashRecovery = MEDIUM;
		dropChance = MEDIUM;
		
		startingWeapon = Powerup.BLASTER;
		startingPowerup = -1;
		weaponTypes = [Powerup.SMG, Powerup.SHOTGUN, Powerup.LASER, Powerup.STICKY];
		powerupTypes = [Powerup.SHIELD, Powerup.BURST, Powerup.BEAST, Powerup.FLARE, Powerup.LOSE_ATTRACTION, Powerup.FLASH, Powerup.SPAWN];
	}
	
}