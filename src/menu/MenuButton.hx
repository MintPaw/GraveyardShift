package menu;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author MintPaw
 */
class MenuButton extends MenuItem
{
	private var overButton:FlxSprite;
	private var textField:FlxText;
	
	public function new(text:String, fontSize:Int) 
	{
		super();
		
		overButton = new FlxSprite();
		overButton.loadGraphicFromTexture(new TexturePackerData("img/menu/Menu Button.json", "img/menu/Menu Button.png"));
		overButton.animation.addByPrefix("default", "selectionBar_PC");
		overButton.animation.play("default", true);
		overButton.visible = false;
		add(overButton);
		
		textField = new FlxText(20, 0, 600, text, fontSize);
		textField.color = 0xFFF3F3F3;
		textField.font = "dekar";
		textField.y = (overButton.height - textField.textField.textHeight) / 2;
		add(textField);
		
	}
	
	override public function up():Void 
	{
		super.up();
		
		overButton.visible = false;
	}
	
	override public function over():Void 
	{
		super.over();
		
		overButton.visible = true;
	}
	
	override public function down():Void 
	{
		super.down();
	}
	
}