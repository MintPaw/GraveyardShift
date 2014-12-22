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
	
	private static var _songChannel:SoundChannel;
	
	public function new() 
	{
		
	}
	
	public static function playSong(n:String):Void
	{
		_songChannel = Assets.getSound(n).play(0, 99999);
		var t:SoundTransform = new SoundTransform(0, 0);
		_songChannel.soundTransform = t;
		
		Actuate.transform(_songChannel, 10).sound(1, 0).delay(1);
	}
	
}