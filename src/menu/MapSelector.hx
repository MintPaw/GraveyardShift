package menu;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.loaders.TexturePackerData;

/**
 * ...
 * @author MintPaw
 */
class MapSelector extends FlxSprite
{
	public function new() 
	{
		super();
		
		loadGraphic("img/menu/Map Previews/map1.png");
	}
	
	public function changeMap(frame:Int):Void
	{
		loadGraphic("img/menu/Map Previews/map" + Std.string(frame + 1) + ".png");
	}
	
}