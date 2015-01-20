package ;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import motion.Actuate;
import openfl.Assets;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

/**
 * ...
 * @author MintPaw
 */
class Sm
{
	public static var MAIN:String = "sound/0.ogg";
	public static var FORREST:String = "sound/1.ogg";
	public static var SCIFI:String = "sound/2.ogg";
	
	public static var BLASTER:String = "sound/effects/1-blaster.ogg";
	public static var SMG:String = "sound/effects/2-smg.ogg";
	public static var SHOTGUN:String = "sound/effects/3-shotgun.ogg";
	public static var LAUNCHER:String = "sound/effects/4-launcher shoot.ogg";
	public static var ZAPPER:String = "sound/effects/5-zapper.ogg";
	public static var SHIELD_DOWN:String = "sound/effects/7-shield down.ogg";
	public static var FLASH_BANG:String = "sound/effects/8-flash bang.ogg";
	public static var ACTIVATE_HALO:String = "sound/effects/9-activate halo.ogg";
	public static var RESSURRECT:String = "sound/effects/9-ressurrect.ogg";
	public static var BEAST:String = "sound/effects/10-beast reage.ogg";
	public static var SPAWN_ZOMBIES:String = "sound/effects/11-spawn zombies.ogg";
	public static var FLARE:String = "sound/effects/12-flare.ogg";
	public static var INVIS:String = "sound/effects/13-invis.ogg";
	public static var POWERUP_PICKUP:String = "sound/effects/14-powerup pickup.ogg";
	public static var AMMO_PICKUP:String = "sound/effects/15-ammo pickup.ogg";
	public static var ZOMBIE_ATTACK:String = "sound/effects/17-zombie ttack.ogg";
	public static var ZOMBIE_HIT:String = "sound/effects/18-zombie hit.ogg";
	public static var PLAYER_HIT_FEMALE:String = "sound/effects/19-player hit female.ogg";
	public static var PLAYER_HIT_MALE:String = "sound/effects/19-player hit man.ogg";
	public static var WOOD_CRATE_HIT:String = "sound/effects/21-woodcratehit.ogg";
	public static var WOOD_CRATE_DEAD:String = "sound/effects/22-woodcratedead.ogg";
	public static var METAL_CRATE_HIT:String = "sound/effects/23-metal crate hit.ogg";
	public static var WALL_HIT:String = "sound/effects/24-wall hit.ogg";
	public static var ROCK_HIT:String = "sound/effects/25-rock hit.ogg";
	public static var PAUSE:String = "sound/effects/28-pause.ogg";
	public static var MENU_BACK:String = "sound/effects/33-menu back.ogg";
	public static var MENU_CLICK:String = "sound/effects/34-menu click.ogg";
	public static var SELECTION_MOVE:String = "sound/effects/35-selection move.ogg";
	
	private static var _songChannel:SoundChannel;
	private static var _effectChannel:SoundChannel;
	
	public function new()
	{
		
	}
	
	public static function playSong(n:String, force:Bool = false):Void
	{
		if (!force && _songChannel != null)
		{
			Actuate.transform(_songChannel, 2).sound(0).onComplete(playSong, [n, true]);
			return;
		}
		
		_songChannel = Assets.getSound(n).play(0, 99999);
		var t:SoundTransform = new SoundTransform(0, 0);
		_songChannel.soundTransform = t;
		Actuate.transform(_songChannel, 2).sound(1);
	}
	
	public static function playEffect(n:String):Void
	{
		_effectChannel = Assets.getSound(n).play();
	}
	
}