package menu;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author MintPaw
 */
class Header extends FlxSpriteGroup
{
	private var _graphicHeight:Float;
	private var textField:FlxText;
	
	public var graphic:FlxSprite;
	
	public function new(text:String, w:Float, h:Float, fontSize:Int, font:String = "dekar") 
	{
		super();
		
		graphic = new FlxSprite();
		graphic.makeGraphic(Math.round(w), Math.round(h), 0xFFFFFFFF);
		graphic.color = 0xFF353535;
		add(graphic);
		
		_graphicHeight = graphic.height;
		
		textField = new FlxText(0, 0, Math.round(w), text, fontSize);
		textField.alignment = "center";
		textField.color = 0xFFF3F3F3;
		textField.font = font;
		textField.y = (graphic.height - textField.textField.textHeight) / 2;
		add(textField);
	}
	
	public function changeText(text:String):Void { textField.text = text; }
	
	override private function get_height():Float 
	{
		return _graphicHeight;
	}
	
}