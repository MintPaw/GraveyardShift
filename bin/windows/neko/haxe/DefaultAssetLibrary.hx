package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/sounds/beep.ogg", __ASSET__assets_sounds_beep_ogg);
		type.set ("assets/sounds/beep.ogg", AssetType.SOUND);
		className.set ("assets/sounds/flixel.ogg", __ASSET__assets_sounds_flixel_ogg);
		type.set ("assets/sounds/flixel.ogg", AssetType.SOUND);
		path.set ("img/bullets/bulletBlue_end.png", "img/bullets/bulletBlue_end.png");
		type.set ("img/bullets/bulletBlue_end.png", AssetType.IMAGE);
		path.set ("img/bullets/bulletOrange.png", "img/bullets/bulletOrange.png");
		type.set ("img/bullets/bulletOrange.png", AssetType.IMAGE);
		path.set ("img/bullets/bulletRed.png", "img/bullets/bulletRed.png");
		type.set ("img/bullets/bulletRed.png", AssetType.IMAGE);
		path.set ("img/bullets/explosion.json", "img/bullets/explosion.json");
		type.set ("img/bullets/explosion.json", AssetType.TEXT);
		path.set ("img/bullets/explosion.png", "img/bullets/explosion.png");
		type.set ("img/bullets/explosion.png", AssetType.IMAGE);
		path.set ("img/bullets/Green Bullet.json", "img/bullets/Green Bullet.json");
		type.set ("img/bullets/Green Bullet.json", AssetType.TEXT);
		path.set ("img/bullets/Green Bullet.png", "img/bullets/Green Bullet.png");
		type.set ("img/bullets/Green Bullet.png", AssetType.IMAGE);
		path.set ("img/bullets/Yellow Bullet.json", "img/bullets/Yellow Bullet.json");
		type.set ("img/bullets/Yellow Bullet.json", AssetType.TEXT);
		path.set ("img/bullets/Yellow Bullet.png", "img/bullets/Yellow Bullet.png");
		type.set ("img/bullets/Yellow Bullet.png", AssetType.IMAGE);
		path.set ("img/Crate Break.json", "img/Crate Break.json");
		type.set ("img/Crate Break.json", AssetType.TEXT);
		path.set ("img/Crate Break.png", "img/Crate Break.png");
		type.set ("img/Crate Break.png", AssetType.IMAGE);
		path.set ("img/gui/0UI.png", "img/gui/0UI.png");
		type.set ("img/gui/0UI.png", AssetType.IMAGE);
		path.set ("img/gui/1UI.png", "img/gui/1UI.png");
		type.set ("img/gui/1UI.png", AssetType.IMAGE);
		path.set ("img/gui/2UI.png", "img/gui/2UI.png");
		type.set ("img/gui/2UI.png", AssetType.IMAGE);
		path.set ("img/gui/3UI.png", "img/gui/3UI.png");
		type.set ("img/gui/3UI.png", AssetType.IMAGE);
		path.set ("img/gui/4UI.png", "img/gui/4UI.png");
		type.set ("img/gui/4UI.png", AssetType.IMAGE);
		path.set ("img/gui/backgroundBoarder.png", "img/gui/backgroundBoarder.png");
		type.set ("img/gui/backgroundBoarder.png", AssetType.IMAGE);
		path.set ("img/gui/backgroundScore.png", "img/gui/backgroundScore.png");
		type.set ("img/gui/backgroundScore.png", AssetType.IMAGE);
		path.set ("img/gui/backgroundStatic1.png", "img/gui/backgroundStatic1.png");
		type.set ("img/gui/backgroundStatic1.png", AssetType.IMAGE);
		path.set ("img/gui/backgroundStatic2.png", "img/gui/backgroundStatic2.png");
		type.set ("img/gui/backgroundStatic2.png", AssetType.IMAGE);
		path.set ("img/gui/backgroundStatic3.png", "img/gui/backgroundStatic3.png");
		type.set ("img/gui/backgroundStatic3.png", AssetType.IMAGE);
		path.set ("img/gui/backgroundStatic4.png", "img/gui/backgroundStatic4.png");
		type.set ("img/gui/backgroundStatic4.png", AssetType.IMAGE);
		path.set ("img/gui/beastIcon.png", "img/gui/beastIcon.png");
		type.set ("img/gui/beastIcon.png", AssetType.IMAGE);
		path.set ("img/gui/burstIcon.png", "img/gui/burstIcon.png");
		type.set ("img/gui/burstIcon.png", AssetType.IMAGE);
		path.set ("img/gui/circleShadeChar.png", "img/gui/circleShadeChar.png");
		type.set ("img/gui/circleShadeChar.png", AssetType.IMAGE);
		path.set ("img/gui/controller_p1.png", "img/gui/controller_p1.png");
		type.set ("img/gui/controller_p1.png", AssetType.IMAGE);
		path.set ("img/gui/controller_p2.png", "img/gui/controller_p2.png");
		type.set ("img/gui/controller_p2.png", AssetType.IMAGE);
		path.set ("img/gui/controller_p3.png", "img/gui/controller_p3.png");
		type.set ("img/gui/controller_p3.png", AssetType.IMAGE);
		path.set ("img/gui/controller_p4.png", "img/gui/controller_p4.png");
		type.set ("img/gui/controller_p4.png", AssetType.IMAGE);
		path.set ("img/gui/flareIcon.png", "img/gui/flareIcon.png");
		type.set ("img/gui/flareIcon.png", AssetType.IMAGE);
		path.set ("img/gui/flashIcon.png", "img/gui/flashIcon.png");
		type.set ("img/gui/flashIcon.png", AssetType.IMAGE);
		path.set ("img/gui/Get Ready 1.json", "img/gui/Get Ready 1.json");
		type.set ("img/gui/Get Ready 1.json", AssetType.TEXT);
		path.set ("img/gui/Get Ready 1.png", "img/gui/Get Ready 1.png");
		type.set ("img/gui/Get Ready 1.png", AssetType.IMAGE);
		path.set ("img/gui/Get Ready 2.json", "img/gui/Get Ready 2.json");
		type.set ("img/gui/Get Ready 2.json", AssetType.TEXT);
		path.set ("img/gui/Get Ready 2.png", "img/gui/Get Ready 2.png");
		type.set ("img/gui/Get Ready 2.png", AssetType.IMAGE);
		path.set ("img/gui/Get Ready.json", "img/gui/Get Ready.json");
		type.set ("img/gui/Get Ready.json", AssetType.TEXT);
		path.set ("img/gui/Get Ready.png", "img/gui/Get Ready.png");
		type.set ("img/gui/Get Ready.png", AssetType.IMAGE);
		path.set ("img/gui/increaseZombieIcon.png", "img/gui/increaseZombieIcon.png");
		type.set ("img/gui/increaseZombieIcon.png", AssetType.IMAGE);
		path.set ("img/gui/keyboard_p1.png", "img/gui/keyboard_p1.png");
		type.set ("img/gui/keyboard_p1.png", AssetType.IMAGE);
		path.set ("img/gui/keyboard_p2.png", "img/gui/keyboard_p2.png");
		type.set ("img/gui/keyboard_p2.png", AssetType.IMAGE);
		path.set ("img/gui/p1Letters.png", "img/gui/p1Letters.png");
		type.set ("img/gui/p1Letters.png", AssetType.IMAGE);
		path.set ("img/gui/p2Letters.png", "img/gui/p2Letters.png");
		type.set ("img/gui/p2Letters.png", AssetType.IMAGE);
		path.set ("img/gui/p3Letters.png", "img/gui/p3Letters.png");
		type.set ("img/gui/p3Letters.png", AssetType.IMAGE);
		path.set ("img/gui/p4_Letters.png", "img/gui/p4_Letters.png");
		type.set ("img/gui/p4_Letters.png", AssetType.IMAGE);
		path.set ("img/gui/playerCircle0.png", "img/gui/playerCircle0.png");
		type.set ("img/gui/playerCircle0.png", AssetType.IMAGE);
		path.set ("img/gui/playerCircle1.png", "img/gui/playerCircle1.png");
		type.set ("img/gui/playerCircle1.png", AssetType.IMAGE);
		path.set ("img/gui/playerCircle2.png", "img/gui/playerCircle2.png");
		type.set ("img/gui/playerCircle2.png", AssetType.IMAGE);
		path.set ("img/gui/playerCircle3.png", "img/gui/playerCircle3.png");
		type.set ("img/gui/playerCircle3.png", AssetType.IMAGE);
		path.set ("img/gui/playerCircle4.png", "img/gui/playerCircle4.png");
		type.set ("img/gui/playerCircle4.png", AssetType.IMAGE);
		path.set ("img/gui/playerTriangle0.png", "img/gui/playerTriangle0.png");
		type.set ("img/gui/playerTriangle0.png", AssetType.IMAGE);
		path.set ("img/gui/playerTriangle1.png", "img/gui/playerTriangle1.png");
		type.set ("img/gui/playerTriangle1.png", AssetType.IMAGE);
		path.set ("img/gui/playerTriangle2.png", "img/gui/playerTriangle2.png");
		type.set ("img/gui/playerTriangle2.png", AssetType.IMAGE);
		path.set ("img/gui/playerTriangle3.png", "img/gui/playerTriangle3.png");
		type.set ("img/gui/playerTriangle3.png", AssetType.IMAGE);
		path.set ("img/gui/playerTriangle4.png", "img/gui/playerTriangle4.png");
		type.set ("img/gui/playerTriangle4.png", AssetType.IMAGE);
		path.set ("img/gui/shieldIcon.png", "img/gui/shieldIcon.png");
		type.set ("img/gui/shieldIcon.png", AssetType.IMAGE);
		path.set ("img/gui/sightIcon.png", "img/gui/sightIcon.png");
		type.set ("img/gui/sightIcon.png", AssetType.IMAGE);
		path.set ("img/gui/winningTextBox0.png", "img/gui/winningTextBox0.png");
		type.set ("img/gui/winningTextBox0.png", AssetType.IMAGE);
		path.set ("img/gui/winningTextBox1.png", "img/gui/winningTextBox1.png");
		type.set ("img/gui/winningTextBox1.png", AssetType.IMAGE);
		path.set ("img/gui/winningTextBox2.png", "img/gui/winningTextBox2.png");
		type.set ("img/gui/winningTextBox2.png", AssetType.IMAGE);
		path.set ("img/gui/winningTextBox3.png", "img/gui/winningTextBox3.png");
		type.set ("img/gui/winningTextBox3.png", AssetType.IMAGE);
		path.set ("img/gui/winningTextBox4.png", "img/gui/winningTextBox4.png");
		type.set ("img/gui/winningTextBox4.png", AssetType.IMAGE);
		path.set ("img/items.json", "img/items.json");
		type.set ("img/items.json", AssetType.TEXT);
		path.set ("img/items.png", "img/items.png");
		type.set ("img/items.png", AssetType.IMAGE);
		path.set ("img/map/Crate Break.json", "img/map/Crate Break.json");
		type.set ("img/map/Crate Break.json", AssetType.TEXT);
		path.set ("img/map/Crate Break.png", "img/map/Crate Break.png");
		type.set ("img/map/Crate Break.png", AssetType.IMAGE);
		path.set ("img/map/crate.png", "img/map/crate.png");
		type.set ("img/map/crate.png", AssetType.IMAGE);
		path.set ("img/map/crateShading.png", "img/map/crateShading.png");
		type.set ("img/map/crateShading.png", AssetType.IMAGE);
		path.set ("img/map/GameAssets.json", "img/map/GameAssets.json");
		type.set ("img/map/GameAssets.json", AssetType.TEXT);
		path.set ("img/map/GameAssets.png", "img/map/GameAssets.png");
		type.set ("img/map/GameAssets.png", AssetType.IMAGE);
		path.set ("img/map/metalShading.png", "img/map/metalShading.png");
		type.set ("img/map/metalShading.png", AssetType.IMAGE);
		path.set ("img/map/metal_crate.png", "img/map/metal_crate.png");
		type.set ("img/map/metal_crate.png", AssetType.IMAGE);
		path.set ("img/map/Sparkle.png", "img/map/Sparkle.png");
		type.set ("img/map/Sparkle.png", AssetType.IMAGE);
		path.set ("img/map/Tilemap.png", "img/map/Tilemap.png");
		type.set ("img/map/Tilemap.png", AssetType.IMAGE);
		path.set ("img/map/TilemapOuya.png", "img/map/TilemapOuya.png");
		type.set ("img/map/TilemapOuya.png", AssetType.IMAGE);
		path.set ("img/map/Water.png", "img/map/Water.png");
		type.set ("img/map/Water.png", AssetType.IMAGE);
		path.set ("img/menu/0_join.png", "img/menu/0_join.png");
		type.set ("img/menu/0_join.png", AssetType.IMAGE);
		path.set ("img/menu/1_join.png", "img/menu/1_join.png");
		type.set ("img/menu/1_join.png", AssetType.IMAGE);
		path.set ("img/menu/2_join.png", "img/menu/2_join.png");
		type.set ("img/menu/2_join.png", AssetType.IMAGE);
		path.set ("img/menu/3_join.png", "img/menu/3_join.png");
		type.set ("img/menu/3_join.png", AssetType.IMAGE);
		path.set ("img/menu/4_join.png", "img/menu/4_join.png");
		type.set ("img/menu/4_join.png", AssetType.IMAGE);
		path.set ("img/menu/arrow.png", "img/menu/arrow.png");
		type.set ("img/menu/arrow.png", AssetType.IMAGE);
		path.set ("img/menu/backMainMenu.png", "img/menu/backMainMenu.png");
		type.set ("img/menu/backMainMenu.png", AssetType.IMAGE);
		path.set ("img/menu/controller_p1.png", "img/menu/controller_p1.png");
		type.set ("img/menu/controller_p1.png", AssetType.IMAGE);
		path.set ("img/menu/controller_p2.png", "img/menu/controller_p2.png");
		type.set ("img/menu/controller_p2.png", AssetType.IMAGE);
		path.set ("img/menu/controller_p3.png", "img/menu/controller_p3.png");
		type.set ("img/menu/controller_p3.png", AssetType.IMAGE);
		path.set ("img/menu/controller_p4.png", "img/menu/controller_p4.png");
		type.set ("img/menu/controller_p4.png", AssetType.IMAGE);
		path.set ("img/menu/controls_keyboard.png", "img/menu/controls_keyboard.png");
		type.set ("img/menu/controls_keyboard.png", AssetType.IMAGE);
		path.set ("img/menu/controls_ouya.png", "img/menu/controls_ouya.png");
		type.set ("img/menu/controls_ouya.png", AssetType.IMAGE);
		path.set ("img/menu/controls_xbox.png", "img/menu/controls_xbox.png");
		type.set ("img/menu/controls_xbox.png", AssetType.IMAGE);
		path.set ("img/menu/gameTitle.png", "img/menu/gameTitle.png");
		type.set ("img/menu/gameTitle.png", AssetType.IMAGE);
		path.set ("img/menu/grey_join.png", "img/menu/grey_join.png");
		type.set ("img/menu/grey_join.png", AssetType.IMAGE);
		path.set ("img/menu/help.json", "img/menu/help.json");
		type.set ("img/menu/help.json", AssetType.TEXT);
		path.set ("img/menu/help.png", "img/menu/help.png");
		type.set ("img/menu/help.png", AssetType.IMAGE);
		path.set ("img/menu/key.png", "img/menu/key.png");
		type.set ("img/menu/key.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map1.png", "img/menu/Map Previews/map1.png");
		type.set ("img/menu/Map Previews/map1.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map10.png", "img/menu/Map Previews/map10.png");
		type.set ("img/menu/Map Previews/map10.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map11.png", "img/menu/Map Previews/map11.png");
		type.set ("img/menu/Map Previews/map11.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map12.png", "img/menu/Map Previews/map12.png");
		type.set ("img/menu/Map Previews/map12.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map13.png", "img/menu/Map Previews/map13.png");
		type.set ("img/menu/Map Previews/map13.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map14.png", "img/menu/Map Previews/map14.png");
		type.set ("img/menu/Map Previews/map14.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map15.png", "img/menu/Map Previews/map15.png");
		type.set ("img/menu/Map Previews/map15.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map16.png", "img/menu/Map Previews/map16.png");
		type.set ("img/menu/Map Previews/map16.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map17.png", "img/menu/Map Previews/map17.png");
		type.set ("img/menu/Map Previews/map17.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map18.png", "img/menu/Map Previews/map18.png");
		type.set ("img/menu/Map Previews/map18.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map19.png", "img/menu/Map Previews/map19.png");
		type.set ("img/menu/Map Previews/map19.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map2.png", "img/menu/Map Previews/map2.png");
		type.set ("img/menu/Map Previews/map2.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map20.png", "img/menu/Map Previews/map20.png");
		type.set ("img/menu/Map Previews/map20.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map3.png", "img/menu/Map Previews/map3.png");
		type.set ("img/menu/Map Previews/map3.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map4.png", "img/menu/Map Previews/map4.png");
		type.set ("img/menu/Map Previews/map4.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map5.png", "img/menu/Map Previews/map5.png");
		type.set ("img/menu/Map Previews/map5.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map6.png", "img/menu/Map Previews/map6.png");
		type.set ("img/menu/Map Previews/map6.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map7.png", "img/menu/Map Previews/map7.png");
		type.set ("img/menu/Map Previews/map7.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map8.png", "img/menu/Map Previews/map8.png");
		type.set ("img/menu/Map Previews/map8.png", AssetType.IMAGE);
		path.set ("img/menu/Map Previews/map9.png", "img/menu/Map Previews/map9.png");
		type.set ("img/menu/Map Previews/map9.png", AssetType.IMAGE);
		path.set ("img/menu/Menu Button.json", "img/menu/Menu Button.json");
		type.set ("img/menu/Menu Button.json", AssetType.TEXT);
		path.set ("img/menu/Menu Button.png", "img/menu/Menu Button.png");
		type.set ("img/menu/Menu Button.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt1.png", "img/menu/ouyaPrompt1.png");
		type.set ("img/menu/ouyaPrompt1.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt1_black.png", "img/menu/ouyaPrompt1_black.png");
		type.set ("img/menu/ouyaPrompt1_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt2.png", "img/menu/ouyaPrompt2.png");
		type.set ("img/menu/ouyaPrompt2.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt2_black.png", "img/menu/ouyaPrompt2_black.png");
		type.set ("img/menu/ouyaPrompt2_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt3.png", "img/menu/ouyaPrompt3.png");
		type.set ("img/menu/ouyaPrompt3.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt3_black.png", "img/menu/ouyaPrompt3_black.png");
		type.set ("img/menu/ouyaPrompt3_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt4.png", "img/menu/ouyaPrompt4.png");
		type.set ("img/menu/ouyaPrompt4.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt4_black.png", "img/menu/ouyaPrompt4_black.png");
		type.set ("img/menu/ouyaPrompt4_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt5.png", "img/menu/ouyaPrompt5.png");
		type.set ("img/menu/ouyaPrompt5.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt5_black.png", "img/menu/ouyaPrompt5_black.png");
		type.set ("img/menu/ouyaPrompt5_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt6.png", "img/menu/ouyaPrompt6.png");
		type.set ("img/menu/ouyaPrompt6.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt6_black.png", "img/menu/ouyaPrompt6_black.png");
		type.set ("img/menu/ouyaPrompt6_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt7.png", "img/menu/ouyaPrompt7.png");
		type.set ("img/menu/ouyaPrompt7.png", AssetType.IMAGE);
		path.set ("img/menu/ouyaPrompt7_black.png", "img/menu/ouyaPrompt7_black.png");
		type.set ("img/menu/ouyaPrompt7_black.png", AssetType.IMAGE);
		path.set ("img/menu/ouya_toJoin.png", "img/menu/ouya_toJoin.png");
		type.set ("img/menu/ouya_toJoin.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt1.png", "img/menu/pcPrompt1.png");
		type.set ("img/menu/pcPrompt1.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt1_black.png", "img/menu/pcPrompt1_black.png");
		type.set ("img/menu/pcPrompt1_black.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt2.png", "img/menu/pcPrompt2.png");
		type.set ("img/menu/pcPrompt2.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt2_black.png", "img/menu/pcPrompt2_black.png");
		type.set ("img/menu/pcPrompt2_black.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt3.png", "img/menu/pcPrompt3.png");
		type.set ("img/menu/pcPrompt3.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt3_black.png", "img/menu/pcPrompt3_black.png");
		type.set ("img/menu/pcPrompt3_black.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt4.png", "img/menu/pcPrompt4.png");
		type.set ("img/menu/pcPrompt4.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt4_black.png", "img/menu/pcPrompt4_black.png");
		type.set ("img/menu/pcPrompt4_black.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt5.png", "img/menu/pcPrompt5.png");
		type.set ("img/menu/pcPrompt5.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt5_black.png", "img/menu/pcPrompt5_black.png");
		type.set ("img/menu/pcPrompt5_black.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt6.png", "img/menu/pcPrompt6.png");
		type.set ("img/menu/pcPrompt6.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt6_black.png", "img/menu/pcPrompt6_black.png");
		type.set ("img/menu/pcPrompt6_black.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt7.png", "img/menu/pcPrompt7.png");
		type.set ("img/menu/pcPrompt7.png", AssetType.IMAGE);
		path.set ("img/menu/pcPrompt7_black.png", "img/menu/pcPrompt7_black.png");
		type.set ("img/menu/pcPrompt7_black.png", AssetType.IMAGE);
		path.set ("img/menu/Player Menu.json", "img/menu/Player Menu.json");
		type.set ("img/menu/Player Menu.json", AssetType.TEXT);
		path.set ("img/menu/Player Menu.png", "img/menu/Player Menu.png");
		type.set ("img/menu/Player Menu.png", AssetType.IMAGE);
		path.set ("img/menu/ready_join.png", "img/menu/ready_join.png");
		type.set ("img/menu/ready_join.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt1.png", "img/menu/xboxPrompt1.png");
		type.set ("img/menu/xboxPrompt1.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt1_black.png", "img/menu/xboxPrompt1_black.png");
		type.set ("img/menu/xboxPrompt1_black.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt2.png", "img/menu/xboxPrompt2.png");
		type.set ("img/menu/xboxPrompt2.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt2_black.png", "img/menu/xboxPrompt2_black.png");
		type.set ("img/menu/xboxPrompt2_black.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt3.png", "img/menu/xboxPrompt3.png");
		type.set ("img/menu/xboxPrompt3.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt3_black.png", "img/menu/xboxPrompt3_black.png");
		type.set ("img/menu/xboxPrompt3_black.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt4.png", "img/menu/xboxPrompt4.png");
		type.set ("img/menu/xboxPrompt4.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt4_black.png", "img/menu/xboxPrompt4_black.png");
		type.set ("img/menu/xboxPrompt4_black.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt5.png", "img/menu/xboxPrompt5.png");
		type.set ("img/menu/xboxPrompt5.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt5_black.png", "img/menu/xboxPrompt5_black.png");
		type.set ("img/menu/xboxPrompt5_black.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt6.png", "img/menu/xboxPrompt6.png");
		type.set ("img/menu/xboxPrompt6.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt6_black.png", "img/menu/xboxPrompt6_black.png");
		type.set ("img/menu/xboxPrompt6_black.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt7.png", "img/menu/xboxPrompt7.png");
		type.set ("img/menu/xboxPrompt7.png", AssetType.IMAGE);
		path.set ("img/menu/xboxPrompt7_black.png", "img/menu/xboxPrompt7_black.png");
		type.set ("img/menu/xboxPrompt7_black.png", AssetType.IMAGE);
		path.set ("img/menu/xbox_a_button.png", "img/menu/xbox_a_button.png");
		type.set ("img/menu/xbox_a_button.png", AssetType.IMAGE);
		path.set ("img/players/Blue Player.json", "img/players/Blue Player.json");
		type.set ("img/players/Blue Player.json", AssetType.TEXT);
		path.set ("img/players/Blue Player.png", "img/players/Blue Player.png");
		type.set ("img/players/Blue Player.png", AssetType.IMAGE);
		path.set ("img/players/Green Player.json", "img/players/Green Player.json");
		type.set ("img/players/Green Player.json", AssetType.TEXT);
		path.set ("img/players/Green Player.png", "img/players/Green Player.png");
		type.set ("img/players/Green Player.png", AssetType.IMAGE);
		path.set ("img/players/halo.png", "img/players/halo.png");
		type.set ("img/players/halo.png", AssetType.IMAGE);
		path.set ("img/players/Muzzle Flashes.json", "img/players/Muzzle Flashes.json");
		type.set ("img/players/Muzzle Flashes.json", AssetType.TEXT);
		path.set ("img/players/Muzzle Flashes.png", "img/players/Muzzle Flashes.png");
		type.set ("img/players/Muzzle Flashes.png", AssetType.IMAGE);
		path.set ("img/players/Orange Player.json", "img/players/Orange Player.json");
		type.set ("img/players/Orange Player.json", AssetType.TEXT);
		path.set ("img/players/Orange Player.png", "img/players/Orange Player.png");
		type.set ("img/players/Orange Player.png", AssetType.IMAGE);
		path.set ("img/players/Powerup ring.json", "img/players/Powerup ring.json");
		type.set ("img/players/Powerup ring.json", AssetType.TEXT);
		path.set ("img/players/Powerup ring.png", "img/players/Powerup ring.png");
		type.set ("img/players/Powerup ring.png", AssetType.IMAGE);
		path.set ("img/players/Purple Player.json", "img/players/Purple Player.json");
		type.set ("img/players/Purple Player.json", AssetType.TEXT);
		path.set ("img/players/Purple Player.png", "img/players/Purple Player.png");
		type.set ("img/players/Purple Player.png", AssetType.IMAGE);
		path.set ("img/players/Red Player.json", "img/players/Red Player.json");
		type.set ("img/players/Red Player.json", AssetType.TEXT);
		path.set ("img/players/Red Player.png", "img/players/Red Player.png");
		type.set ("img/players/Red Player.png", AssetType.IMAGE);
		path.set ("img/powerups/flare.json", "img/powerups/flare.json");
		type.set ("img/powerups/flare.json", AssetType.TEXT);
		path.set ("img/powerups/flare.png", "img/powerups/flare.png");
		type.set ("img/powerups/flare.png", AssetType.IMAGE);
		path.set ("img/powerups/Shield.json", "img/powerups/Shield.json");
		type.set ("img/powerups/Shield.json", AssetType.TEXT);
		path.set ("img/powerups/Shield.png", "img/powerups/Shield.png");
		type.set ("img/powerups/Shield.png", AssetType.IMAGE);
		path.set ("img/skull.json", "img/skull.json");
		type.set ("img/skull.json", AssetType.TEXT);
		path.set ("img/skull.png", "img/skull.png");
		type.set ("img/skull.png", AssetType.IMAGE);
		path.set ("img/Tombstone.json", "img/Tombstone.json");
		type.set ("img/Tombstone.json", AssetType.TEXT);
		path.set ("img/Tombstone.png", "img/Tombstone.png");
		type.set ("img/Tombstone.png", AssetType.IMAGE);
		path.set ("img/Zombie.json", "img/Zombie.json");
		type.set ("img/Zombie.json", AssetType.TEXT);
		path.set ("img/Zombie.png", "img/Zombie.png");
		type.set ("img/Zombie.png", AssetType.IMAGE);
		path.set ("map/0.tmx", "map/0.tmx");
		type.set ("map/0.tmx", AssetType.TEXT);
		path.set ("map/1.tmx", "map/1.tmx");
		type.set ("map/1.tmx", AssetType.TEXT);
		path.set ("map/10.tmx", "map/10.tmx");
		type.set ("map/10.tmx", AssetType.TEXT);
		path.set ("map/11.tmx", "map/11.tmx");
		type.set ("map/11.tmx", AssetType.TEXT);
		path.set ("map/12.tmx", "map/12.tmx");
		type.set ("map/12.tmx", AssetType.TEXT);
		path.set ("map/2.tmx", "map/2.tmx");
		type.set ("map/2.tmx", AssetType.TEXT);
		path.set ("map/3.tmx", "map/3.tmx");
		type.set ("map/3.tmx", AssetType.TEXT);
		path.set ("map/4.tmx", "map/4.tmx");
		type.set ("map/4.tmx", AssetType.TEXT);
		path.set ("map/5.tmx", "map/5.tmx");
		type.set ("map/5.tmx", AssetType.TEXT);
		path.set ("map/6.tmx", "map/6.tmx");
		type.set ("map/6.tmx", AssetType.TEXT);
		path.set ("map/7.tmx", "map/7.tmx");
		type.set ("map/7.tmx", AssetType.TEXT);
		path.set ("map/8.tmx", "map/8.tmx");
		type.set ("map/8.tmx", AssetType.TEXT);
		path.set ("map/9.tmx", "map/9.tmx");
		type.set ("map/9.tmx", AssetType.TEXT);
		path.set ("info/tiledefs.txt", "info/tiledefs.txt");
		type.set ("info/tiledefs.txt", AssetType.TEXT);
		path.set ("sound/0.ogg", "sound/0.ogg");
		type.set ("sound/0.ogg", AssetType.MUSIC);
		path.set ("dekar", "assets/font/DEKAR.OTF");
		type.set ("dekar", AssetType.FONT);
		path.set ("arial", "assets/font/ARIAL.TTF");
		type.set ("arial", AssetType.FONT);
		path.set ("zombie", "assets/font/ZOMBIE.TTF");
		type.set ("zombie", AssetType.FONT);
		path.set ("impact", "assets/font/IMPACT.TTF");
		type.set ("impact", AssetType.FONT);
		
		
		#elseif html5
		
		var id;
		id = "assets/sounds/beep.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/flixel.ogg";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/sounds/beep.ogg", __ASSET__assets_sounds_beep_ogg);
		type.set ("assets/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/flixel.ogg", __ASSET__assets_sounds_flixel_ogg);
		type.set ("assets/sounds/flixel.ogg", AssetType.SOUND);
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_sounds_beep_ogg extends null { }
@:keep class __ASSET__assets_sounds_flixel_ogg extends null { }

















































































































































































































#elseif html5














































































































































































































@:keep class __ASSET__assets_font_dekar_otf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "dekar"; } #end }
@:keep class __ASSET__assets_font_arial_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "arial"; } #end }
@:keep class __ASSET__assets_font_zombie_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "zombie"; } #end }
@:keep class __ASSET__assets_font_impact_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "impact"; } #end }


#elseif (windows || mac || linux)


@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,5/assets/sounds/beep.ogg") class __ASSET__assets_sounds_beep_ogg extends flash.media.Sound {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,5/assets/sounds/flixel.ogg") class __ASSET__assets_sounds_flixel_ogg extends flash.media.Sound {}


#end
