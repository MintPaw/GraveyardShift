package menu;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author MintPaw
 */
class MapSelector extends FlxSprite
{
	public function new() 
	{
		super();
		
		loadGraphic("img/menu/Map Previews/map1.json");
	}
	
	public function changeMap(frame:Int):Void
	{
		loadGraphic("img/menu/Map Previews/map" + Std.string(frame + 1) + ".json");
	}
	
}