package ;
import game.Player;

/**
 * ...
 * @author MintPaw
 */
class Stats
{
	public static var playerKills:Int = 0;
	public static var zombieKills:Int = 0;
	public static var roundsPlayed:Int = 0;
	public static var bulletsShot:Int = 0;
	public static var deathsToZombies:Int = 0;
	
	public static var killsWithBlaster:Int = 0;
	public static var killsWithSMG:Int = 0;
	public static var killsWithShotgun:Int = 0;
	public static var killsWithLaser:Int = 0;
	public static var killsWithSticky:Int = 0;
	
	public static var dashes:Int = 0;
	public static var powerupsUsed:Int = 0;
	
	public function new() 
	{
		
	}
	
	public static function getKill(w:String):Void
	{
		if (w == Player.BLASTER) killsWithBlaster++;
		if (w == Player.SMG) killsWithSMG++;
		if (w == Player.SHOTGUN) killsWithShotgun++;
		if (w == Player.LASER) killsWithLaser++;
		if (w == Player.STICKY) killsWithSticky++;
	}
	
}