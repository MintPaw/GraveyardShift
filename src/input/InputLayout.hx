package input;
import flash.ui.Keyboard;
import flixel.input.gamepad.FlxGamepad.FlxAxes;
import flixel.input.gamepad.FlxGamepad.FlxGamepadAnalogStick;
import flixel.input.gamepad.OUYAButtonID;
import flixel.input.gamepad.XboxButtonID;

/**
 * ...
 * @author MintPaw
 */
class InputLayout
{
	public static var KEYBOARD_DEFAULT_1:Array<Int> = [Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, Keyboard.DOWN, Keyboard.PERIOD, Keyboard.COMMA, Keyboard.M, 0];
	public static var KEYBOARD_DEFAULT_2:Array<Int> = [Keyboard.A, Keyboard.D, Keyboard.W, Keyboard.S, Keyboard.F, Keyboard.G, Keyboard.H, 0];
	
	public static var CONTROLLER:Array<Int> = [0, 0, 0, 0, 0, 0, 0, 1];
	
	#if pc
	public static var LEFT_ANALOGUE:FlxGamepadAnalogStick = XboxButtonID.LEFT_ANALOG_STICK;
	public static var RIGHT_ANALOGUE:FlxGamepadAnalogStick = XboxButtonID.RIGHT_ANALOG_STICK;
	
	public static inline var DPAD_LEFT:Int = XboxButtonID.DPAD_LEFT;
	public static inline var DPAD_RIGHT:Int = XboxButtonID.DPAD_RIGHT;
	public static inline var DPAD_UP:Int = XboxButtonID.DPAD_UP;
	public static inline var DPAD_DOWN:Int = XboxButtonID.DPAD_DOWN;
	
	public static inline var LEFT_TRIGGER:Int = XboxButtonID.LEFT_TRIGGER;
	public static inline var RIGHT_TRIGGER:Int = XboxButtonID.RIGHT_TRIGGER;
	public static inline var LEFT_BUMPER:Int = XboxButtonID.LB;
	public static inline var RIGHT_BUMPER:Int = XboxButtonID.RB;
	public static inline var CONFIRM:Int = XboxButtonID.A;
	public static inline var DENY:Int = XboxButtonID.B;
	public static inline var Y:Int = XboxButtonID.Y;
	public static inline var X:Int = XboxButtonID.X;
	
	public static inline var PAUSE:Int = XboxButtonID.START;
	#end
	
	#if ouya
	public static var LEFT_ANALOGUE:FlxGamepadAnalogStick = OUYAButtonID.LEFT_ANALOG_STICK;
	public static var RIGHT_ANALOGUE:FlxGamepadAnalogStick = OUYAButtonID.RIGHT_ANALOG_STICK;
	
	public static inline var LEFT_TRIGGER:Int = OUYAButtonID.LEFT_TRIGGER_ANALOG;
	public static inline var RIGHT_TRIGGER:Int = OUYAButtonID.RIGHT_TRIGGER_ANALOG;
	public static inline var LEFT_BUMPER:Int = OUYAButtonID.LB;
	public static inline var RIGHT_BUMPER:Int = OUYAButtonID.RB;
	
	public static inline var DPAD_LEFT:Int = -1;
	public static inline var DPAD_RIGHT:Int = -1;
	public static inline var DPAD_UP:Int = -1;
	public static inline var DPAD_DOWN:Int = -1;
	
	public static inline var CONFIRM:Int = OUYAButtonID.O;
	public static inline var DENY:Int = OUYAButtonID.A;
	public static inline var Y:Int = OUYAButtonID.Y;
	public static inline var X:Int = OUYAButtonID.U;
	
	public static inline var PAUSE:Int = OUYAButtonID.HOME;
	#end
	
	#if fire
	public static inline var LEFT_BUMPER:Int = 6;
	public static inline var RIGHT_BUMPER:Int = 7;
	
	public static inline var DPAD_LEFT:Int = -1;
	public static inline var DPAD_RIGHT:Int = -1;
	public static inline var DPAD_UP:Int = -1;
	public static inline var DPAD_DOWN:Int = -1;
	
	public static inline var CONFIRM:Int = 0;
	public static inline var DENY:Int = 1;
	public static inline var Y:Int = 4;
	public static inline var X:Int = 3;
	
	public static inline var PAUSE:Int = OUYAButtonID.HOME;
	#end
	
	public var isController:Bool;
	public var moveLeft:Int;
	public var moveRight:Int;
	public var moveUp:Int;
	public var moveDown:Int;
	public var shoot:Int;
	public var dash:Int;
	public var item:Int;
	
	public function new() 
	{
		
	}
	
	public function bindAll(binding:Array<Int>):Void
	{
		moveLeft = binding[0];
		moveRight = binding[1];
		moveUp = binding[2];
		moveDown = binding[3];
		shoot = binding[4];
		dash = binding[5];
		item = binding[6];
		isController = binding[7] == 1;
	}
	
}