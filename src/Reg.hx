package ;
import flash.display.BitmapData;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.util.FlxSort;
import game.GameState;
import input.InputLayout;
import menu.MenuState;
import menu.substates.VersusSubState;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.text.TextField;

/**
 * ...
 * @author MintPaw
 */
class Reg
{
	public static inline var TILES_WIDE:Int = 32;
	
	public static var SMALL_ROCK_JUMBLE:Float = 10;
	public static var LARGE_ROCK_JUMBLE:Float = 10;
	public static var SMALL_TREE_JUMBLE:Float = 10;
	public static var LARGE_TREE_JUMBLE:Float = 10;
	
	public static var PLAYER_MOVEMENT_ACCELERATION:Float = 5000;
	public static var PLAYER_MAX_VELOCITY:Float = 200;
	
	public static var STICKY_TIMER:Int = 10;
	
	public static var ZOMBIE_GROUP_SPACING:Int = 200;
	public static var ZOMBIE_GROUP_SPAWN_RADIUS:Int = 250;
	public static var ZOMBIE_GROUP_WALL_SPACING:Int = 50;
	public static var ZOMBIE_ENTITY_SPACING:Int = 100;
	public static var ZOMBIE_WALL_SPACING:Int = 50;
	public static var ZOMBIE_INTER_GROUP_SPACING:Int = 40;
	public static var ZOMBIES_PER_GROUP_MIN:Int = 3;
	public static var ZOMBIES_PER_GROUP_MAX:Int = 5;
	
	public static var MIN_ZOMBIES:Array<Int> = [30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30];
	
	public static var players:Array<Int> = [];
	public static var levelNumber:Int;
	
	public static var aa:Bool = true;
	public static var brightness:Float = 50;
	public static var fullscreen:Bool = true;
	public static var isDemo:Bool = false;
	
	public static var menuGoingToVersus:Bool = false;
	public static var skipCountdown:Bool = false;
	
	public static var tileSpacing:Int = 2;
	public static var isSnowing:Bool = false;
	
	public static var debugBox:TextField;
	
	public static var random:FlxRandom = new FlxRandom();
	public static var homePressed:Bool = false;
	
	public function new() 
	{
		
	}
	
	static public function randMinMax(min:Float, max:Float):Float { return min + (Math.random() * ((max - min) + 1)); }
	
	static public function startGame(level:Int):Void
	{
		levelNumber = level;
		FlxG.switchState(new GameState());
	}
	
	static public function startMenu():Void
	{
		FlxG.switchState(new MenuState());
	}
	
	public static inline function byY(Order:Int, Obj1:FlxBasic, Obj2:FlxBasic):Int
	{
		return byValues(Order, cast(Obj1, FlxObject).y + cast(Obj1, FlxSprite).origin.y, cast(Obj2, FlxObject).y + cast(Obj2, FlxSprite).origin.y);
	}
	
	/**
	 * You can use this function as a backend to write a custom sorting function (see byY() for an example).
	 */
	public static inline function byValues(Order:Int, Value1:Float, Value2:Float):Int
	{
		var result:Int = 0;
		
		if (Value1 < Value2)
		{
			result = Order;
		}
		else if (Value1 > Value2)
		{
			result = -Order;
		}
		
		return result;
	}
	
}