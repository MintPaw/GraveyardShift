package menu;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author MintPaw
 */
class ImageToggleButton extends MenuItem
{
	private var button:FlxSprite;
	private var textField:FlxText;
	
	private var _outColour:Int = 0xFF151515;
	private var _selectedColour:Int = 0xFFCC0033;
	
	public var selected:Bool = false;
	
	public function new(text:String, w:Float, h:Float, fontSize:Int, imagePath:String) 
	{
		super();
		
		button = new FlxSprite(0, 0, imagePath);
		add(button);
		
		if (text == "") return;
		
		textField = new FlxText(0, 0, Math.round(w), text, fontSize);
		textField.alignment = "center";
		textField.color = 0xFFF3F3F3;
		textField.font = "dekar";
		textField.y = (button.height - textField.textField.textHeight) / 2;
		add(textField);
	}
	
	override public function up():Void 
	{
		super.up();
		
		selected = false;
		updateGraphic();
	}
	
	override public function over():Void 
	{
		super.over();
	}
	
	override public function down():Void 
	{
		super.down();
		
		selected = true;
		
		updateGraphic();
	}
	
	private function updateGraphic():Void
	{
		button.makeGraphic(Math.round(button.width), Math.round(button.height), selected ? _selectedColour : _outColour);
	}
	
	public function getText():String { return textField.text; }
	public function setText(s:String):Void { textField.text = s; }
	
}