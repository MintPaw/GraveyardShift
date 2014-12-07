package game;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.loaders.CachedGraphics;
import flixel.util.loaders.TextureRegion;
import openfl.Assets;

/**
 * ...
 * @author MintPaw
 */
class Level
{
	public var tilemap:FlxTilemap;
	public var bulletTilemap:FlxTilemap;
	
	public var topString:String;
	public var midString:String;
	public var botString:String;
	
	public var smallTreeList:Array<FlxPoint> = [];
	public var largeTreeList:Array<FlxPoint> = [];
	public var smallRockList:Array<FlxPoint> = [];
	public var largeRockList:Array<FlxPoint> = [];
	public var woodenCrateList:Array<FlxPoint> = [];
	public var metalCrateList:Array<FlxPoint> = [];
	public var spawnPoints:Array<FlxPoint> = [];
	
	public var waterGroup:FlxGroup;
	public var sparkleGroup:FlxGroup;
	
	public var isSnow:Bool = false;
	
	private var _sparkleTimer:FlxTimer;
	private var _tiledefs:Array<Array<Int>>;
	
	public function new() 
	{
		
	}
	
	public function setup():Void
	{
		parseDefs();
		
		var cached:CachedGraphics = FlxG.bitmap.add("img/map/Tilemap.png");
		#if ouya
		cached = FlxG.bitmap.add("img/map/TilemapOuya.png");
		#end
		var startX:Int = Reg.tileSpacing;
		var startY:Int = Reg.tileSpacing;
		var tileWidth:Int = 60;
		var tileHeight:Int = 60;
		var spacingX:Int = Reg.tileSpacing;
		var spacingY:Int = Reg.tileSpacing;
		var width:Int = cached.bitmap.width - startX;
		var height:Int = cached.bitmap.height - startY;
		var textureRegion:TextureRegion = new TextureRegion(cached, startX, startY, tileWidth, tileHeight, spacingX, spacingY, width, height);
		
		tilemap = new FlxTilemap();
		tilemap.loadMap(midString, textureRegion, tileWidth, tileHeight);
		
		var highestTile:Int = 0;
		for (i in 0...tilemap.totalTiles)
		{
			if (tilemap.getTileByIndex(i) == 0) tilemap.setTileByIndex(i, 1, true);
			if (tilemap.getTileByIndex(i) == _tiledefs[3][0]) isSnow = true;
			highestTile = Math.round(Math.max(highestTile, tilemap.getTileByIndex(i)));
		}
		
		for (i in 0...highestTile) tilemap.setTileProperties(i, FlxObject.ANY);
		
		var walkingTiles:Array<Int> = [];
		for (i in 0..._tiledefs[1].length) walkingTiles.push(_tiledefs[1][i]);
		for (i in 0...walkingTiles.length) tilemap.setTileProperties(walkingTiles[i], FlxObject.NONE);
		
		parseWaters();
		parseEntities();
		parseBulletmap();
	}
	
	private function parseDefs():Void
	{
		_tiledefs = [];
		
		var defsString:String = Assets.getText("info/tiledefs.txt");
		var defArray:Array<String> = defsString.split("\n");
		
		var currentArrayString:Array<String>;
		for (i in 1...defArray.length)
		{
			_tiledefs[i - 1] = [];
			currentArrayString = defArray[i].split(",");
			for (j in 0...currentArrayString.length)
			{
				_tiledefs[i - 1].push(Std.parseInt(currentArrayString[j]));
			}
		}
	}
	
	private function parseWaters():Void
	{
		waterGroup = new FlxGroup();
		sparkleGroup = new FlxGroup();
		
		var tempTilemap:FlxTilemap = new FlxTilemap();
		
		tempTilemap.loadMap(botString, Assets.getBitmapData("img/map/Tilemap.png"), 60, 60);
		
		var waterPoints:Array<FlxPoint> = tempTilemap.getTileCoords(_tiledefs[0][0], false);
		
		if (waterPoints == null) return;
		
		for (i in 0...waterPoints.length)
		{
			var oneToThirty:Array<Int> = [];
			for (i in 0...30) oneToThirty.push(i);
			var thirtyToSixty:Array<Int> = [];
			for (i in 30...60) thirtyToSixty.push(i);
			
			var w:FlxSprite = new FlxSprite(waterPoints[i].x, waterPoints[i].y);
			w.loadGraphic(Assets.getBitmapData("img/map/Water.png"), true, 60, 60);
			w.animation.add("first", oneToThirty, 6);
			w.animation.add("second", thirtyToSixty, 6);
			w.animation.play(Math.random() > .5 ? "first" : "second");
			w.angle = Math.round(Math.random() * 3) * 90;
			w.scale.x = Math.random() > .5 ? -1 : 1;
			w.scale.y = Math.random() > .5 ? -1 : 1;
			w.scrollFactor.set();
			waterGroup.add(w);
		}
		
		_sparkleTimer = new FlxTimer();
		_sparkleTimer.start(.4, doSparkle, 0);
	}
	
	private function parseEntities():Void
	{
		var tempTilemap:FlxTilemap = new FlxTilemap();
		tempTilemap.loadMap(topString, Assets.getBitmapData("img/map/Tilemap.png"), 60, 60);
		
		largeRockList = tempTilemap.getTileCoords(_tiledefs[0][1]);
		smallRockList = tempTilemap.getTileCoords(_tiledefs[0][2]);
		largeTreeList = tempTilemap.getTileCoords(_tiledefs[0][3]);
		smallTreeList = tempTilemap.getTileCoords(_tiledefs[0][4]);
		woodenCrateList = tempTilemap.getTileCoords(_tiledefs[0][6]);
		metalCrateList = tempTilemap.getTileCoords(_tiledefs[0][7]);
		
		if (largeRockList == null) largeRockList = [];
		if (smallRockList == null) smallRockList = [];
		if (largeTreeList == null) largeTreeList = [];
		if (smallTreeList == null) smallTreeList = [];
		if (woodenCrateList == null) woodenCrateList = [];
		if (metalCrateList == null) metalCrateList = [];
		
		spawnPoints = tempTilemap.getTileCoords(_tiledefs[0][5]);
	}
	
	private function parseBulletmap():Void
	{
		var array:Array<Int> = [];
		for (i in 0...Math.round(1920 / 60)) for (j in 0...Math.round(1080 / 60)) array.push(0);
		
		var validTiles:Array<Int> = [];
		for (i in 0...199) validTiles.push(i);
		for (i in 0..._tiledefs[2].length) validTiles[_tiledefs[2][i]] = -1;
		validTiles[_tiledefs[0][0]] = -1;
		
		bulletTilemap = new FlxTilemap();
		bulletTilemap.widthInTiles = Math.round(1920 / 60);
		bulletTilemap.heightInTiles = Math.round(1080 / 60);
		bulletTilemap.loadMap(array, Assets.getBitmapData("img/map/Tilemap.png"), 60, 60);
		
		for (i in 0...tilemap.widthInTiles)
		{
			for (j in 0...tilemap.heightInTiles)
			{
				if (validTiles.indexOf(tilemap.getTile(i, j)) > 0) bulletTilemap.setTile(i, j, 49, true);
			}
		}
		
		bulletTilemap.visible = false;
	}
	
	private function doSparkle(timer:FlxTimer):Void
	{
		if (FlxG.state.subState != null) return;
		
		var sparkle:FlxSprite = new FlxSprite();
		
		while (true)
		{
			sparkle.setPosition(cast(waterGroup.getRandom(), FlxSprite).x + 110 + Math.random() * 60, cast(waterGroup.getRandom(), FlxSprite).y + Math.random() * 60);
			
			if (sparkle.overlaps(waterGroup)) break;
		}
		
		sparkle.loadGraphic(Assets.getBitmapData("img/map/Sparkle.png"), true, 4, 4);
		sparkle.animation.add("default", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 6, false);
		sparkle.animation.play("default");
		sparkle.scrollFactor.set();
		sparkleGroup.add(sparkle);
	}
	
	public function update():Void
	{
		for (i in 0...sparkleGroup.members.length)
		{
			if (cast(sparkleGroup.members[i], FlxSprite).animation.finished)
			{
				sparkleGroup.remove(cast(sparkleGroup.members[i], FlxSprite), true);
				return;
			}
		}
	}
	
}