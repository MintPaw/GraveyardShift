package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("img/bullets/bulletBlue_end.png", "img/bullets/bulletBlue_end.png");
			type.set ("img/bullets/bulletBlue_end.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/bullets/bulletOrange.png", "img/bullets/bulletOrange.png");
			type.set ("img/bullets/bulletOrange.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/bullets/bulletRed.png", "img/bullets/bulletRed.png");
			type.set ("img/bullets/bulletRed.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/bullets/explosion.json", "img/bullets/explosion.json");
			type.set ("img/bullets/explosion.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/bullets/explosion.png", "img/bullets/explosion.png");
			type.set ("img/bullets/explosion.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/bullets/Green Bullet.json", "img/bullets/Green Bullet.json");
			type.set ("img/bullets/Green Bullet.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/bullets/Green Bullet.png", "img/bullets/Green Bullet.png");
			type.set ("img/bullets/Green Bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/bullets/Yellow Bullet.json", "img/bullets/Yellow Bullet.json");
			type.set ("img/bullets/Yellow Bullet.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/bullets/Yellow Bullet.png", "img/bullets/Yellow Bullet.png");
			type.set ("img/bullets/Yellow Bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/Crate Break.json", "img/Crate Break.json");
			type.set ("img/Crate Break.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/Crate Break.png", "img/Crate Break.png");
			type.set ("img/Crate Break.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/0UI.png", "img/gui/0UI.png");
			type.set ("img/gui/0UI.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/1UI.png", "img/gui/1UI.png");
			type.set ("img/gui/1UI.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/2UI.png", "img/gui/2UI.png");
			type.set ("img/gui/2UI.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/3UI.png", "img/gui/3UI.png");
			type.set ("img/gui/3UI.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/4UI.png", "img/gui/4UI.png");
			type.set ("img/gui/4UI.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/backgroundBoarder.png", "img/gui/backgroundBoarder.png");
			type.set ("img/gui/backgroundBoarder.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/backgroundScore.png", "img/gui/backgroundScore.png");
			type.set ("img/gui/backgroundScore.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/backgroundStatic1.png", "img/gui/backgroundStatic1.png");
			type.set ("img/gui/backgroundStatic1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/backgroundStatic2.png", "img/gui/backgroundStatic2.png");
			type.set ("img/gui/backgroundStatic2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/backgroundStatic3.png", "img/gui/backgroundStatic3.png");
			type.set ("img/gui/backgroundStatic3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/backgroundStatic4.png", "img/gui/backgroundStatic4.png");
			type.set ("img/gui/backgroundStatic4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/beastIcon.png", "img/gui/beastIcon.png");
			type.set ("img/gui/beastIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/burstIcon.png", "img/gui/burstIcon.png");
			type.set ("img/gui/burstIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/circleShadeChar.png", "img/gui/circleShadeChar.png");
			type.set ("img/gui/circleShadeChar.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/controller_p1.png", "img/gui/controller_p1.png");
			type.set ("img/gui/controller_p1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/controller_p2.png", "img/gui/controller_p2.png");
			type.set ("img/gui/controller_p2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/controller_p3.png", "img/gui/controller_p3.png");
			type.set ("img/gui/controller_p3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/controller_p4.png", "img/gui/controller_p4.png");
			type.set ("img/gui/controller_p4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/flareIcon.png", "img/gui/flareIcon.png");
			type.set ("img/gui/flareIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/flashIcon.png", "img/gui/flashIcon.png");
			type.set ("img/gui/flashIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/Get Ready 1.json", "img/gui/Get Ready 1.json");
			type.set ("img/gui/Get Ready 1.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/gui/Get Ready 1.png", "img/gui/Get Ready 1.png");
			type.set ("img/gui/Get Ready 1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/Get Ready 2.json", "img/gui/Get Ready 2.json");
			type.set ("img/gui/Get Ready 2.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/gui/Get Ready 2.png", "img/gui/Get Ready 2.png");
			type.set ("img/gui/Get Ready 2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/Get Ready.json", "img/gui/Get Ready.json");
			type.set ("img/gui/Get Ready.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/gui/Get Ready.png", "img/gui/Get Ready.png");
			type.set ("img/gui/Get Ready.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/increaseZombieIcon.png", "img/gui/increaseZombieIcon.png");
			type.set ("img/gui/increaseZombieIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/keyboard_p1.png", "img/gui/keyboard_p1.png");
			type.set ("img/gui/keyboard_p1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/keyboard_p2.png", "img/gui/keyboard_p2.png");
			type.set ("img/gui/keyboard_p2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/p1Letters.png", "img/gui/p1Letters.png");
			type.set ("img/gui/p1Letters.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/p2Letters.png", "img/gui/p2Letters.png");
			type.set ("img/gui/p2Letters.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/p3Letters.png", "img/gui/p3Letters.png");
			type.set ("img/gui/p3Letters.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/p4_Letters.png", "img/gui/p4_Letters.png");
			type.set ("img/gui/p4_Letters.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerCircle0.png", "img/gui/playerCircle0.png");
			type.set ("img/gui/playerCircle0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerCircle1.png", "img/gui/playerCircle1.png");
			type.set ("img/gui/playerCircle1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerCircle2.png", "img/gui/playerCircle2.png");
			type.set ("img/gui/playerCircle2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerCircle3.png", "img/gui/playerCircle3.png");
			type.set ("img/gui/playerCircle3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerCircle4.png", "img/gui/playerCircle4.png");
			type.set ("img/gui/playerCircle4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerTriangle0.png", "img/gui/playerTriangle0.png");
			type.set ("img/gui/playerTriangle0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerTriangle1.png", "img/gui/playerTriangle1.png");
			type.set ("img/gui/playerTriangle1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerTriangle2.png", "img/gui/playerTriangle2.png");
			type.set ("img/gui/playerTriangle2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerTriangle3.png", "img/gui/playerTriangle3.png");
			type.set ("img/gui/playerTriangle3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/playerTriangle4.png", "img/gui/playerTriangle4.png");
			type.set ("img/gui/playerTriangle4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/shieldIcon.png", "img/gui/shieldIcon.png");
			type.set ("img/gui/shieldIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/sightIcon.png", "img/gui/sightIcon.png");
			type.set ("img/gui/sightIcon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/winningTextBox0.png", "img/gui/winningTextBox0.png");
			type.set ("img/gui/winningTextBox0.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/winningTextBox1.png", "img/gui/winningTextBox1.png");
			type.set ("img/gui/winningTextBox1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/winningTextBox2.png", "img/gui/winningTextBox2.png");
			type.set ("img/gui/winningTextBox2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/winningTextBox3.png", "img/gui/winningTextBox3.png");
			type.set ("img/gui/winningTextBox3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/gui/winningTextBox4.png", "img/gui/winningTextBox4.png");
			type.set ("img/gui/winningTextBox4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/items.json", "img/items.json");
			type.set ("img/items.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/items.png", "img/items.png");
			type.set ("img/items.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/Crate Break.json", "img/map/Crate Break.json");
			type.set ("img/map/Crate Break.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/map/Crate Break.png", "img/map/Crate Break.png");
			type.set ("img/map/Crate Break.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/crate.png", "img/map/crate.png");
			type.set ("img/map/crate.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/crateShading.png", "img/map/crateShading.png");
			type.set ("img/map/crateShading.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/GameAssets.json", "img/map/GameAssets.json");
			type.set ("img/map/GameAssets.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/map/GameAssets.png", "img/map/GameAssets.png");
			type.set ("img/map/GameAssets.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/metalShading.png", "img/map/metalShading.png");
			type.set ("img/map/metalShading.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/metal_crate.png", "img/map/metal_crate.png");
			type.set ("img/map/metal_crate.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/Sparkle.png", "img/map/Sparkle.png");
			type.set ("img/map/Sparkle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/Tilemap.png", "img/map/Tilemap.png");
			type.set ("img/map/Tilemap.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/TilemapOuya.png", "img/map/TilemapOuya.png");
			type.set ("img/map/TilemapOuya.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/map/Water.png", "img/map/Water.png");
			type.set ("img/map/Water.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/0_join.png", "img/menu/0_join.png");
			type.set ("img/menu/0_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/1_join.png", "img/menu/1_join.png");
			type.set ("img/menu/1_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/2_join.png", "img/menu/2_join.png");
			type.set ("img/menu/2_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/3_join.png", "img/menu/3_join.png");
			type.set ("img/menu/3_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/4_join.png", "img/menu/4_join.png");
			type.set ("img/menu/4_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/arrow.png", "img/menu/arrow.png");
			type.set ("img/menu/arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/backMainMenu.png", "img/menu/backMainMenu.png");
			type.set ("img/menu/backMainMenu.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controller_p1.png", "img/menu/controller_p1.png");
			type.set ("img/menu/controller_p1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controller_p2.png", "img/menu/controller_p2.png");
			type.set ("img/menu/controller_p2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controller_p3.png", "img/menu/controller_p3.png");
			type.set ("img/menu/controller_p3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controller_p4.png", "img/menu/controller_p4.png");
			type.set ("img/menu/controller_p4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controls_keyboard.png", "img/menu/controls_keyboard.png");
			type.set ("img/menu/controls_keyboard.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controls_ouya.png", "img/menu/controls_ouya.png");
			type.set ("img/menu/controls_ouya.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/controls_xbox.png", "img/menu/controls_xbox.png");
			type.set ("img/menu/controls_xbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/gameTitle.png", "img/menu/gameTitle.png");
			type.set ("img/menu/gameTitle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/grey_join.png", "img/menu/grey_join.png");
			type.set ("img/menu/grey_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/help.json", "img/menu/help.json");
			type.set ("img/menu/help.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/menu/help.png", "img/menu/help.png");
			type.set ("img/menu/help.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/key.png", "img/menu/key.png");
			type.set ("img/menu/key.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map1.png", "img/menu/Map Previews/map1.png");
			type.set ("img/menu/Map Previews/map1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map10.png", "img/menu/Map Previews/map10.png");
			type.set ("img/menu/Map Previews/map10.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map11.png", "img/menu/Map Previews/map11.png");
			type.set ("img/menu/Map Previews/map11.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map12.png", "img/menu/Map Previews/map12.png");
			type.set ("img/menu/Map Previews/map12.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map13.png", "img/menu/Map Previews/map13.png");
			type.set ("img/menu/Map Previews/map13.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map14.png", "img/menu/Map Previews/map14.png");
			type.set ("img/menu/Map Previews/map14.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map15.png", "img/menu/Map Previews/map15.png");
			type.set ("img/menu/Map Previews/map15.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map16.png", "img/menu/Map Previews/map16.png");
			type.set ("img/menu/Map Previews/map16.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map17.png", "img/menu/Map Previews/map17.png");
			type.set ("img/menu/Map Previews/map17.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map18.png", "img/menu/Map Previews/map18.png");
			type.set ("img/menu/Map Previews/map18.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map19.png", "img/menu/Map Previews/map19.png");
			type.set ("img/menu/Map Previews/map19.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map2.png", "img/menu/Map Previews/map2.png");
			type.set ("img/menu/Map Previews/map2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map20.png", "img/menu/Map Previews/map20.png");
			type.set ("img/menu/Map Previews/map20.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map3.png", "img/menu/Map Previews/map3.png");
			type.set ("img/menu/Map Previews/map3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map4.png", "img/menu/Map Previews/map4.png");
			type.set ("img/menu/Map Previews/map4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map5.png", "img/menu/Map Previews/map5.png");
			type.set ("img/menu/Map Previews/map5.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map6.png", "img/menu/Map Previews/map6.png");
			type.set ("img/menu/Map Previews/map6.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map7.png", "img/menu/Map Previews/map7.png");
			type.set ("img/menu/Map Previews/map7.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map8.png", "img/menu/Map Previews/map8.png");
			type.set ("img/menu/Map Previews/map8.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Map Previews/map9.png", "img/menu/Map Previews/map9.png");
			type.set ("img/menu/Map Previews/map9.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Menu Button.json", "img/menu/Menu Button.json");
			type.set ("img/menu/Menu Button.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/menu/Menu Button.png", "img/menu/Menu Button.png");
			type.set ("img/menu/Menu Button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt1.png", "img/menu/ouyaPrompt1.png");
			type.set ("img/menu/ouyaPrompt1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt1_black.png", "img/menu/ouyaPrompt1_black.png");
			type.set ("img/menu/ouyaPrompt1_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt2.png", "img/menu/ouyaPrompt2.png");
			type.set ("img/menu/ouyaPrompt2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt2_black.png", "img/menu/ouyaPrompt2_black.png");
			type.set ("img/menu/ouyaPrompt2_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt3.png", "img/menu/ouyaPrompt3.png");
			type.set ("img/menu/ouyaPrompt3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt3_black.png", "img/menu/ouyaPrompt3_black.png");
			type.set ("img/menu/ouyaPrompt3_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt4.png", "img/menu/ouyaPrompt4.png");
			type.set ("img/menu/ouyaPrompt4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt4_black.png", "img/menu/ouyaPrompt4_black.png");
			type.set ("img/menu/ouyaPrompt4_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt5.png", "img/menu/ouyaPrompt5.png");
			type.set ("img/menu/ouyaPrompt5.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt5_black.png", "img/menu/ouyaPrompt5_black.png");
			type.set ("img/menu/ouyaPrompt5_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt6.png", "img/menu/ouyaPrompt6.png");
			type.set ("img/menu/ouyaPrompt6.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt6_black.png", "img/menu/ouyaPrompt6_black.png");
			type.set ("img/menu/ouyaPrompt6_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt7.png", "img/menu/ouyaPrompt7.png");
			type.set ("img/menu/ouyaPrompt7.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouyaPrompt7_black.png", "img/menu/ouyaPrompt7_black.png");
			type.set ("img/menu/ouyaPrompt7_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ouya_toJoin.png", "img/menu/ouya_toJoin.png");
			type.set ("img/menu/ouya_toJoin.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt1.png", "img/menu/pcPrompt1.png");
			type.set ("img/menu/pcPrompt1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt1_black.png", "img/menu/pcPrompt1_black.png");
			type.set ("img/menu/pcPrompt1_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt2.png", "img/menu/pcPrompt2.png");
			type.set ("img/menu/pcPrompt2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt2_black.png", "img/menu/pcPrompt2_black.png");
			type.set ("img/menu/pcPrompt2_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt3.png", "img/menu/pcPrompt3.png");
			type.set ("img/menu/pcPrompt3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt3_black.png", "img/menu/pcPrompt3_black.png");
			type.set ("img/menu/pcPrompt3_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt4.png", "img/menu/pcPrompt4.png");
			type.set ("img/menu/pcPrompt4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt4_black.png", "img/menu/pcPrompt4_black.png");
			type.set ("img/menu/pcPrompt4_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt5.png", "img/menu/pcPrompt5.png");
			type.set ("img/menu/pcPrompt5.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt5_black.png", "img/menu/pcPrompt5_black.png");
			type.set ("img/menu/pcPrompt5_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt6.png", "img/menu/pcPrompt6.png");
			type.set ("img/menu/pcPrompt6.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt6_black.png", "img/menu/pcPrompt6_black.png");
			type.set ("img/menu/pcPrompt6_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt7.png", "img/menu/pcPrompt7.png");
			type.set ("img/menu/pcPrompt7.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/pcPrompt7_black.png", "img/menu/pcPrompt7_black.png");
			type.set ("img/menu/pcPrompt7_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/Player Menu.json", "img/menu/Player Menu.json");
			type.set ("img/menu/Player Menu.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/menu/Player Menu.png", "img/menu/Player Menu.png");
			type.set ("img/menu/Player Menu.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/ready_join.png", "img/menu/ready_join.png");
			type.set ("img/menu/ready_join.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt1.png", "img/menu/xboxPrompt1.png");
			type.set ("img/menu/xboxPrompt1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt1_black.png", "img/menu/xboxPrompt1_black.png");
			type.set ("img/menu/xboxPrompt1_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt2.png", "img/menu/xboxPrompt2.png");
			type.set ("img/menu/xboxPrompt2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt2_black.png", "img/menu/xboxPrompt2_black.png");
			type.set ("img/menu/xboxPrompt2_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt3.png", "img/menu/xboxPrompt3.png");
			type.set ("img/menu/xboxPrompt3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt3_black.png", "img/menu/xboxPrompt3_black.png");
			type.set ("img/menu/xboxPrompt3_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt4.png", "img/menu/xboxPrompt4.png");
			type.set ("img/menu/xboxPrompt4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt4_black.png", "img/menu/xboxPrompt4_black.png");
			type.set ("img/menu/xboxPrompt4_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt5.png", "img/menu/xboxPrompt5.png");
			type.set ("img/menu/xboxPrompt5.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt5_black.png", "img/menu/xboxPrompt5_black.png");
			type.set ("img/menu/xboxPrompt5_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt6.png", "img/menu/xboxPrompt6.png");
			type.set ("img/menu/xboxPrompt6.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt6_black.png", "img/menu/xboxPrompt6_black.png");
			type.set ("img/menu/xboxPrompt6_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt7.png", "img/menu/xboxPrompt7.png");
			type.set ("img/menu/xboxPrompt7.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xboxPrompt7_black.png", "img/menu/xboxPrompt7_black.png");
			type.set ("img/menu/xboxPrompt7_black.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/menu/xbox_a_button.png", "img/menu/xbox_a_button.png");
			type.set ("img/menu/xbox_a_button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Blue Player.json", "img/players/Blue Player.json");
			type.set ("img/players/Blue Player.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Blue Player.png", "img/players/Blue Player.png");
			type.set ("img/players/Blue Player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Green Player.json", "img/players/Green Player.json");
			type.set ("img/players/Green Player.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Green Player.png", "img/players/Green Player.png");
			type.set ("img/players/Green Player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/halo.png", "img/players/halo.png");
			type.set ("img/players/halo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Muzzle Flashes.json", "img/players/Muzzle Flashes.json");
			type.set ("img/players/Muzzle Flashes.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Muzzle Flashes.png", "img/players/Muzzle Flashes.png");
			type.set ("img/players/Muzzle Flashes.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Orange Player.json", "img/players/Orange Player.json");
			type.set ("img/players/Orange Player.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Orange Player.png", "img/players/Orange Player.png");
			type.set ("img/players/Orange Player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Powerup ring.json", "img/players/Powerup ring.json");
			type.set ("img/players/Powerup ring.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Powerup ring.png", "img/players/Powerup ring.png");
			type.set ("img/players/Powerup ring.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Purple Player.json", "img/players/Purple Player.json");
			type.set ("img/players/Purple Player.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Purple Player.png", "img/players/Purple Player.png");
			type.set ("img/players/Purple Player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/players/Red Player.json", "img/players/Red Player.json");
			type.set ("img/players/Red Player.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/players/Red Player.png", "img/players/Red Player.png");
			type.set ("img/players/Red Player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/powerups/flare.json", "img/powerups/flare.json");
			type.set ("img/powerups/flare.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/powerups/flare.png", "img/powerups/flare.png");
			type.set ("img/powerups/flare.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/powerups/Shield.json", "img/powerups/Shield.json");
			type.set ("img/powerups/Shield.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/powerups/Shield.png", "img/powerups/Shield.png");
			type.set ("img/powerups/Shield.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/skull.json", "img/skull.json");
			type.set ("img/skull.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/skull.png", "img/skull.png");
			type.set ("img/skull.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/Tombstone.json", "img/Tombstone.json");
			type.set ("img/Tombstone.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/Tombstone.png", "img/Tombstone.png");
			type.set ("img/Tombstone.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/Zombie.json", "img/Zombie.json");
			type.set ("img/Zombie.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/Zombie.png", "img/Zombie.png");
			type.set ("img/Zombie.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("map/0.tmx", "map/0.tmx");
			type.set ("map/0.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/1.tmx", "map/1.tmx");
			type.set ("map/1.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/10.tmx", "map/10.tmx");
			type.set ("map/10.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/11.tmx", "map/11.tmx");
			type.set ("map/11.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/12.tmx", "map/12.tmx");
			type.set ("map/12.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/2.tmx", "map/2.tmx");
			type.set ("map/2.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/3.tmx", "map/3.tmx");
			type.set ("map/3.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/4.tmx", "map/4.tmx");
			type.set ("map/4.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/5.tmx", "map/5.tmx");
			type.set ("map/5.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/6.tmx", "map/6.tmx");
			type.set ("map/6.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/7.tmx", "map/7.tmx");
			type.set ("map/7.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/8.tmx", "map/8.tmx");
			type.set ("map/8.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("map/9.tmx", "map/9.tmx");
			type.set ("map/9.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("info/tiledefs.txt", "info/tiledefs.txt");
			type.set ("info/tiledefs.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("sound/0.ogg", "sound/0.ogg");
			type.set ("sound/0.ogg", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("dekar", "assets/font/DEKAR.OTF");
			type.set ("dekar", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("arial", "assets/font/ARIAL.TTF");
			type.set ("arial", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("zombie", "assets/font/ZOMBIE.TTF");
			type.set ("zombie", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("impact", "assets/font/IMPACT.TTF");
			type.set ("impact", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
