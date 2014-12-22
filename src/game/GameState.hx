package game;

import flash.geom.Rectangle;
import flash.net.URLRequest;
import flixel.addons.plugin.screengrab.FlxScreenGrab;
import flixel.addons.util.FlxAsyncLoop;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.math.FlxVelocity;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;
import game.substates.CounterSubState;
import game.substates.PauseSubState;
import game.substates.ScoreboardSubState;
import input.InputLayout;
import input.InputManager;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Lib;

/**
 * ...
 * @author MintPaw
 */
class GameState extends FlxState
{
	public var needToReset:Bool = false;
	
	private var _level:Level;
	private var _hud:Hud;
	
	private var _ending:Bool = false;
	
	private var _container:FlxGroup;
	
	private var _playerGroup:FlxTypedGroup<Player>;
	private var _playerHitBoxGroup:FlxTypedGroup<FlxSprite>;
	private var _zombieGroup:FlxTypedGroup<Zombie>;
	private var _bulletGroup:FlxTypedGroup<Bullet>;
	private var _entitiyGroup:FlxTypedGroup<FlxSprite>;
	private var _bigEntitiyGroup:FlxTypedGroup<FlxSprite>;
	private var _explosionGroup:FlxTypedGroup<Explosion>;
	private var _powerupGroup:FlxTypedGroup<Powerup>;
	private var _flareGroup:FlxTypedGroup<Flare>;
	private var _tombStoneGroup:FlxTypedGroup<FlxSprite>;
	private var _woodCrateGroup:FlxTypedGroup<Crate>;
	private var _metalCrateGroup:FlxTypedGroup<FlxSprite>;
	private var _staticGroup:FlxTypedGroup<FlxSprite>;
	private var _dynamicGroup:FlxTypedGroup<FlxSprite>;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		
		setupVars();
		setupTilemap();
		setupContainer();
		setupEntities();
		setupPlayers();
		setupZombies();
		setupHud();
		
		showCounter();
	}
	
	private function setupVars():Void
	{
		_playerGroup = new FlxTypedGroup<Player>();
		_playerHitBoxGroup = new FlxTypedGroup<FlxSprite>();
		_zombieGroup = new FlxTypedGroup<Zombie>();
		_bulletGroup = new FlxTypedGroup<Bullet>();
		_entitiyGroup = new FlxTypedGroup<FlxSprite>();
		_bigEntitiyGroup = new FlxTypedGroup<FlxSprite>();
		_explosionGroup = new FlxTypedGroup<Explosion>();
		_powerupGroup = new FlxTypedGroup<Powerup>();
		_flareGroup = new FlxTypedGroup<Flare>();
		_tombStoneGroup = new FlxTypedGroup<FlxSprite>();
		_woodCrateGroup = new FlxTypedGroup<Crate>();
		_metalCrateGroup = new FlxTypedGroup<FlxSprite>();
		_staticGroup = new FlxTypedGroup<FlxSprite>();
		_dynamicGroup = new FlxTypedGroup<FlxSprite>();
	}
	
	private function setupTilemap():Void
	{
		_level = Rs.getLevel(Reg.levelNumber);
		add(_level.waterGroup);
		add(_level.sparkleGroup);
		add(_level.tilemap);
		add(_level.bulletTilemap);
		
		Reg.isSnowing = _level.isSnow;
	}
	
	private function setupContainer():Void
	{
		_container = new FlxGroup();
		add(_container);
	}
	
	private function setupEntities():Void
	{
		for (i in 0..._level.smallRockList.length)
		{
			var rock:FlxSprite = new FlxSprite();
			rock.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/GameAssets.png", "img/map/GameAssets.json");
			rock.animation.addByNames("default", ["rock" + Math.round(Math.random() * 2 + 1) + ".png"], 0, false);
			rock.animation.play("default");
			rock.x = _level.smallRockList[i].x + Reg.randMinMax( -Reg.SMALL_ROCK_JUMBLE, Reg.SMALL_ROCK_JUMBLE) - rock.width / 2;
			rock.y = _level.smallRockList[i].y  + Reg.randMinMax( -Reg.SMALL_ROCK_JUMBLE, Reg.SMALL_ROCK_JUMBLE) - rock.height / 2;
			rock.scale.x = Math.random() > .5 ? -1 : 1;
			rock.offset.y = rock.height - (rock.height * .2) * 2;
			rock.height *= .2;
			rock.immovable = true;
			_entitiyGroup.add(rock);
			_container.add(rock);
			_staticGroup.add(rock);
		}
		
		for (i in 0..._level.largeRockList.length)
		{
			var randomBump:FlxPoint = new FlxPoint();
			
			var rock:FlxSprite = new FlxSprite();
			rock.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/GameAssets.png", "img/map/GameAssets.json");
			rock.animation.addByNames("default", ["rock" + Math.round(Math.random() + 4) + ".png"], 0, false);
			rock.animation.play("default");

			rock.x = _level.largeRockList[i].x + randomBump.x - rock.width / 2;
			rock.y = _level.largeRockList[i].y  + randomBump.y - rock.height / 2;
			rock.scale.x = Math.random() > .5 ? -1 : 1;
			rock.immovable = true;
			_bigEntitiyGroup.add(rock);
			_entitiyGroup.add(rock);
			_container.add(rock);
			_staticGroup.add(rock);
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
			tree.x = _level.smallTreeList[i].x + Reg.randMinMax( -Reg.SMALL_TREE_JUMBLE, Reg.SMALL_TREE_JUMBLE) - tree.width / 2;
			tree.y = _level.smallTreeList[i].y  + Reg.randMinMax( -Reg.SMALL_TREE_JUMBLE, Reg.SMALL_TREE_JUMBLE) - tree.height / 2;
			tree.scale.x = Math.random() > .5 ? -1 : 1;
			tree.offset.y = tree.height - (tree.height * .2) * 2;
			tree.height *= .2;
			tree.immovable = true;
			tree.allowCollisions = FlxObject.NONE;
			_entitiyGroup.add(tree);
			_container.add(tree);
			_staticGroup.add(tree);
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
			_entitiyGroup.add(tree);
			_container.add(tree);
			_staticGroup.add(tree);
		}
		
		setupCrates();
	}
	
	private function setupCrates():Void
	{
		for (i in 0..._metalCrateGroup.members.length) _metalCrateGroup.members[i].kill();
		for (i in 0..._woodCrateGroup.members.length)
		{
			_woodCrateGroup.members[i].kill();
			_woodCrateGroup.members[i].needToBreak = false;
		}
		
		for (i in 0..._level.woodenCrateList.length)
		{
			var c:Crate = new Crate();
			
			c.x = _level.woodenCrateList[i].x - (60 - c.width) / 2;
			c.y = _level.woodenCrateList[i].y - (100 - c.height) / 2;
			c.drag.set(800, 800);
			c.maxVelocity.set(100, 100);
			c.origin.y += c.height;
			_woodCrateGroup.add(c);
			_container.add(c);
			_dynamicGroup.add(c);
			
			#if !android
			_container.add(new Shade(c, 0));
			#end
		}
		
		for (i in 0..._level.metalCrateList.length)
		{
			var c:FlxSprite = new FlxSprite(0, 0, "img/map/metal_crate.png");
			
			c.x = _level.metalCrateList[i].x + (60 - c.width) / 2;
			c.y = _level.metalCrateList[i].y + (100 - c.height) / 2;
			c.health = 99999999999999;
			c.drag.set(2400, 2400);
			c.maxVelocity.set(2, 2);
			c.origin.y += c.height;
			c.x -= 25;
			c.y -= 50;
			_metalCrateGroup.add(c);
			_container.add(c);
			_dynamicGroup.add(c);
			
			#if !android
			_container.add(new Shade(c, 1));
			#end
		}
	}
	
	private function setupPlayers():Void
	{
		var spawnPoints:Array<FlxPoint> = _level.spawnPoints.copy();
		
		for (i in 0...Reg.players.length)
		{
			var p:Player = new Player(Reg.players[i], InputManager.layouts[i], InputManager.currentDevicesIDs[i], i);
			p.spawnPoint = spawnPoints.splice(Math.round(Math.random() * (spawnPoints.length - 1)), 1)[0];
			p.setPosition(p.spawnPoint.x - p.width / 2, p.spawnPoint.y - p.height / 2);
			
			_playerHitBoxGroup.add(p.hitBox);
			_container.add(p);
			add(p.healthBar);
			_container.add(p.muzzleFlash);
			_container.add(p.arrow);
			_container.add(p.circle);
			_playerGroup.add(p);
			_container.add(p.shield);
			_container.add(p.halo);
			//add(p.trail);
			add(p.hitBox);
			_dynamicGroup.add(p);
		}
	}
	
	private function setupZombies(ratio:Float = 1):Void
	{
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
					for (j in 0..._playerGroup.members.length) if (canBreak && _playerGroup.members[j].getMidpoint().distanceTo(pointInQuestion) < Reg.ZOMBIE_GROUP_SPACING) canBreak = false; 
					
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
				for (j in 0...Math.round(Reg.randMinMax(Reg.ZOMBIES_PER_GROUP_MIN, Reg.ZOMBIES_PER_GROUP_MAX) * ratio))
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
						for (i in 0..._woodCrateGroup.members.length) if (canBreak && _woodCrateGroup.members[i].overlapsPoint(pointInQuestion)) canBreak = false;
						for (i in 0..._metalCrateGroup.members.length) if (canBreak && _metalCrateGroup.members[i].overlapsPoint(pointInQuestion)) canBreak = false;
						
						for (k in 0..._playerGroup.members.length) if (canBreak && _playerGroup.members[k].getMidpoint().distanceTo(pointInQuestion) < Reg.ZOMBIE_GROUP_SPACING) canBreak = false; 
						for (k in 0...zombiePoints.length) if (canBreak && zombiePoints[k].distanceTo(pointInQuestion) < Reg.ZOMBIE_INTER_GROUP_SPACING) canBreak = false; 
						for (k in 0..._bigEntitiyGroup.members.length) if (canBreak && _entitiyGroup.members[k].getMidpoint().distanceTo(pointInQuestion) < Reg.ZOMBIE_ENTITY_SPACING) canBreak = false; 
						
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
		}
		
		for (i in 0...zombiePoints.length)
		{
			var z:Zombie = new Zombie();
			z.x = zombiePoints[i].x - z.width / 2;
			z.y = zombiePoints[i].y - z.height / 2;
			_container.add(z.healthBar);
			_container.add(z);
			_zombieGroup.add(z);
			_dynamicGroup.add(z);
		}
	}
	
	private function setupHud():Void
	{
		_hud = new Hud(_playerGroup.members);
		_hud.x = FlxG.width / 2 - _hud.width / 2;
		_hud.y = 10;
		add(_hud);
	}
	
	private function resetLevel():Void
	{
		needToReset = false;
		_ending = false;
		
		for (i in 0..._playerGroup.members.length)
		{
			_playerGroup.members[i].reset(_playerGroup.members[i].spawnPoint.x - _playerGroup.members[i].width / 2, _playerGroup.members[i].spawnPoint.y - _playerGroup.members[i].height / 2);
			_playerGroup.members[i].setValues();
			//_playerGroup.members[i].trail.visible = false;
		}
		
		while (_zombieGroup.countLiving() < Reg.MIN_ZOMBIES[Reg.levelNumber])
		{
			setupZombies(.1);
		}
		
		Reg.debugBox.text = "";
		
		update(FlxG.elapsed);
		setupCrates();
		showCounter();
	}
	
	override private function tryUpdate(elapsed:Float):Void 
	{
		super.tryUpdate(elapsed);
		
		if (subState != null)
		{
			for (i in 0..._zombieGroup.members.length)
			{
				if (_zombieGroup.members[i].visible && _zombieGroup.members[i].animation.curAnim.name == Zombie.RISING) _zombieGroup.members[i].update(elapsed);
			}
			for (i in 0...members.length)
			{
				if (Std.is(members[i], FlxSprite) && cast(members[i], FlxSprite).width == 75) members[i].update(elapsed);
			}
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (needToReset) resetLevel();
		
		if (_level != null) _level.update(elapsed);
		updateDepth();
		updateGlobalKeys();
		updatePlayers();
		updateZombies();
		updateBullets();
		updateFlares();
		updateCrates();
		updateCollisions();
		updateRounds();
	}
	
	private function updateCollisions():Void
	{
		var initialTime:Int = Lib.getTimer();
		
		FlxG.overlap(_bulletGroup, _woodCrateGroup, bulletVSCrate);
		FlxG.overlap(_bulletGroup, _metalCrateGroup, bulletVSCrate);
		
		FlxG.collide(_dynamicGroup, _level.tilemap);
		FlxG.collide(_dynamicGroup, _dynamicGroup);
		FlxG.collide(_dynamicGroup, _staticGroup);
		
		FlxG.collide(_bulletGroup, _bigEntitiyGroup, destroyBullet);
		FlxG.collide(_bulletGroup, _level.bulletTilemap, destroyBullet);
		
		FlxG.overlap(_explosionGroup, _woodCrateGroup, explosionVSCrate);
		
		FlxG.overlap(_playerGroup, _powerupGroup, playerVSPowerup);
		FlxG.overlap(_playerHitBoxGroup, _explosionGroup, playerHitVSExplosion);
		
		FlxG.overlap(_bulletGroup, _playerHitBoxGroup, bulletVSPlayerHit);
		FlxG.overlap(_bulletGroup, _zombieGroup, bulletVSZombie);
		
		FlxG.overlap(_zombieGroup, _explosionGroup, zombieVSExplosion);
		FlxG.overlap(_zombieGroup, _playerHitBoxGroup);
	}
	
	private function updateDepth():Void
	{
		_container.sort(Reg.byY);
	}
	
	private function updateGlobalKeys():Void
	{
		if (FlxG.keys.justPressed.ESCAPE) openSubState(new PauseSubState());
		if (Reg.homePressed)
		{
			Reg.homePressed = false;
			openSubState(new PauseSubState());
		}
		
		for (i in 0..._playerGroup.members.length)
		{
			if (_playerGroup.members[i].keybinding.isController)
			{
				if (_playerGroup.members[i].controller != null && _playerGroup.members[i].controller.justPressed(InputLayout.PAUSE)) openSubState(new PauseSubState(_playerGroup.members[i]));
			}
		}
	}
	
	private function updatePlayers():Void
	{
		for (i in 0..._playerGroup.members.length)
		{
			if (_playerGroup.members[i].needPowerupEffect)
			{
				_playerGroup.members[i].needPowerupEffect = false;
				
				var ring:FlxSprite = new FlxSprite();
				ring.frames = FlxAtlasFrames.fromTexturePackerJson("img/players/Powerup ring.png", "img/players/Powerup ring.json");
				ring.animation.addByPrefix("default", "ringActivate_" + _playerGroup.members[i].modelNumber + "_", 30, false);
				ring.animation.play("default");
				ring.x = _playerGroup.members[i].getGraphicMidpoint().x - ring.width / 2;
				ring.y = _playerGroup.members[i].getGraphicMidpoint().y - ring.height / 2 - 40;
				add(ring);
				
			}
			
			if (_playerGroup.members[i].needsToShoot)
			{
				shoot(_playerGroup.members[i], _playerGroup.members[i].currentWeapon == Player.SHOTGUN ? 6 : 1);
				
				_playerGroup.members[i].needsToShoot = false;
			}
			
			if (_playerGroup.members[i].needsDropFlare)
			{
				_playerGroup.members[i].needsDropFlare = false;
				dropFlare(_playerGroup.members[i].x + _playerGroup.members[i].width / 2, _playerGroup.members[i].y);
			}
			
			if (_playerGroup.members[i].needsLostAttraction)
			{
				_playerGroup.members[i].needsLostAttraction = false;
				
				unAggroZombies(_playerGroup.members[i]);
				FlxTween.tween(_playerGroup.members[i], { alpha: .05 }, .5);
			}
			
			if (_playerGroup.members[i].needsToSpawnZombies)
			{
				_playerGroup.members[i].needsToSpawnZombies = false;
				
				for (j in 0..._playerGroup.members.length)
				{
					var p:Player = _playerGroup.members[j];
					if (p == _playerGroup.members[i]) continue;
					
					var loop:FlxAsyncLoop = new FlxAsyncLoop(5, spawnZombieNearPlayer.bind(p), 1);
					loop.start();
					add(loop);
				}
			}
			
			if (_playerGroup.members[i].needToMakeTombstone)
			{
				_playerGroup.members[i].needToMakeTombstone = false;
				makeTombstone(_playerGroup.members[i]);
			}
		}
	}
	
	private function updateZombies():Void
	{
		var z:Zombie;
		for (i in 0..._zombieGroup.members.length)
		{
			z = _zombieGroup.members[i];
			for (i in 0..._playerGroup.members.length)
			{
				if (z.facing == FlxObject.RIGHT && _playerGroup.members[i].x - z.x < 0) continue
				else if (z.facing == FlxObject.LEFT && _playerGroup.members[i].x - z.x > 0) continue;
				if (FlxMath.distanceBetween(z, _playerGroup.members[i]) < 200) z.startChasing(_playerGroup.members[i]);
			}
			
			if (z.needToDrop)
			{
				z.needToDrop = false;
				
				dropPowerup(z.x + z.width / 2, z.y + z.height / 2);
			}
			
			if (z.needToCheckLineOfSight)
			{
				
				if (z.chasing == null)
				{
					z.needToCheckLineOfSight = false;
					return;
				}
				
				if (!z.hasLineOfSight && !_level.bulletTilemap.ray(z.getMidpoint(), z.chasing.getMidpoint()))
				{
					z.stopChasing();
					z.needToCheckLineOfSight = false;
					return;
				}
				z.hasLineOfSight = _level.tilemap.ray(z.getMidpoint(), z.chasing.getMidpoint());
				z.needToCheckLineOfSight = false;
			}
		}
	}
	
	private function updateBullets():Void
	{
		var b:Bullet;
		for (i in 0..._bulletGroup.members.length)
		{
			b = cast(_bulletGroup.members[i], Bullet);
			
			if (b.x < -b.width || b.x > FlxG.width + b.width || b.y < -b.height || b.y > FlxG.height + b.height) b.kill();
			
			if (b.needToExplode && b.alive)
			{
				makeExplosion(b.x + b.width / 2, b.y + b.height / 2, b.playerThatShot);
				b.kill();
			}
		}
	}
	
	private function updateFlares():Void
	{
		for (i in 0..._flareGroup.members.length)
		{
			if (_flareGroup.members[i].needToGoOff)
			{
				_flareGroup.members[i].needToGoOff = false;
				aggroZombies(_flareGroup.members[i]);
			}
		}
	}
	
	private function updateCrates():Void
	{
		for (i in 0..._woodCrateGroup.members.length)
		{
			if (_woodCrateGroup.members[i].needToBreak)
			{
				_woodCrateGroup.members[i].needToBreak = false;
				var c:FlxSprite = new FlxSprite();
				c.frames = FlxAtlasFrames.fromTexturePackerJson("img/map/Crate Break.png", "img/map/Crate Break.json");
				c.animation.addByPrefix("default", "crate_break", 60, false);
				c.animation.play("default");
				c.x = _woodCrateGroup.members[i].x + _woodCrateGroup.members[i].width - c.width / 2 - 18;
				c.y = _woodCrateGroup.members[i].y + _woodCrateGroup.members[i].height - c.height / 2 - 32;
				c.origin.y += 50;
				_container.add(c);
				
				if (Reg.random.bool(GameRules.getDropChance() * (4 / 5))) dropPowerup(c.x + c.width / 2, c.y + c.height / 2);
			}
		}
	}
	
	private function updateRounds():Void
	{
		var playersAlive:Int = _playerGroup.members.length;
		
		for (i in 0..._playerGroup.members.length)
		{
			if (_playerGroup.members[i].killed && !_playerGroup.members[i].needToRevive) playersAlive--;
		}
		
		if (playersAlive <= 1 && !_ending && _playerGroup.members.length > 0)
		{
			_ending = true;
			Actuate.tween(FlxG, .75, { timeScale: 0 } ).delay(1).onComplete(endRound, []);
		}
	}
	
	private function spawnZombieNearPlayer(p:Player):Void
	{
		var z:Zombie = new Zombie();
		
		var canBreak:Bool = false;
		var tries:Int = 0;
		for (i in 0...100)
		{
			tries++;
			canBreak = true;
			
			z.x = p.x + Reg.random.float( -300, 300);
			z.y = p.y + Reg.random.float( -300, 300);
			
			z.x = FlxMath.bound(z.x, Reg.ZOMBIE_WALL_SPACING * 2, FlxG.width - Reg.ZOMBIE_WALL_SPACING * 2);
			z.y = FlxMath.bound(z.y, Reg.ZOMBIE_WALL_SPACING * 2, FlxG.height - Reg.ZOMBIE_WALL_SPACING * 2);
			
			if (_level.tilemap.overlapsPoint(new FlxPoint(z.x, z.y))) canBreak = false;
			if (_level.tilemap.overlapsPoint(new FlxPoint(z.x + z.width, z.y  + z.width))) canBreak = false;
			
			for (l in 0..._playerGroup.members.length) if (_playerGroup.members[l].getMidpoint().distanceTo(new FlxPoint(z.x, z.y)) < 100) canBreak = false; 
			for (l in 0..._bigEntitiyGroup.members.length) if (_entitiyGroup.members[l].getMidpoint().distanceTo(new FlxPoint(z.x, z.y)) < Reg.ZOMBIE_ENTITY_SPACING) canBreak = false;
			
			if (canBreak) break;
		}
		_zombieGroup.add(z);
		add(z);
	}
	
	private function dropPowerup(xpos:Float, ypos:Float):Void
	{
		var p:Powerup = new Powerup();
		p.x = xpos - p.width / 2;
		p.y = ypos - p.height / 2;
		_container.add(p);
		
		_powerupGroup.add(p);
	}
	
	private function dropFlare(xpos:Float, ypos:Float):Void
	{
		var flare:Flare = new Flare();
		flare.centerOrigin();
		flare.x = xpos - flare.width / 2;
		flare.y = ypos - flare.height / 2;
		add(flare);
		
		members.insert(members.indexOf(_container) - 1, members.pop());
		
		_flareGroup.add(flare);
	}
	
	private function makeExplosion(xpos:Float, ypos:Float, player:Player):Void
	{
		var explosion:Explosion = new Explosion();
		explosion.playerThatShot = player;
		explosion.x = xpos - explosion.width / 2;
		explosion.y = ypos - explosion.height / 2;
		
		if (Reg.isSnowing) explosion.color = 0xFF555555;
		
		_explosionGroup.add(explosion);
		_container.add(explosion);
	}
	
	private function shoot(player:Player, bullets:Int):Void
	{
		if (player.lastBullet != null && player.lastBullet.sticky)
		{
			player.lastBullet.explode();
			player.lastBullet = null;
			FlxG.camera.shake(.1, .5);
			return;
		}

		FlxG.camera.shake(.001, .1);
		
		var b:Bullet = new Bullet(_playerGroup.members[0]);
		
		for (i in 0...bullets)
		{
			var velo:Float = Player.bulletSpeeds[player.currentWeaponID];
			
			var rands:FlxPoint = new FlxPoint();
			rands.x += Reg.random.float( -Player.bulletWaver[player.currentWeaponID], Player.bulletWaver[player.currentWeaponID]);
			rands.y += Reg.random.float( -Player.bulletWaver[player.currentWeaponID], Player.bulletWaver[player.currentWeaponID]);
			
			b = new Bullet(player);
			b.x = player.x + player.shotOffset.x - b.width / 2;
			b.y = player.y + player.shotOffset.y - b.height / 2;
			b.damage = Player.bulletDamage[player.currentWeaponID];
			player.lastBullet = b;
			
			if (player.directionFacing == Player.LEFT) b.velocity.set( -velo + rands.x,rands.y);
			if (player.directionFacing == Player.RIGHT) b.velocity.set(velo + rands.x, rands.y);
			if (player.directionFacing == Player.UP) b.velocity.set(rands.x, -velo + rands.y);
			if (player.directionFacing == Player.DOWN) b.velocity.set(rands.x, velo + rands.y);
			if (player.directionFacing == Player.UP_LEFT) b.velocity.set( -velo + rands.x, -velo + rands.y);
			if (player.directionFacing == Player.UP_RIGHT) b.velocity.set( velo + rands.x, -velo + rands.y);
			if (player.directionFacing == Player.DOWN_LEFT) b.velocity.set( -velo + rands.x, velo + rands.y);
			if (player.directionFacing == Player.DOWN_RIGHT) b.velocity.set( velo + rands.x, velo + rands.y);
			
			_bulletGroup.add(b);
			_container.add(b);
			
			Stats.bulletsShot++;
		}
		
		player.needsToShoot = false;
		
		if (player.ammo > 0) player.ammo--;
		if (player.ammo == 0) player.changeWeapon(Player.BLASTER);
		
		if (player.currentWeapon != Player.STICKY) aggroZombies(player);
		
		var kb:FlxPoint = new FlxPoint();
		if (player.directionFacing4 == Player.LEFT) kb.x = Player.knockBacks[Player.gunToIndex(player.currentWeapon)];
		if (player.directionFacing4 == Player.RIGHT) kb.x = -Player.knockBacks[Player.gunToIndex(player.currentWeapon)];
		if (player.directionFacing4 == Player.UP) kb.y = Player.knockBacks[Player.gunToIndex(player.currentWeapon)];
		if (player.directionFacing4 == Player.DOWN) kb.y = -Player.knockBacks[Player.gunToIndex(player.currentWeapon)];
		
		kb.x *= 40;
		kb.y *= 40;
		
		player.velocity.set(kb.x, kb.y);
	}
	
	private function aggroZombies(target:FlxSprite):Void
	{
		var z:Zombie;
		
		for (i in 0..._zombieGroup.members.length)
		{
			z = _zombieGroup.members[i];
			if (target.getMidpoint().distanceTo(z.getMidpoint()) < z.chaseRadius)
			{
				if (z.chasing != null && z.getMidpoint().distanceTo(target.getMidpoint()) > z.getMidpoint().distanceTo(z.chasing.getMidpoint())) continue;
				z.startChasing(target);
			}
		}
	}
	
	private function unAggroZombies(target:FlxSprite):Void
	{
		for (i in 0..._zombieGroup.members.length)
		{
			if (_zombieGroup.members[i].chasing == target) _zombieGroup.members[i].stopChasing();
		}
	}
	
	private function destroyBullet(b1:FlxBasic, b2:FlxBasic = null):Void
	{
		var bullet:Bullet = _bulletGroup.members[0];
		
		for (i in 0..._bulletGroup.members.length)
		{
			if (b1 == _bulletGroup.members[i].model) bullet = _bulletGroup.members[i];
		}
		
		bullet.acceleration.set();
		bullet.velocity.set();
		
		if (bullet.sticky)
		{
			bullet.velocity.set();
			bullet.acceleration.set();
			bullet.allowCollisions = FlxObject.NONE;
			return;
		}
		
		bullet.kill();
	}
	
	private function showCounter():Void
	{
		if (!Reg.skipCountdown) openSubState(new CounterSubState(_level.isSnow));
	}
	
	private function bulletVSPlayerHit(b1:FlxBasic, b2:FlxBasic):Void
	{
		var bullet:Bullet = _bulletGroup.members[0];
		
		for (i in 0..._bulletGroup.members.length)
		{
			if (b1 == _bulletGroup.members[i].model) bullet = _bulletGroup.members[i];
		}
		
		if (bullet.noHit) return;
		
		var player:Player = cast(b2, HitBox).assocPlayer;
		
		if (player == bullet.playerThatShot || bullet.sticky) return;
		if (player.hasShield)
		{
			player.removeShield();
			if (!bullet.laser) bullet.kill();
			bullet.hasHit.push(player);
			return;
		}
		
		if (!bullet.laser) bullet.kill() else
		{
			if (bullet.hasHit.indexOf(player) >= 0) return;
			bullet.hasHit.push(player);
		}
		
		player.hurt(bullet.damage);
		player.lastPlayerToHit = bullet.playerThatShot;
		makeDamageText(bullet.x, bullet.y, "-" + bullet.damage);
		
		if (player.killed)
		{
			Stats.getKill(player.currentWeapon);
		}
	}
	
	private function bulletVSZombie(b1:FlxBasic, b2:FlxBasic):Void
	{
		var bullet:Bullet = _bulletGroup.members[0];
		
		for (i in 0..._bulletGroup.members.length)
		{
			if (b1 == _bulletGroup.members[i].model) bullet = _bulletGroup.members[i];
		}
		
		if (bullet.noHit) return;
		
		var zombie:Zombie = cast(b2, Zombie);
		if (zombie.killed) return;
		
		if (bullet.velocity.x > 0 && zombie.x - bullet.x > 0) return;
		if (bullet.velocity.x < 0 && zombie.x - bullet.x < 0) return;
		
		if (bullet.sticky)
		{
			bullet.allowCollisions = FlxObject.NONE;
			bullet.acceleration.set();
			bullet.velocity.set();
			return;
		}
		
		if (!bullet.laser)
		{
			FlxG.collide(bullet, zombie);
			bullet.kill();
		} else {
			if (bullet.hasHit.indexOf(zombie) >= 0) return;
			bullet.hasHit.push(zombie);
		}
		
		if (zombie.chasing == null) zombie.startChasing(bullet.playerThatShot);
		zombie.hurt(bullet.damage);
		
		makeDamageText(bullet.x, bullet.y, "-" + bullet.damage);
	}
	
	private function playerHitVSExplosion(b1:FlxBasic, b2:FlxBasic):Void
	{
		var player:Player = cast(b1, HitBox).assocPlayer;
		var explosion:Explosion = cast(b2, Explosion);
		
		if (explosion.noHit) return;
		
		if (player.killed) return;
		
		var centrePoint:FlxPoint = explosion.getMidpoint();
		var distanceAway:Float = player.getMidpoint().distanceTo(centrePoint);
		var damage:Float = Math.max(explosion.width / 2 - distanceAway, 10) + 50;
		
		if (player.hasShield)
		{
			player.removeShield();
			return;
		}
		
		if (player.hitExplosion(damage, explosion))
		{
			makeDamageText(player.x + player.width / 2, player.y + player.height / 2, "-" + Math.round(damage));
			player.lastPlayerToHit = explosion.playerThatShot;
			if (explosion.playerThatShot == player) player.lastPlayerToHit = null;
		} else {
			return;
		}
		
		var angleBetween:Float = FlxAngle.angleBetween(player, explosion, true);
		player.acceleration.x = FlxVelocity.velocityFromAngle(angleBetween, 10000).x * -1;
		player.acceleration.y = FlxVelocity.velocityFromAngle(angleBetween, 10000).y * -1;
		
		if (player.killed)
		{
			Stats.getKill(Player.STICKY);
		}
	}
	
	private function bulletVSCrate(b1:FlxBasic, b2:FlxBasic):Void
	{
		var bullet:Bullet = _bulletGroup.members[0];
		for (i in 0..._bulletGroup.members.length) if (b1 == _bulletGroup.members[i].model) bullet = _bulletGroup.members[i];
		
		if (bullet.noHit) return;
		
		var crate:FlxSprite = cast(b2, FlxSprite);
		
		if (bullet.sticky)
		{
			bullet.acceleration.set();
			bullet.velocity.set();
			return;
		}
		
		crate.hurt(bullet.damage);
		
		bullet.kill();
		
		FlxTween.color(crate, .25, 0xFF555555, 0xFFFFFFFF);
	}
	
	private function zombieVSExplosion(b1:FlxBasic, b2:FlxBasic):Void
	{
		var zombie:Zombie = cast(b1, Zombie);
		var explosion:Explosion = cast(b2, Explosion);
		
		if (explosion.noHit) return;
		
		if (zombie.killed) return;
		
		var centrePoint:FlxPoint = explosion.getMidpoint();
		
		zombie.hurt(100);
		
		var angleBetween:Float = FlxAngle.angleBetween(zombie, explosion, true);
		zombie.velocity.x = FlxVelocity.velocityFromAngle(angleBetween, 1000).x * -1;
		zombie.velocity.y = FlxVelocity.velocityFromAngle(angleBetween, 1000).y * -1;
	}
	
	private function playerVSPowerup(b1:FlxBasic, b2:FlxBasic):Void
	{
		var player:Player = cast(b1, Player);
		var powerup:Powerup = cast(b2, Powerup);
		
		player.powerup(powerup);
		powerup.kill();
	}
	
	private function explosionVSCrate(b1:FlxBasic, b2:FlxBasic):Void
	{
		if (cast(b1, Explosion).noHit) return;
		
		cast(b2, Crate).kill();
	}
	
	private function endRound():Void
	{
		for (i in 0..._playerGroup.members.length)
		{
			if (GameRules.gameType == GameRules.SURVIVAL && !_playerGroup.members[i].killed) _playerGroup.members[i].pointsToAdd++;
		}
		
		for (i in 0..._bulletGroup.members.length)
		{
			_bulletGroup.members[i].kill();
		}
		
		/*var tie:Bool = true;
		for (i in 0..._playerGroup.members.length) if (_playerGroup.members[i].alive) tie = false;
		
		if (tie) for (i in 0..._playerGroup.members.length) _playerGroup.members[i].pointsToAdd = 0;*/
		
		openSubState(new ScoreboardSubState(_playerGroup.members));
		
		for (i in 0..._zombieGroup.members.length)
		{
			_zombieGroup.members[i].stopChasing();
			
			for (j in 0..._playerGroup.members.length)
			{
				if (FlxMath.distanceToPoint(_zombieGroup.members[i], _playerGroup.members[j].spawnPoint) < Reg.ZOMBIE_GROUP_SPACING && !_zombieGroup.members[i].killed)
				{
					_zombieGroup.members[i].timerKill();
					_zombieGroup.members[i].needToDrop = false;
				}
			}
		}
		
		Stats.roundsPlayed++;
		FlxG.timeScale = 1;
	}
	
	private function makeTombstone(player:Player):Void
	{
		if (!player.needToRevive)
		{
			if (player.lastPlayerToHit != null) Reg.debugBox.text += "Player " + player.playerNum + " was killed by Player " + player.lastPlayerToHit.playerNum + "\n";
			if (player.lastPlayerToHit == null) Reg.debugBox.text += "Player " + player.playerNum + " killed themself\n";
			if (GameRules.gameType == GameRules.SLAYER)
			{
				if (player.lastPlayerToHit != null) player.lastPlayerToHit.pointsToAdd++;
				if (player.lastPlayerToHit == null) player.pointsToAdd = -1;
			}
		}
		
		var t:FlxSprite = new FlxSprite();
		t.frames = FlxAtlasFrames.fromTexturePackerJson("img/Tombstone.png", "img/Tombstone.json");
		if (Reg.isSnowing) t.animation.addByPrefix("default", "tombstone_snow", 60, false) else t.animation.addByPrefix("default", "tombStone_dirt", 60, false);
		t.animation.play("default");
		t.x = player.x;
		t.y = player.y - t.height / 2;
		_tombStoneGroup.add(t);
		_container.add(t);
		
		var s:FlxSprite = new FlxSprite();
		s.frames = FlxAtlasFrames.fromTexturePackerJson("img/skull.png", "img/skull.json");
		s.animation.addByPrefix("default", "skull_" + player.modelNumber + "_", 30, false);
		s.animation.play("default");
		s.x = t.x + t.width / 2 - s.width / 2;
		s.y = player.y - s.height / 2;
		add(s);
		
		FlxTween.tween(s, { y: s.y - 100 } );
		
		new FlxTimer().start(30, function c(tu:FlxTimer):Void { t.kill(); s.kill(); }, 1);
	}
	
	private function makeDamageText(xpos:Float, ypos:Float, text:String):Void
	{
		var t:FlxText = new FlxText(0, 0, 50, text, 10);
		t.font = "impact";
		t.x = xpos - t.width / 2;
		t.y = ypos - t.height / 2;
		t.color = 0xFFFF0000;
		t.alpha = 0;
		add(t);
		
		FlxTween.tween(t, { y: t.y - 20, alpha: 1 }, .25 );
		new FlxTimer().start(1, function c(ti:FlxTimer):Void { t.kill(); }, 1);
	}
	
}