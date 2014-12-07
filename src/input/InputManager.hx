package input;
import flash.display.Stage;
import flixel.FlxG;
import openfl.events.JoystickEvent;

/**
 * ...
 * @author MintPaw
 */
class InputManager
{
	public static var keyboard1:InputLayout = new InputLayout();
	public static var keyboard2:InputLayout = new InputLayout();
	
	public static var controller1:InputLayout = new InputLayout();
	public static var controller2:InputLayout = new InputLayout();
	public static var controller3:InputLayout = new InputLayout();
	public static var controller4:InputLayout = new InputLayout();
	
	public static var currentDevicesIDs:Array<Int> = [ -1, -1, -1, -1];
	public static var layouts:Array<InputLayout> = [];
	
	public static var deadZone = .5;
	public static var currentlyConnectedController:Int = 0;
	
	private static var _stageReference:Stage;
	
	public function new() 
	{
		
	}
	
	static public function init(stage:Stage):Void
	{
		_stageReference = stage;
	}
	
	static public function setToDefault():Void
	{
		keyboard1.bindAll(InputLayout.KEYBOARD_DEFAULT_1);
		keyboard2.bindAll(InputLayout.KEYBOARD_DEFAULT_2);
		
		controller1.bindAll(InputLayout.CONTROLLER);
		controller2.bindAll(InputLayout.CONTROLLER);
		controller3.bindAll(InputLayout.CONTROLLER);
		controller4.bindAll(InputLayout.CONTROLLER);
	}
	
	static public function keycodeToString(keycode:Int):String
	{
		var s:String = "[" + Std.string(keycode) + "]";
		
		if (keycode >= 33 && keycode <= 90) s = String.fromCharCode(keycode);
		
		if (keycode == 8) s = "backspace";
		if (keycode == 9) s = "tab";
		if (keycode == 13) s = "enter";
		if (keycode == 16) s = "shift";
		if (keycode == 17) s = "ctrl";
		if (keycode == 18) s = "alt";
		if (keycode == 20) s = "caps";
		if (keycode == 27) s = "escape";
		if (keycode == 32) s = "space";
		if (keycode == 37) s = "left";
		if (keycode == 38) s = "up";
		if (keycode == 39) s = "right";
		if (keycode == 40) s = "down";
		if (keycode == 144) s = "numlock";
		if (keycode == 145) s = "scrolllock";
		if (keycode == 188) s = ",";
		if (keycode == 190) s = ".";
		if (keycode == 219) s = "{";
		if (keycode == 191) s = "/";
		if (keycode == 221) s = "}";
		if (keycode == 222) s = "\"";
		if (keycode == 188) s = "<";
		if (keycode == 190) s = ">";
		if (keycode == 192) s = "`";
		if (keycode == 220) s = "|";
		if (keycode == 112) s = "F1";
		if (keycode == 113) s = "F2";
		if (keycode == 114) s = "F3";
		if (keycode == 115) s = "F4";
		if (keycode == 116) s = "F5";
		if (keycode == 117) s = "F6";
		if (keycode == 118) s = "F7";
		if (keycode == 119) s = "F8";
		if (keycode == 120) s = "F9";
		if (keycode == 121) s = "F10";
		if (keycode == 122) s = "F11";
		if (keycode == 123) s = "F12";
		if (keycode == 189) s = "-";
		if (keycode == 187) s = "+";
		if (keycode == 45) s = "insert";
		if (keycode == 46) s = "delete";
		if (keycode == 35) s = "home";
		if (keycode == 36) s = "end";
		if (keycode == 33) s = "page up";
		if (keycode == 34) s = "page down";
		if (keycode == 96) s = "n0";
		if (keycode == 97) s = "n1";
		if (keycode == 98) s = "n2";
		if (keycode == 99) s = "n3";
		if (keycode == 100) s = "n4";
		if (keycode == 101) s = "n5";
		if (keycode == 102) s = "n6";
		if (keycode == 103) s = "n7";
		if (keycode == 104) s = "n8";
		if (keycode == 105) s = "n9";
		if (keycode == 106) s = "n*";
		if (keycode == 107) s = "n+";
		if (keycode == 109) s = "n-";
		if (keycode == 110) s = "n.";
		if (keycode == 111) s = "n/";
		
		return s;
	}
	
}