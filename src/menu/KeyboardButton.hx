package menu;

import flash.ui.Keyboard;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import input.InputManager;

/**
 * ...
 * @author MintPaw
 */
class KeyboardButton extends FlxSpriteGroup
{
	
	public function new(key:UInt) 
	{
		super();
		
		var backing:FlxSprite = new FlxSprite(0, 0, "img/menu/key.png");
		add(backing);
		
		if (key == Keyboard.LEFT || key == Keyboard.RIGHT || key == Keyboard.UP || key == Keyboard.DOWN)
		{
			var arrow:FlxSprite = new FlxSprite(0, 0, "img/menu/arrow.png");
			
			arrow.x = width / 2 - arrow.width / 2;
			arrow.y = height / 2 - arrow.height / 2;
			
			if (key == Keyboard.LEFT) arrow.angle = -90;
			if (key == Keyboard.RIGHT) arrow.angle = 90;
			if (key == Keyboard.UP) arrow.angle = 0;
			if (key == Keyboard.DOWN) arrow.angle = 180;
			
			add(arrow);
			
			return;
		}
		
		var text:FlxText = new FlxText(0, 0, width - 2, InputManager.keycodeToString(key), 18);
		text.alignment = "center";
		text.font = "impact";
		text.y = height / 2 - text.textField.textHeight / 2;
		add(text);
	}
	
}