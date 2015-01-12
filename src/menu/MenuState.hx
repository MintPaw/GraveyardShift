package menu;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.android.FlxAndroidKey;
import flixel.input.android.FlxAndroidKeys;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;
import game.Level;
import game.Zombie;
import input.InputLayout;
import input.InputManager;
import menu.substates.ExterminateSubState;
import menu.substates.HelpSubState;
import menu.substates.OptionsSubState;
import menu.substates.PlayerSelectSubState;
import menu.substates.StatsSubState;
import menu.substates.VersusSubState;
import openfl.Lib;
import openfl.system.System;

/**
 * ...
 * @author MintPaw
 */
class MenuState extends FlxState
{
	private var _items:Array<MenuItem>;
	private var _lables:Array<String> = ["Versus", "Options", "Stats", "Help", "Quit"];
	
	private var _selected:Int;
	private var _inState:Bool = true;
	
	private var _controllerDelay:Float = 0;
	
	private var _zombieGroup:FlxGroup = new FlxGroup();
	private var _level:Level;
	private var _firstTime:Bool = true;
	private var _bg:FlxSprite;
	private var _prompt:FlxSprite;
	private var _bgContainer:FlxGroup = new FlxGroup();
	private var _title:FlxSprite;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		setupBackground();
		
		_bg = new FlxSprite();
		_bg.scrollFactor.set();
		add(_bg);
		
		FlxG.camera.fade(FlxColor.BLACK, 1, true);
		
		if (Reg.menuGoingToVersus)
		{
			_inState = false;
			openSubState(new PlayerSelectSubState());
		}
		
		_items = [];
		
		#if ouya
			_items.pop();
		#end
		
		var topPadding:Int = 600;
		var leftPadding:Int = 100;
		var buttonPadding:Int = -15;
		
		for (i in 0..._lables.length)
		{
			var b:MenuButton = new MenuButton(_lables[i], 50);
			b.x = leftPadding;
			b.y = i * (b.height + buttonPadding) + topPadding;
			b.scrollFactor.set();
			add(b);
			
			_items.push(b);
		}
		
		_bg.x = _items[0].x;
		_bg.y = topPadding;
		_bg.makeGraphic(Math.round(_items[0].width), Math.round(_items[1].height * _items.length + (buttonPadding * _items.length) + 19), 0x55000000);
		
		setSelected(0);
		
		var controller:String = "";
		var promptSuffix:String = !Reg.isSnowing ? "" : "_black";
		
		#if ouya
		controller = "ouya";
		#else
		if (FlxG.gamepads.getByID(0) != null) controller = "xbox" else controller = "pc";
		#end
		_prompt = new FlxSprite(0, 0, "img/menu/" +  controller + "Prompt1" + promptSuffix + ".png");
		_prompt.x = FlxG.width - _prompt.width - 20;
		_prompt.y = FlxG.height - _prompt.height - 20;
		add(_prompt);
		
		_title = new FlxSprite(0, 0, "img/menu/gameTitle.png");
		_title.x = FlxG.width / 2 - _title.width / 2;
		_title.y = FlxG.height / 2 - _title.height / 2 - 200;
		add(_title);
		
		_items[2].alpha = .5;
	}
	
	private function setupBackground():Void
	{
		_level = Rs.getLevel(Reg.random.int(0, 5));
		_level.tilemap.scrollFactor.set();
		add(_level.waterGroup);
		add(_level.sparkleGroup);
		add(_level.tilemap);
		
		add(_bgContainer);
		
		Reg.isSnowing = _level.isSnow;
		
		var _bigEntitiyGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
		add(_bigEntitiyGroup);
		
		for (i in 0..._level.smallRockList.length)
		{
			var rock:FlxSprite = new FlxSprite();
			rock.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/GameAssets.png", "img/map/GameAssets.json");
			rock.animation.addByNames("default", ["rock" + Math.round(Math.random() * 2 + 1) + ".png"], 0, false);
			rock.animation.play("default");
			rock.x = _level.smallRockList[i].x + Reg.randMinMax( -Reg.SMALL_ROCK_JUMBLE, Reg.SMALL_ROCK_JUMBLE) - rock.width / 2;
			rock.y = _level.smallRockList[i].y  + Reg.randMinMax( -Reg.SMALL_ROCK_JUMBLE, Reg.SMALL_ROCK_JUMBLE);
			rock.scale.x = Math.random() > .5 ? -1 : 1;
			rock.offset.y = rock.height - (rock.height * .2) * 2;
			rock.height *= .2;
			rock.immovable = true;
			rock.scrollFactor.set();
			_bgContainer.add(rock);
		}
		
		for (i in 0..._level.largeRockList.length)
		{
			var rock:FlxSprite = new FlxSprite();
			rock.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/GameAssets.png", "img/map/GameAssets.json");
			rock.animation.addByNames("default", ["rock" + Math.round(Math.random() + 4) + ".png"], 0, false);
			rock.animation.play("default");
			rock.x = _level.largeRockList[i].x + Reg.randMinMax( -Reg.LARGE_ROCK_JUMBLE, Reg.LARGE_ROCK_JUMBLE) - rock.width / 2;
			rock.y = _level.largeRockList[i].y  + Reg.randMinMax( -Reg.LARGE_ROCK_JUMBLE, Reg.LARGE_ROCK_JUMBLE) - rock.height / 2;
			rock.scale.x = Math.random() > .5 ? -1 : 1;
			//rock.offset.y = rock.height - (rock.height * .2) * 2;
			//rock.height *= .2;
			rock.immovable = true;
			rock.scrollFactor.set();
			_bigEntitiyGroup.add(rock);
			_bgContainer.add(rock);
		}
		
		for (i in 0..._level.smallTreeList.length)
		{
			var tree:FlxSprite = new FlxSprite();
			tree.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/GameAssets.png", "img/map/GameAssets.json");
			if (_level.isSnow)
			{
				tree.animation.addByNames("default", [Reg.random.bool() ? "bush2.png" : "bushSnow.png"], 0, false);
			} else {
				tree.animation.addByNames("default", ["bush" + Math.round(Math.random() + 1) + ".json"], 0, false);
			}
			tree.animation.play("default");
			tree.scale.x = Math.random() > .5 ? -1 : 1;
			tree.offset.y = tree.height - (tree.height * .2) * 2;
			tree.height *= .2;
			tree.immovable = true;
			tree.allowCollisions = FlxObject.NONE;
			tree.scrollFactor.set();
			_bgContainer.add(tree);
		}
		
		for (i in 0..._level.largeTreeList.length)
		{
			var tree:FlxSprite = new FlxSprite();
			tree.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/GameAssets.png", "img/map/GameAssets.json");
			if (_level.isSnow)
			{
				tree.animation.addByNames("default", [Reg.random.bool() ? "tree2.png" : "treeSnow.png"], 0, false);
			} else {
				tree.animation.addByNames("default", ["tree" + Math.round(Math.random() + 1) + ".png"], 0, false);
			}
			tree.x = _level.largeTreeList[i].x + Reg.randMinMax( -Reg.LARGE_TREE_JUMBLE, Reg.LARGE_TREE_JUMBLE) - tree.width / 2;
			tree.y = _level.largeTreeList[i].y  + Reg.randMinMax( -Reg.LARGE_TREE_JUMBLE, Reg.LARGE_TREE_JUMBLE) - tree.height / 2;
			tree.scale.x = Math.random() > .5 ? -1 : 1;
			tree.offset.y = tree.height - (tree.height * .2) * 2;
			tree.height *= .2;
			tree.allowCollisions = FlxObject.NONE;
			tree.immovable = true;
			tree.scrollFactor.set();
			_bgContainer.add(tree);
		}
		
		var zombieGroups:Int;
		var zombieGroupPoints:Array<FlxPoint>;
		var zombiePoints:Array<FlxPoint> = [];
		var needToRetry:Bool = true;
		
		while (needToRetry)
		{
			zombieGroups = 4;
			zombieGroupPoints = [];
			zombiePoints = [];
			
			var tries:Int = 0;
			needToRetry = false;
			
			for (i in 0...zombieGroups)
			{
				tries = 0;
				while (tries < 1000)
				{
					var pointInQuestion:FlxPoint = new FlxPoint(Math.random() * FlxG.width, Math.random() * FlxG.height);
					var canBreak:Bool = true;
					
					pointInQuestion.x = FlxMath.bound(pointInQuestion.x, Reg.ZOMBIE_GROUP_WALL_SPACING * 2, FlxG.width - Reg.ZOMBIE_GROUP_WALL_SPACING * 2);
					pointInQuestion.y = FlxMath.bound(pointInQuestion.y, Reg.ZOMBIE_GROUP_WALL_SPACING * 2, FlxG.height - Reg.ZOMBIE_GROUP_WALL_SPACING * 2);
					
					if (_level.tilemap.overlapsPoint(pointInQuestion)) canBreak = false;
					if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x + Reg.ZOMBIE_GROUP_WALL_SPACING, pointInQuestion.y + Reg.ZOMBIE_GROUP_WALL_SPACING))) canBreak = false;
					if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x - Reg.ZOMBIE_GROUP_WALL_SPACING, pointInQuestion.y + Reg.ZOMBIE_GROUP_WALL_SPACING))) canBreak = false;
					if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x + Reg.ZOMBIE_GROUP_WALL_SPACING, pointInQuestion.y - Reg.ZOMBIE_GROUP_WALL_SPACING))) canBreak = false;
					if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x - Reg.ZOMBIE_GROUP_WALL_SPACING, pointInQuestion.y - Reg.ZOMBIE_GROUP_WALL_SPACING))) canBreak = false;
					
					for (j in 0...zombieGroupPoints.length) if (canBreak && zombieGroupPoints[j].distanceTo(pointInQuestion) < Reg.ZOMBIE_GROUP_SPACING) canBreak = false; 
					
					if (canBreak)
					{
						zombieGroupPoints.push(pointInQuestion);
						break;
					}
					
					tries++;
				}
			}
			
			if (tries >= 999) needToRetry = true;
			
			for (i in 0...zombieGroupPoints.length)
			{
				tries = 0;
				for (j in 0...Math.round(Reg.randMinMax(Reg.ZOMBIES_PER_GROUP_MIN, Reg.ZOMBIES_PER_GROUP_MAX)))
				{
					while (tries < 1000)
					{
						var pointInQuestion:FlxPoint = new FlxPoint();
						pointInQuestion.x = Reg.randMinMax(zombieGroupPoints[i].x - Reg.ZOMBIE_GROUP_SPAWN_RADIUS, zombieGroupPoints[i].x + Reg.ZOMBIE_GROUP_SPAWN_RADIUS);
						pointInQuestion.y = Reg.randMinMax(zombieGroupPoints[i].y - Reg.ZOMBIE_GROUP_SPAWN_RADIUS, zombieGroupPoints[i].y + Reg.ZOMBIE_GROUP_SPAWN_RADIUS);
						var canBreak:Bool = true;
						
						pointInQuestion.x = FlxMath.bound(pointInQuestion.x, Reg.ZOMBIE_WALL_SPACING * 2, FlxG.width - Reg.ZOMBIE_WALL_SPACING * 2);
						pointInQuestion.y = FlxMath.bound(pointInQuestion.y, Reg.ZOMBIE_WALL_SPACING * 2, FlxG.height - Reg.ZOMBIE_WALL_SPACING * 2);
						
						if (_level.tilemap.overlapsPoint(pointInQuestion)) canBreak = false;
						if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x + Reg.ZOMBIE_WALL_SPACING, pointInQuestion.y + Reg.ZOMBIE_WALL_SPACING))) canBreak = false;
						if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x - Reg.ZOMBIE_WALL_SPACING, pointInQuestion.y + Reg.ZOMBIE_WALL_SPACING))) canBreak = false;
						if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x + Reg.ZOMBIE_WALL_SPACING, pointInQuestion.y - Reg.ZOMBIE_WALL_SPACING))) canBreak = false;
						if (canBreak && _level.tilemap.overlapsPoint(new FlxPoint(pointInQuestion.x - Reg.ZOMBIE_WALL_SPACING, pointInQuestion.y - Reg.ZOMBIE_WALL_SPACING))) canBreak = false;
						
						for (k in 0...zombiePoints.length) if (canBreak && zombiePoints[k].distanceTo(pointInQuestion) < Reg.ZOMBIE_INTER_GROUP_SPACING) canBreak = false; 
						for (k in 0..._bigEntitiyGroup.members.length) if (canBreak && _bigEntitiyGroup.members[k].getMidpoint().distanceTo(pointInQuestion) < Reg.ZOMBIE_ENTITY_SPACING) canBreak = false; 
						
						if (canBreak)
						{
							zombiePoints.push(pointInQuestion);
							break;
						}
						
						tries++;
					}
				}
			}
			
			if (tries >= 999) needToRetry = true;
			needToRetry = false;
		}
		
		for (i in 0...zombiePoints.length)
		{
			var z:Zombie = new Zombie();
			z.x = zombiePoints[i].x - z.width / 2;
			z.y = zombiePoints[i].y - z.height / 2;
			z.scrollFactor.set();
			_zombieGroup.add(z);
			_bgContainer.add(z);
		}
		
		persistentUpdate = true;
		persistentDraw = true;
	}
	
	private function setSelected(index:Int):Void
	{
		for (i in 0..._items.length) _items[i].up();
		
		_items[index].over();
		
		_selected = index;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (_firstTime)
		{
			_firstTime = false;
			return;
		}
		
		FlxG.collide(_zombieGroup, _level.tilemap);
		FlxG.collide(_zombieGroup, _zombieGroup);
		_bgContainer.sort(Reg.byY);
		
		if (subState != null)
		{
			for (i in 0..._items.length) _items[i].visible = false;
			_bg.visible = false;
			_prompt.visible = false;
			_title.visible = false;
			return;
		} else if (!_inState) {
			for (i in 0..._items.length) _items[i].visible = true;
			setSelected(0);
			_bg.visible = true;
			_prompt.visible = true;
			_title.visible = true;
			FlxG.camera.antialiasing = Reg.aa;
			_inState = true;
		}
		
		updateInput();
	}
	
	private function updateInput():Void
	{
		var goUp:Bool = false;
		var goDown:Bool = false;
		var goLeft:Bool = false;
		var goRight:Bool = false;
		var goConfirm:Bool = false;
		var goBack:Bool = false;
		
		_controllerDelay -= FlxG.elapsed;
		
		for (i in 0...4)
		{
			var pad:FlxGamepad = FlxG.gamepads.getByID(0);
			if (pad == null) continue;
			
			Reg.debugBox.text = pad.buttons.toString();
			
			#if fire
			if  (pad.getAxis(0) < -InputManager.deadZone) goLeft = true;
			if  (pad.getAxis(0) > InputManager.deadZone) goRight = true;
			if  (pad.getAxis(1) < -InputManager.deadZone) goUp = true;
			if  (pad.getAxis(1) > InputManager.deadZone) goDown = true;
			#else
			if  (pad.getXAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || pad.justReleased(InputLayout.DPAD_LEFT)) goLeft = true;
			if  (pad.getXAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || pad.justReleased(InputLayout.DPAD_RIGHT)) goRight = true;
			if  (pad.getYAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || pad.justReleased(InputLayout.DPAD_UP)) goUp = true;
			if  (pad.getYAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || pad.justReleased(InputLayout.DPAD_DOWN)) goDown = true;
			#end
			if  (pad.justPressed(InputLayout.CONFIRM)) goConfirm = true;
		}
		
		if (FlxG.keys.justPressed.LEFT) goLeft = true;
		if (FlxG.keys.justPressed.RIGHT) goRight = true;
		if (FlxG.keys.justPressed.UP) goUp = true;
		if (FlxG.keys.justPressed.DOWN) goDown = true;
		if (FlxG.keys.justPressed.ENTER) goConfirm = true;
		if (FlxG.keys.justPressed.ESCAPE) goBack = true;
		
		if (!goLeft && !goRight && !goUp && !goDown) _controllerDelay = 0;
		
		if (_controllerDelay > 0) return;
		
		if (goLeft || goRight || goUp || goDown)
		{
			_controllerDelay = .2;
			Sm.playEffect(Sm.SELECTION_MOVE);
		}
		
		if (goDown)
		{
			var selection:Int = _selected == _items.length - 1 ? 0 : _selected + 1;
			setSelected(selection);
		} else if (goUp) {
			var selection:Int = _selected == 0 ? _items.length - 1 : _selected - 1;
			setSelected(selection);
		} else if (goConfirm) {
			if (_items[_selected].alpha < 1) return;
			confirm();
		} else if (goBack) {
			Sm.playEffect(Sm.MENU_BACK);
			setSelected(5);
		}
	}
	
	private function confirm():Void
	{
		if (_selected == 0)
		{
			GameRules.gameMode = GameRules.VERSUS;
			openSubState(new PlayerSelectSubState());
		}
		
		if (_selected == 1) openSubState(new OptionsSubState());
		if (_selected == 2) openSubState(new StatsSubState());
		if (_selected == 3) openSubState(new HelpSubState());
		if (_selected == 4) System.exit(0);
		
		_inState = false;
	}
	
}