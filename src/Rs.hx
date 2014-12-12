package ;
import flixel.math.FlxRandom;
import flixel.tile.FlxTilemap;
import game.Level;
import openfl.Assets;

/**
 * ...
 * @author MintPaw
 */
class Rs
{
	
	public function new() 
	{
		
	}
	
	public static function getLevel(levelNum:Int):Level
	{
		var mapString:String = Assets.getText("map/" + levelNum + ".tmx");
		var map:Level = new Level();
		
		map.botString = mapString.split("<data encoding=\"csv\">\n")[1];
		map.botString = map.botString.split("\n</data>")[0];
		
		map.midString = mapString.split("<data encoding=\"csv\">\n")[2];
		map.midString = map.midString.split("\n</data>")[0];
		
		map.topString = mapString.split("<data encoding=\"csv\">\n")[3];
		map.topString = map.topString.split("\n</data>")[0];
		
		map.setup();
		
		shuffleTiles([6, 7, 8, 9, 10, 11], map.tilemap);
		shuffleTiles([20, 21, 22, 23, 24, 25], map.tilemap);
		shuffleTiles([51, 52, 53, 54, 55], map.tilemap);
		
		//Remove waters
		var waterIndexes:Array<Int> = [];
		for (i in 0...map.tilemap.totalTiles) if (map.tilemap.getTileByIndex(i) == 81) waterIndexes.push(i);
		for (i in 0...waterIndexes.length) map.tilemap.setTileByIndex(waterIndexes[i], 1, true);
		
		//DIRTY FIX sets all the tile number back 1
		for (i in 0...map.tilemap.totalTiles) map.tilemap.setTileByIndex(i, map.tilemap.getTileByIndex(i) - 1);
		
		return map;
	}
	
	private static function shuffleTiles(array:Array<Int>, tilemap:FlxTilemap):Void
	{
		for (i in 0...tilemap.totalTiles)
		{
			if (array.indexOf(tilemap.getTileByIndex(i)) >= 0) tilemap.setTileByIndex(i, Reg.random.getObject(array), true);
		}
	}
	
}