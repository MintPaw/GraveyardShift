package game;
import flixel.addons.effects.FlxTrail;
import flixel.animation.FlxAnimation;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxRandom;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.loaders.TexturePackerData;
import game.Powerup;
import input.InputLayout;
import input.InputManager;
import openfl.Assets;

/**
 * ...
 * @author MintPaw
 */
class Player extends FlxSprite
{
	public static inline var BLASTER:String = "blaster";
	public static inline var SMG:String = "SMG";
	public static inline var SHOTGUN:String = "shotgun";
	public static inline var LASER:String = "laser";
	public static inline var STICKY:String = "sticky";
	
	public static inline var BLASTER_STANDING_RIGHT:String		= "blaster_right_standing";
	public static inline var BLASTER_STANDING_UP:String			= "blaster_up_standing";
	public static inline var BLASTER_STANDING_DOWN:String 		= "blaster_down_standing";
	public static inline var BLASTER_RUNNING_RIGHT:String 		= "blaster_right_running";
	public static inline var BLASTER_RUNNING_UP:String 			= "blaster_up_running";
	public static inline var BLASTER_RUNNING_DOWN:String 		= "blaster_down_running";
	public static inline var BLASTER_RUNNING_UP_RIGHT:String 	= "blaster_upRight_running";
	public static inline var BLASTER_RUNNING_DOWN_RIGHT:String 	= "blaster_downRight_running";
	
	public static inline var SMG_STANDING_RIGHT:String			= "SMG_right_standing";
	public static inline var SMG_STANDING_UP:String 			= "SMG_up_standing";
	public static inline var SMG_STANDING_DOWN:String 			= "SMG_down_standing";
	public static inline var SMG_RUNNING_RIGHT:String 			= "SMG_right_running";
	public static inline var SMG_RUNNING_UP:String 				= "SMG_up_running";
	public static inline var SMG_RUNNING_DOWN:String 			= "SMG_down_running";
	public static inline var SMG_RUNNING_UP_RIGHT:String		= "SMG_upRight_running";
	public static inline var SMG_RUNNING_DOWN_RIGHT:String		= "SMG_downRight_running";
	
	public static inline var SHOTGUN_STANDING_RIGHT:String 		= "shotgun_right_standing";
	public static inline var SHOTGUN_STANDING_UP:String 		= "shotgun_up_standing";
	public static inline var SHOTGUN_STANDING_DOWN:String 		= "shotgun_down_standing";
	public static inline var SHOTGUN_RUNNING_RIGHT:String 		= "shotgun_right_running";
	public static inline var SHOTGUN_RUNNING_UP:String 			= "shotgun_up_running";
	public static inline var SHOTGUN_RUNNING_DOWN:String 		= "shotgun_down_running";
	public static inline var SHOTGUN_RUNNING_UP_RIGHT:String 	= "shotgun_upRight_running";
	public static inline var SHOTGUN_RUNNING_DOWN_RIGHT:String 	= "shotgun_downRight_running";
	
	public static inline var LASER_STANDING_RIGHT:String			= "laser_right_standing";
	public static inline var LASER_STANDING_UP:String 				= "laser_up_standing";
	public static inline var LASER_STANDING_DOWN:String 			= "laser_down_standing";
	public static inline var LASER_RUNNING_RIGHT:String 			= "laser_right_running";
	public static inline var LASER_RUNNING_UP:String 				= "laser_up_running";
	public static inline var LASER_RUNNING_DOWN:String 				= "laser_down_running";
	public static inline var LASER_RUNNING_UP_RIGHT:String			= "laser_upRight_running";
	public static inline var LASER_RUNNING_DOWN_RIGHT:String		= "laser_downRight_running";
	
	public static inline var STICKY_STANDING_RIGHT:String				= "sticky_right_standing";
	public static inline var STICKY_STANDING_UP:String 					= "sticky_up_standing";
	public static inline var STICKY_STANDING_DOWN:String 				= "sticky_down_standing";
	public static inline var STICKY_RUNNING_RIGHT:String 				= "sticky_right_running";
	public static inline var STICKY_RUNNING_UP:String 					= "sticky_up_running";
	public static inline var STICKY_RUNNING_DOWN:String 				= "sticky_down_running";
	public static inline var STICKY_RUNNING_UP_RIGHT:String				= "sticky_upRight_running";
	public static inline var STICKY_RUNNING_DOWN_RIGHT:String			= "sticky_downRight_running";
	
	public static inline var LEFT:String = "left";
	public static inline var RIGHT:String = "right";
	public static inline var UP:String = "up";
	public static inline var DOWN:String = "down";
	public static inline var UP_LEFT:String = "upLeft";
	public static inline var UP_RIGHT:String = "upRight";
	public static inline var DOWN_LEFT:String = "downLeft";
	public static inline var DOWN_RIGHT:String = "downRight";
	
	public static var WEAPON_STRINGS:Array<String> = [BLASTER, SMG, SHOTGUN, LASER, STICKY];
	
	public static var weaponDelays:Array<Float> = [.36, .1, 1, .25, 0];
	public static var bulletSpeeds:Array<Int> = [600, 600, 600, 600, 600];
	public static var bulletDamage:Array<Int> = [30, 15, 22, 50, 300];
	public static var bulletWaver:Array<Int> = [0, 50, 300, 0, 0];
	public static var gunAmmos:Array<Int> = [-1, 30, 10, 8, 5];
	public static var knockBacks:Array<Int> = [0, 3, 10, 2, 2];
	
	private var _prevLeftTigger:Float = 0;
	private var _prevRightTigger:Float = 0;
	private var _flashOffset:FlxPoint = new FlxPoint();
	private var _currentDeviceID:Int;
	private var _graphicHeight:Float;
	private var _shootDelay:Float = 0;
	private var _dashDelay:Float = 0;
	private var _guiSetup:Bool = false;
	
	private var _up:Bool = false;
	private var _down:Bool = false;
	private var _left:Bool = false;
	private var _right:Bool = false;
	private var _fire:Bool = false;
	private var _dash:Bool = false;
	private var _item:Bool = false;
	
	private var _lastExplosionHitBy:Explosion;
	private var _dashRecoveryTime:Float;
	private var _defaultMaxVelo:Int = 230;
	private var _beastMaxVelo:Int = 460;
	
	private var _beastTimer:FlxTimer = new FlxTimer();
	
	public var playerNum:Int;
	public var lastBullet:Bullet;
	public var modelNumber:Int;
	
	public var controller:FlxGamepad;
	
	public var spawnPoint:FlxPoint;
	public var keybinding:InputLayout;
	
	public var currentWeapon:String;
	public var currentWeaponID:Int;
	public var directionFacing:String;
	public var directionFacing4:String;
	
	public var muzzleFlash:FlxSprite;
	public var storedPowerup:Powerup;
	public var needToUpdatePowerup:Bool = false;
	public var needsDropFlare:Bool = false;
	public var needsLostAttraction:Bool = false;
	public var needsToSpawnZombies:Bool = false;
	public var needToRevive:Bool = false;
	public var needPowerupEffect:Bool = false;
	public var needToMakeTombstone:Bool = false;
	
	public var needsToShoot:Bool = false;
	public var shotOffset:FlxPoint = new FlxPoint();
	
	public var score:Int = 0;
	public var pointsToAdd:Int = 0;
	public var ammo:Int = 0;
	
	public var hasShield:Bool = false;
	public var isBeast:Bool = false;
	
	public var hitBox:HitBox;
	public var healthBar:FlxBar;
	public var arrow:FlxSpriteGroup;
	public var circle:FlxSprite;
	public var shield:FlxSprite;
	public var halo:FlxSprite;
	public var trail:FlxTrail;
	public var lastPlayerToHit:Player;	
	
	public var killed:Bool = false;

	public function new(model:Int, keybinding:InputLayout, currentDeviceID:Int, playerNum:Int) 
	{
		super(0, 0);
		
		modelNumber = model;
		this.playerNum = playerNum;
		this.keybinding = keybinding;
		this._currentDeviceID = currentDeviceID;
		
		changeWeapon(WEAPON_STRINGS[GameRules.startingWeapon]);
		setValues();
		
		maxVelocity.set(_defaultMaxVelo * GameRules.getPlayerSpeed(), _defaultMaxVelo * GameRules.getPlayerSpeed());
		drag.set(maxVelocity.x * 8, maxVelocity.y * 8);
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		setupAnimations(); //---------------
		
		muzzleFlash = new FlxSprite();
		muzzleFlash.loadGraphicFromTexture(new TexturePackerData("img/players/Muzzle Flashes.json", "img/players/Muzzle Flashes.png"));
		muzzleFlash.animation.addByPrefix(BLASTER, "muzzleFlash_blaster", 30, false);
		muzzleFlash.animation.addByPrefix(SMG, "muzzleFlash_SMG", 30, false);
		muzzleFlash.animation.addByPrefix(SHOTGUN, "muzzleFlash_shotgun", 30, false);
		muzzleFlash.animation.addByPrefix(LASER, "muzzleFlash_laser", 30, false);
		muzzleFlash.animation.addByPrefix(STICKY, "muzzleFlash_sticky", 30, false);
		muzzleFlash.setFacingFlip(FlxObject.LEFT, true, false);
		muzzleFlash.setFacingFlip(FlxObject.RIGHT, false, false);
		
		hitBox = new HitBox(0, 0);
		hitBox.assocPlayer = this;
		hitBox.makeGraphic(50, 70, 0);
		
		healthBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 50, 5, this, "health", 0, health, true);
		healthBar.createFilledBar(0x00000000, 0xFF00FF00, true, 0xFF000000);
		healthBar.allowCollisions = FlxObject.NONE;
		healthBar.visible = false;
		
		shield = new FlxSprite();
		shield.loadGraphicFromTexture(new TexturePackerData("img/powerups/Shield.json", "img/powerups/Shield.png"));
		shield.animation.addByPrefix("activate", "shieldActivate_", 30, false);
		shield.animation.addByPrefix("shield", "shield_");
		shield.animation.addByPrefix("destroy", "shieldDestroy_", 30, false);
		shield.visible = false;
		
		halo = new FlxSprite(0, 0, "img/players/halo.png");
		halo.visible = false;
		tweenHalo(null);
		
		trail = new FlxTrail(this, "img/items.png");
		trail.visible = false;
		for (i in 0...trail.members.length) trail.members[i].alpha = 0;
		
		_dashRecoveryTime = GameRules.getDashRecovery();
		
		offset.y = height - 20;
		height = 20;
		
		origin.y += height;
		
		setupContoller();
		
		#if ouya
		for (i in animation._animations) cast(i, FlxAnimation)._frames.reverse();
		#end
		
		if (Reg.isSnowing) muzzleFlash.color = 0xFF555555;
	}
	
	public function setValues():Void
	{
		health = 100;
		alpha = 1;
		
		lastPlayerToHit = null;
		
		directionFacing = RIGHT;
		directionFacing4 = RIGHT;
		
		if (GameRules.startingPowerup >= 0)
		{
			var p:Powerup = new Powerup();
			p.type = GameRules.startingPowerup;
			powerup(p);
		}
		
		if (hitBox != null) hitBox.revive();
		
		arrow = new FlxSpriteGroup();
		arrow.centerOrigin();
		
		var a:FlxSprite = new FlxSprite(0, 0, "img/gui/playerTriangle" + modelNumber + ".png");
		a.centerOrigin();
		a.x = a.y = 0;
		arrow.add(a);
		
		var t:FlxSprite = new FlxSprite(0, 0, "img/gui/p" + Std.string(playerNum + 1) + "Letters.png");
		t.centerOrigin();
		if (Reg.isSnowing) t.color = 0xFF000000;
		t.x = 0;
		t.y = a.y - t.height - 5;
		arrow.add(t);
		
		circle = new FlxSprite(0, 0, "img/gui/playerCircle" + modelNumber + ".png");
		circle.centerOrigin();
		
		killed = false;
		_guiSetup = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		setupSelfGui();
		updateInput();
		updateMovement();
		updateAnimation();
		updateShooting();
		updateHealthBar();
		updateShield();
	}
	
	private function setupSelfGui():Void
	{
		if (_guiSetup) return;
		_guiSetup = true;
		
		arrow.x = x + width / 2 - 2;
		arrow.y = y - _graphicHeight - arrow.height + 30;
		
		circle.x = x + 10;
		circle.y = y - 10;
		
		FlxTween.tween(arrow, { y: arrow.y - 14 }, .5, { type: FlxTween.PINGPONG } );
		FlxTween.tween(arrow, { alpha: 0 }, 1, { startDelay: 2 } );
		FlxTween.tween(circle, { alpha: 0 }, 1, { startDelay: 2 } );
	}
	
	private function updateInput():Void
	{
		acceleration.set();
		
		if (!keybinding.isController)
		{
			
			_left = FlxG.keys.checkStatus(keybinding.moveLeft, FlxInputState.PRESSED);
			_right = FlxG.keys.checkStatus(keybinding.moveRight, FlxInputState.PRESSED);
			_up = FlxG.keys.checkStatus(keybinding.moveUp, FlxInputState.PRESSED);
			_down = FlxG.keys.checkStatus(keybinding.moveDown, FlxInputState.PRESSED);
			
			_fire = FlxG.keys.checkStatus(keybinding.shoot, FlxInputState.PRESSED);
			_dash = FlxG.keys.checkStatus(keybinding.dash, FlxInputState.PRESSED);
			_item = FlxG.keys.checkStatus(keybinding.item, FlxInputState.PRESSED);
			if (FlxG.keys.checkStatus(keybinding.shoot, FlxInputState.JUST_PRESSED)) firePressed();
			if (FlxG.keys.checkStatus(keybinding.dash, FlxInputState.JUST_PRESSED)) dashPressed();
			if (FlxG.keys.checkStatus(keybinding.item, FlxInputState.JUST_PRESSED)) itemPressed();
		} else {
			if (controller == null || !controller.connected)
			{
				setupContoller();
				return;
			}
			
			#if pc
			_left = controller.getXAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || controller.getXAxis(InputLayout.RIGHT_ANALOGUE) < -InputManager.deadZone || controller.pressed(InputLayout.DPAD_LEFT);
			_right = controller.getXAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || controller.getXAxis(InputLayout.RIGHT_ANALOGUE) > InputManager.deadZone || controller.pressed(InputLayout.DPAD_RIGHT);
			_up = controller.getYAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || controller.getYAxis(InputLayout.RIGHT_ANALOGUE) < -InputManager.deadZone || controller.pressed(InputLayout.DPAD_UP);
			_down = controller.getYAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || controller.getYAxis(InputLayout.RIGHT_ANALOGUE) > InputManager.deadZone || controller.pressed(InputLayout.DPAD_DOWN);
			#end
			
			#if ouya
			_left = controller.getXAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || controller.getXAxis(InputLayout.RIGHT_ANALOGUE) < -InputManager.deadZone;
			_right = controller.getXAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || controller.getXAxis(InputLayout.RIGHT_ANALOGUE) > InputManager.deadZone;
			_up = controller.getYAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone || controller.getYAxis(InputLayout.RIGHT_ANALOGUE) < -InputManager.deadZone;
			_down = controller.getYAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone || controller.getYAxis(InputLayout.RIGHT_ANALOGUE) > InputManager.deadZone;
			#end
			
			#if fire
			_left = controller.getAxis(0) < -InputManager.deadZone;
			_right = controller.getAxis(0) > InputManager.deadZone;
			_up = controller.getAxis(1) < -InputManager.deadZone;
			_down = controller.getAxis(1) > InputManager.deadZone;
			
			_dash = controller.pressed(InputLayout.LEFT_BUMPER);
			_fire = controller.pressed(InputLayout.RIGHT_BUMPER);
			if (controller.justPressed(InputLayout.LEFT_BUMPER)) dashPressed();
			if (controller.justPressed(InputLayout.RIGHT_BUMPER)) firePressed();
			#end
			
			#if !fire
			_dash = controller.getAxis(InputLayout.LEFT_TRIGGER) > InputManager.deadZone || controller.pressed(InputLayout.LEFT_BUMPER);
			_fire = controller.getAxis(InputLayout.RIGHT_TRIGGER) > InputManager.deadZone || controller.pressed(InputLayout.RIGHT_BUMPER);
			if ((_prevLeftTigger < InputManager.deadZone && controller.getAxis(InputLayout.LEFT_TRIGGER) > InputManager.deadZone) || controller.justPressed(InputLayout.LEFT_BUMPER)) dashPressed();
			if ((_prevRightTigger < InputManager.deadZone && controller.getAxis(InputLayout.RIGHT_TRIGGER) > InputManager.deadZone) || controller.justPressed(InputLayout.RIGHT_BUMPER)) firePressed();
			
			_prevLeftTigger = controller.getAxis(InputLayout.LEFT_TRIGGER);
			_prevRightTigger = controller.getAxis(InputLayout.RIGHT_TRIGGER);
			#end
			
			_item = controller.pressed(InputLayout.X);
			if (controller.justPressed(InputLayout.X)) itemPressed();
		}
	}
	
	private function updateMovement():Void
	{
		if (_up) directionFacing4 = UP
		else if (_down) directionFacing4 = DOWN
		else if (_left) directionFacing4 = LEFT
		else if (_right) directionFacing4 = RIGHT;
		
		if (_up && _left) directionFacing = UP_LEFT
		else if (_up && _right) directionFacing = UP_RIGHT
		else if (_down && _left) directionFacing = DOWN_LEFT
		else if (_down && _right) directionFacing = DOWN_RIGHT
		else if (_up) directionFacing = UP
		else if (_down) directionFacing = DOWN
		else if (_left) directionFacing = LEFT
		else if (_right) directionFacing = RIGHT
		else directionFacing = directionFacing4;
		
		if (_up && _left) acceleration.set(-Reg.PLAYER_MOVEMENT_ACCELERATION, -Reg.PLAYER_MOVEMENT_ACCELERATION)
		else if (_up && _right) acceleration.set(Reg.PLAYER_MOVEMENT_ACCELERATION, -Reg.PLAYER_MOVEMENT_ACCELERATION)
		else if (_down && _left) acceleration.set(-Reg.PLAYER_MOVEMENT_ACCELERATION, Reg.PLAYER_MOVEMENT_ACCELERATION)
		else if (_down && _right) acceleration.set(Reg.PLAYER_MOVEMENT_ACCELERATION, Reg.PLAYER_MOVEMENT_ACCELERATION)
		else if (_up) acceleration.set(0, -Reg.PLAYER_MOVEMENT_ACCELERATION)
		else if (_down) acceleration.set(0, Reg.PLAYER_MOVEMENT_ACCELERATION)
		else if (_left) acceleration.set(-Reg.PLAYER_MOVEMENT_ACCELERATION, 0)
		else if (_right) acceleration.set(Reg.PLAYER_MOVEMENT_ACCELERATION, 0);
		
		hitBox.x = x;
		hitBox.y = y - 50;
		
		_dashDelay -= FlxG.elapsed;
	}
	
	private function updateAnimation():Void
	{
		//if (trail.visible) trail.changeGraphic(getFlxFrameBitmapData());
		
		var animName = "";
		
		if (directionFacing == LEFT || directionFacing == DOWN_LEFT || directionFacing == UP_LEFT)
		{
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
		}
		
		var thisDirectionFacing:String = directionFacing;
		if (thisDirectionFacing == LEFT) thisDirectionFacing = RIGHT
		else if (thisDirectionFacing == UP_LEFT) thisDirectionFacing = UP_RIGHT
		else if (thisDirectionFacing == DOWN_LEFT) thisDirectionFacing = DOWN_RIGHT;
		
		var thisDirectionFacing4:String = directionFacing4;
		if (thisDirectionFacing4 == LEFT) thisDirectionFacing4 = RIGHT;
		
		if (currentWeapon == BLASTER) animName += "blaster_"
		else if (currentWeapon == SMG) animName += "SMG_"
		else if (currentWeapon == SHOTGUN) animName += "shotgun_"
		else if (currentWeapon == LASER) animName += "laser_"
		else if (currentWeapon == STICKY) animName += "sticky_";
		
		if (_left || _right || _up || _down)
		{
			animName += thisDirectionFacing + "_";
			animName += "running";
		} else {
			animName += thisDirectionFacing4 + "_";
			animName += "standing";
		}
		
		animation.play(animName);
	}
	
	private function updateShooting():Void
	{
		if (_shootDelay > 0) 
		{
			_shootDelay -= FlxG.elapsed;
			if (isBeast) _shootDelay -= FlxG.elapsed;
		}
		
		if (_fire && currentWeapon == SMG) firePressed();
		
		if (directionFacing == LEFT) muzzleFlash.angle = 0;
		if (directionFacing == RIGHT) muzzleFlash.angle = 0;
		if (directionFacing == UP) muzzleFlash.angle = -90;
		if (directionFacing == DOWN) muzzleFlash.angle = 90;
		if (directionFacing == UP_LEFT || directionFacing == DOWN_RIGHT) muzzleFlash.angle = 45;
		if (directionFacing == UP_RIGHT || directionFacing == DOWN_LEFT) muzzleFlash.angle = -45;
		
		if (currentWeapon == BLASTER)
		{
			if (directionFacing == LEFT)
			{
				shotOffset.set( -3, -31);
				_flashOffset.set(-12, -6);
			}
			if (directionFacing == RIGHT)
			{
				shotOffset.set(53, -33);
				_flashOffset.set(13, -5);
			}
			if (directionFacing == UP)
			{
				shotOffset.set(25, -47);
				_flashOffset.set(-8, -12);
			}
			if (directionFacing == DOWN)
			{
				shotOffset.set(24, 15);
				_flashOffset.set(-9, -5);
			}
			if (directionFacing == UP_LEFT)
			{
				shotOffset.set(8, -45);
				_flashOffset.set(-15, -10);
			}
			if (directionFacing == UP_RIGHT)
			{
				shotOffset.set(50, -47);
				_flashOffset.set(-4, -7);
			}
			if (directionFacing == DOWN_LEFT)
			{
				shotOffset.set(0, -10);
				_flashOffset.set(-10, 0);
			}
			if (directionFacing == DOWN_RIGHT)
			{
				shotOffset.set(60, -16);
				_flashOffset.set(-1, 9);
			}
		}
		
		if (currentWeapon == SMG)
		{
			if (directionFacing == LEFT)
			{
				shotOffset.set( -2, -23);
				_flashOffset.set(-9, -10);
			}
			if (directionFacing == RIGHT)
			{
				shotOffset.set(47, -23);
				_flashOffset.set(0, -10);
			}
			if (directionFacing == UP)
			{
				shotOffset.set(20, -50);
				_flashOffset.set(-8, -12);
			}
			if (directionFacing == DOWN)
			{
				shotOffset.set(18, 10);
				_flashOffset.set(-6, -7);
			}
			if (directionFacing == UP_LEFT)
			{
				shotOffset.set(8, -45);
				_flashOffset.set(-7, -12);
			}
			if (directionFacing == UP_RIGHT)
			{
				shotOffset.set(45, -45);
				_flashOffset.set(-4, -11);
			}
			if (directionFacing == DOWN_LEFT)
			{
				shotOffset.set(3, 3);
				_flashOffset.set(-3, -8);
			}
			if (directionFacing == DOWN_RIGHT)
			{
				shotOffset.set(50, 5);
				_flashOffset.set(-5, -9);
			}
		}
		
		if (currentWeapon == SHOTGUN)
		{
			if (directionFacing == LEFT)
			{
				shotOffset.set( -2, -23);
				_flashOffset.set( -15, -15);
			}
			if (directionFacing == RIGHT)
			{
				shotOffset.set(47, -23);
				_flashOffset.set(17, -15);
			}
			if (directionFacing == UP)
			{
				shotOffset.set(27, -50);
				_flashOffset.set(-10, -12);
			}
			if (directionFacing == DOWN)
			{
				shotOffset.set(18, 10);
				_flashOffset.set(0, -7);
			}
			if (directionFacing == UP_LEFT)
			{
				shotOffset.set(8, -45);
				_flashOffset.set(-10, -20);
			}
			if (directionFacing == UP_RIGHT)
			{
				shotOffset.set(45, -45);
				_flashOffset.set(-5, -18);
			}
			if (directionFacing == DOWN_LEFT)
			{
				shotOffset.set(3, 3);
				_flashOffset.set(-18, -5);
			}
			if (directionFacing == DOWN_RIGHT)
			{
				shotOffset.set(50, 5);
				_flashOffset.set(0, -15);
			}
		}
		
		if (currentWeapon == LASER)
		{
			if (directionFacing == LEFT)
			{
				shotOffset.set( -2, -23);
				_flashOffset.set( -18, -14);
			}
			if (directionFacing == RIGHT)
			{
				shotOffset.set(60, -20);
				_flashOffset.set(10, -15);
			}
			if (directionFacing == UP)
			{
				shotOffset.set(27, -50);
				_flashOffset.set(-10, -12);
			}
			if (directionFacing == DOWN)
			{
				shotOffset.set(18, 10);
				_flashOffset.set(2, -3);
			}
			if (directionFacing == UP_LEFT)
			{
				shotOffset.set(8, -40);
				_flashOffset.set(-18, -28);
			}
			if (directionFacing == UP_RIGHT)
			{
				shotOffset.set(45, -40);
				_flashOffset.set(0, -23);
			}
			if (directionFacing == DOWN_LEFT)
			{
				shotOffset.set(3, 3);
				_flashOffset.set(-18, 1);
			}
			if (directionFacing == DOWN_RIGHT)
			{
				shotOffset.set(50, 5);
				_flashOffset.set(4, -11);
			}
		}
		
		if (currentWeapon == STICKY)
		{
			if (directionFacing == LEFT)
			{
				shotOffset.set( 10, -23);
				_flashOffset.set( 0, -14);
			}
			if (directionFacing == RIGHT)
			{
				shotOffset.set(20, -20);
				_flashOffset.set(2, -17);
			}
			if (directionFacing == UP)
			{
				shotOffset.set(27, -30);
				_flashOffset.set(-8, -10);
			}
			if (directionFacing == DOWN)
			{
				shotOffset.set(18, 10);
				_flashOffset.set(-3, 0);
			}
			if (directionFacing == UP_LEFT)
			{
				shotOffset.set(14, -35);
				_flashOffset.set(-18, -28);
			}
			if (directionFacing == UP_RIGHT)
			{
				shotOffset.set(40, -35);
				_flashOffset.set(0, -23);
			}
			if (directionFacing == DOWN_LEFT)
			{
				shotOffset.set(3, 3);
				_flashOffset.set(-18, 1);
			}
			if (directionFacing == DOWN_RIGHT)
			{
				shotOffset.set(40, -5);
				_flashOffset.set(4, -11);
			}
		}
		
		muzzleFlash.x = x + shotOffset.x + _flashOffset.x;
		muzzleFlash.y = y + shotOffset.y + _flashOffset.y;
		muzzleFlash.facing = facing;
		//muzzleFlash.visible = !muzzleFlash.animation.finished;
		muzzleFlash.visible = false;
	}
	
	private function updateHealthBar():Void
	{
		healthBar.x = x - (healthBar.width - width) / 2;
		healthBar.y = y - _graphicHeight;
		
		healthBar.visible = health < 100 && health > 0;
	}
	
	private function firePressed():Void
	{
		if (_shootDelay > 0) return;
		
		_shootDelay = weaponDelays[gunToIndex(currentWeapon)];
		needsToShoot = true;
		muzzleFlash.animation.play(currentWeapon, true);
		
		if (alpha < 1) FlxTween.tween(this, { alpha: 2 }, .5);
	}
	
	private function dashPressed():Void
	{
		if (_dashDelay > 0) return;
		
		Stats.dashes++;
		
		var dashSpeed:Int = 1500;
		var velo:FlxPoint = new FlxPoint();
		
		if (directionFacing == Player.LEFT) velo.set( -dashSpeed, 0);
		if (directionFacing == Player.RIGHT) velo.set(dashSpeed,  0);
		if (directionFacing == Player.UP) velo.set(0, -dashSpeed);
		if (directionFacing == Player.DOWN) velo.set(0, dashSpeed);
		if (directionFacing == Player.UP_LEFT) velo.set( -dashSpeed, -dashSpeed);
		if (directionFacing == Player.UP_RIGHT) velo.set( dashSpeed, -dashSpeed);
		if (directionFacing == Player.DOWN_LEFT) velo.set( -dashSpeed, dashSpeed);
		if (directionFacing == Player.DOWN_RIGHT) velo.set( dashSpeed, dashSpeed);
		
		trail.visible = true;
		trail.changeGraphic(getFlxFrameBitmapData());
		
		FlxTween.tween(velocity, { x: velo.x, y: velo.y }, .3);
		FlxTween.tween(velocity, { x: 0, y: 0 }, .3, { startDelay: .3 } );
		
		if (!isBeast)
		{
			for (i in 0...trail.members.length)
			{
				FlxTween.tween(trail.members[i], { alpha: 1 - i * .1 }, .3);
				FlxTween.tween(trail.members[i], { alpha: 0 }, .3 , { startDelay: .3, complete: function c(t:FlxTween):Void { trail.visible = false; } } );
			}
		}
		
		_dashDelay = _dashRecoveryTime;
	}
	
	private function itemPressed():Void
	{
		if (storedPowerup == null) return;
		
		needPowerupEffect = true;
		
		Stats.powerupsUsed++;
		
		if (storedPowerup.type == Powerup.SHIELD && !hasShield) turnOnShield();
		if (storedPowerup.type == Powerup.BEAST && !isBeast) turnOnBeast();
		if (storedPowerup.type == Powerup.FLARE) needsDropFlare = true;
		if (storedPowerup.type == Powerup.LOSE_ATTRACTION && alpha == 1) needsLostAttraction = true;
		if (storedPowerup.type == Powerup.FLASH) FlxG.camera.flash(FlxColor.WHITE, 10, null, true);
		if (storedPowerup.type == Powerup.SPAWN) needsToSpawnZombies = true;
		if (storedPowerup.type == Powerup.BURST)
		{
			needToRevive = true;
			halo.visible = true;
		}
		
		storedPowerup = null;
		needToUpdatePowerup = true;
	}
	
	public function setupContoller():Void
	{
		controller = FlxG.gamepads.getByID(_currentDeviceID);
	}
	
	public static function gunToIndex(gun:String):Int
	{
		if (gun == BLASTER) return 0;
		if (gun == SMG) return 1;
		if (gun == SHOTGUN) return 2;
		if (gun == LASER) return 3;
		if (gun == STICKY) return 4;
		
		return 0;
	}
	
	override public function kill():Void 
	{
		hitBox.kill();
		killed = true;
		healthBar.visible = false;
		
		if (needToRevive)
		{
			var rTimer:FlxTimer = new FlxTimer();
			rTimer.start(5, reviveSelf);
			super.kill();
			return;
		}
		
		Stats.playerKills++;
		
		changeWeapon(WEAPON_STRINGS[GameRules.startingWeapon]);
		
		super.kill();
		
		FlxTween.tween(this, { alpha: 0 }, .25, { complete: killReal });
	}
	
	private function reviveSelf(timer:FlxTimer):Void
	{
		if (!killed) return;
		killed = false;
		needToRevive = false;
		halo.visible = false;
		hitBox.revive();
		health = 20;
		revive();
	}
	
	private function killReal(tween:FlxTween):Void { super.kill(); }
	
	public function hitExplosion(hitFor:Float, explosion:Explosion):Bool
	{
		if (_lastExplosionHitBy != null && _lastExplosionHitBy == explosion) return false;
		
		FlxG.log.add(hitFor);
		_lastExplosionHitBy = explosion;
		hurt(hitFor);
		
		return true;
	}
	
	override public function hurt(Damage:Float):Void 
	{
		var mayKill:Bool = false;
		
		if (hasShield)
		{
			removeShield();
			return;
		}
		
		if (health > 0) mayKill = true;
		
		FlxTween.color(this, .25, 0xFFFF0000, 0xFFFFFFFF);
		super.hurt(Damage);
		
		if (!alive && mayKill) needToMakeTombstone = true;
	}
	
	override public function getMidpoint(?point:FlxPoint):FlxPoint 
	{
		return new FlxPoint(x + width / 2, y - _graphicHeight / 2 + _graphicHeight * .2);
	}
	
	public function powerup(p:Powerup):Void
	{
		if (p.type == Powerup.BLASTER) changeWeapon(BLASTER)
		else if (p.type == Powerup.SMG) changeWeapon(SMG)
		else if (p.type == Powerup.SHOTGUN) changeWeapon(SHOTGUN)
		else if (p.type == Powerup.LASER) changeWeapon(LASER)
		else if (p.type == Powerup.STICKY) changeWeapon(STICKY)
		else storedPowerup = p;
		
		needToUpdatePowerup = true;
	}
	
	public function changeWeapon(w:String):Void
	{
		currentWeapon = w;
		currentWeaponID = gunToIndex(w);
		ammo = gunAmmos[currentWeaponID];
	}
	
	private function setupAnimations():Void
	{
		var animPrefix:String = "";
		if (modelNumber == 0)
		{
			loadGraphicFromTexture(new TexturePackerData("img/players/Blue Player.json", "img/players/Blue Player.png"));
			animPrefix = "player_blue_";
		} else if (modelNumber == 1) {
			loadGraphicFromTexture(new TexturePackerData("img/players/Red Player.json", "img/players/Red Player.png"));
			animPrefix = "player_red_";
		} else if (modelNumber == 2) {
			loadGraphicFromTexture(new TexturePackerData("img/players/Green Player.json", "img/players/Green Player.png"));
			animPrefix = "player_green_";
		} else if (modelNumber == 3) {
			loadGraphicFromTexture(new TexturePackerData("img/players/Orange Player.json", "img/players/Orange Player.png"));
			animPrefix = "player_orange_";
		} else if (modelNumber == 4) {
			loadGraphicFromTexture(new TexturePackerData("img/players/Purple Player.json", "img/players/Purple Player.png"));
			animPrefix = "player_purple_";
		}
		
		_graphicHeight = height;
		
		animation.addByPrefix(BLASTER_STANDING_RIGHT, animPrefix + "blaster_right_standing", 30, true);
		animation.addByPrefix(SHOTGUN_STANDING_RIGHT, animPrefix + "shotgun_right_standing", 30, true);
		animation.addByPrefix(SMG_STANDING_RIGHT, animPrefix + "SMG_right_standing", 30, true);
		animation.addByPrefix(LASER_STANDING_RIGHT, animPrefix + "laser_right_standing", 30, true);
		animation.addByPrefix(STICKY_STANDING_RIGHT, animPrefix + "sticky_right_standing", 30, true);
		
		animation.addByPrefix(BLASTER_STANDING_UP, animPrefix + "blaster_up_standing", 30, true);
		animation.addByPrefix(SHOTGUN_STANDING_UP, animPrefix + "shotgun_up_standing", 30, true);
		animation.addByPrefix(SMG_STANDING_UP, animPrefix + "SMG_up_standing", 30, true);
		animation.addByPrefix(LASER_STANDING_UP, animPrefix + "laser_up_standing", 30, true);
		animation.addByPrefix(STICKY_STANDING_UP, animPrefix + "sticky_up_standing", 30, true);
		
		animation.addByPrefix(BLASTER_STANDING_DOWN, animPrefix + "blaster_down_standing", 30, true);
		animation.addByPrefix(SHOTGUN_STANDING_DOWN, animPrefix + "shotgun_down_standing", 30, true);
		animation.addByPrefix(SMG_STANDING_DOWN, animPrefix + "SMG_down_standing", 30, true);
		animation.addByPrefix(LASER_STANDING_DOWN, animPrefix + "laser_down_standing", 30, true);
		animation.addByPrefix(STICKY_STANDING_DOWN, animPrefix + "sticky_down_standing", 30, true);
		
		animation.addByPrefix(BLASTER_RUNNING_RIGHT, animPrefix + "blaster_right_running", 30, true);
		animation.addByPrefix(SHOTGUN_RUNNING_RIGHT, animPrefix + "shotgun_right_running", 30, true);
		animation.addByPrefix(SMG_RUNNING_RIGHT, animPrefix + "SMG_right_running", 30, true);
		animation.addByPrefix(LASER_RUNNING_RIGHT, animPrefix + "laser_right_running", 30, true);
		animation.addByPrefix(STICKY_RUNNING_RIGHT, animPrefix + "sticky_right_running", 30, true);
		
		animation.addByPrefix(BLASTER_RUNNING_UP, animPrefix + "blaster_up_running", 30, true);
		animation.addByPrefix(SHOTGUN_RUNNING_UP, animPrefix + "shotgun_up_running", 30, true);
		animation.addByPrefix(SMG_RUNNING_UP, animPrefix + "SMG_up_running", 30, true);
		animation.addByPrefix(LASER_RUNNING_UP, animPrefix + "laser_up_running", 30, true);
		animation.addByPrefix(STICKY_RUNNING_UP, animPrefix + "sticky_up_running", 30, true);
		
		animation.addByPrefix(BLASTER_RUNNING_DOWN, animPrefix + "blaster_down_running", 30, true);
		animation.addByPrefix(SHOTGUN_RUNNING_DOWN, animPrefix + "shotgun_down_running", 30, true);
		animation.addByPrefix(SMG_RUNNING_DOWN, animPrefix + "SMG_down_running", 30, true);
		animation.addByPrefix(LASER_RUNNING_DOWN, animPrefix + "laser_down_running", 30, true);
		animation.addByPrefix(STICKY_RUNNING_DOWN, animPrefix + "sticky_down_running", 30, true);
		
		animation.addByPrefix(BLASTER_RUNNING_DOWN_RIGHT, animPrefix + "blaster_downRight_running", 30, true);
		animation.addByPrefix(SHOTGUN_RUNNING_DOWN_RIGHT, animPrefix + "shotgun_downRight_running", 30, true);
		animation.addByPrefix(SMG_RUNNING_DOWN_RIGHT, animPrefix + "SMG_downRight_running", 30, true);
		animation.addByPrefix(LASER_RUNNING_DOWN_RIGHT, animPrefix + "laser_downRight_running", 30, true);
		animation.addByPrefix(STICKY_RUNNING_DOWN_RIGHT, animPrefix + "sticky_downRight_running", 30, true);
		
		animation.addByPrefix(BLASTER_RUNNING_UP_RIGHT, animPrefix + "blaster_upRight_running", 30, true);
		animation.addByPrefix(SHOTGUN_RUNNING_UP_RIGHT, animPrefix + "shotgun_upRight_running", 30, true);
		animation.addByPrefix(SMG_RUNNING_UP_RIGHT, animPrefix + "SMG_upRight_running", 30, true);
		animation.addByPrefix(LASER_RUNNING_UP_RIGHT, animPrefix + "laser_upRight_running", 30, true);
		animation.addByPrefix(STICKY_RUNNING_UP_RIGHT, animPrefix + "sticky_upRight_running", 30, true);
	}
	
	private function updateShield():Void
	{
		shield.x = getMidpoint().x - shield.width / 2 + 5;
		shield.y = getMidpoint().y - shield.height / 2;
		shield.visible = !shield.animation.finished;
		if (hasShield && shield.animation.finished && shield.animation.curAnim.name == "activate") shield.animation.play("shield");
	}
	
	private function turnOnShield():Void
	{
		hasShield = true;
		shield.visible = true;
		shield.animation.play("activate");
	}
	
	private function turnOnBeast():Void
	{
		isBeast = true;
		for (i in 0...trail.members.length) FlxTween.tween(trail.members[i], { alpha: 1 - i * .1 }, .3);
		_beastTimer.start(10, turnOffBeast);
		color = 0xFFFF3333;
		
		maxVelocity.set(_beastMaxVelo * GameRules.getPlayerSpeed(), _beastMaxVelo * GameRules.getPlayerSpeed());
	}
	
	private function turnOffBeast(timer:FlxTimer = null):Void
	{
		isBeast = false;
		for (i in 0...trail.members.length) FlxTween.tween(trail.members[i], { alpha: 0 }, .3 , { startDelay: .3, complete: function c(t:FlxTween):Void { trail.visible = false; } } );
		color = 0xFFFFFFFF;
		
		maxVelocity.set(_defaultMaxVelo * GameRules.getPlayerSpeed(), _defaultMaxVelo * GameRules.getPlayerSpeed());
	}
	
	private function tweenHalo(tween:FlxTween):Void
	{
		FlxTween.tween(halo, { x: x + width / 2 - halo.width / 2 + Reg.random.float(0, 10), y: y - _graphicHeight - halo.height / 2}, Reg.random.float(.05, .1), { complete: tweenHalo } );
	}
	
	public function removeShield():Void
	{ 
		hasShield = false;
		shield.animation.play("destroy");
	}
	
}