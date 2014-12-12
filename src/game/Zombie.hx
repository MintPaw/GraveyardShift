package game;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author MintPaw
 */
class Zombie extends FlxSprite
{
	public static var RISING:String = "zombie_rising";
	public static var STANDING:String = "zombie_standing";
	public static var WALKING:String = "zombie_walking";
	public static var RUNNING:String = "zombie_running";
	public static var ATTACKING:String = "zombie_attacking";
	public static var DYING:String = "zombie_dying";
	
	private var _changeShuffleTimer:FlxTimer;
	private var _chasePoint:FlxPoint = new FlxPoint();
	private var _speed:Float;
	private var _damage:Float;
	private var _wasSubState:Bool = true;
	private var _raycastTimer:FlxTimer;
	private var _maxHealth:Int;
	
	public var killed:Bool = false;
	public var attacking:Bool = false;
	
	public var chasing:FlxSprite;
	public var needToDrop:Bool = false;
	public var needToCheckLineOfSight:Bool = false;
	public var hasLineOfSight:Bool = false;
	
	public var healthBar:FlxBar;
	public var chaseRadius:Int;
	
	public var startingColour:FlxColor;
	
	public function new() 
	{
		super();
		
		frames = FlxAtlasFrames.fromTexturePackerJson("img/Zombie.png", "img/Zombie.json");
		
		var risingSuffix:String = Reg.isSnowing ? "_snow" : "_dirt";
		
		animation.addByPrefix(RISING, RISING + risingSuffix, 30, false);
		animation.addByPrefix(STANDING, STANDING);
		animation.addByPrefix(WALKING, WALKING);
		animation.addByPrefix(RUNNING, RUNNING);
		animation.addByPrefix(ATTACKING, ATTACKING, 30, false);
		animation.addByPrefix(DYING, DYING, 30, false);
		
		centerOrigin();
		origin.y += height;
		
		height *= .8;
		width *= .9;
		centerOffsets(true);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		maxVelocity.set(5, 5);
		drag.set(maxVelocity.x * 8, maxVelocity.y * 8);
		
		_changeShuffleTimer = new FlxTimer();
		_changeShuffleTimer.start(Reg.random.float(3, 5), changeMovement, 0);
		
		health = _maxHealth = GameRules.getZombieHealth();
		chaseRadius = GameRules.getZombieChaseRadius();
		_speed = GameRules.getZombieSpeed();
		_damage = GameRules.getZombieDamage();
		
		_speed = Reg.random.float(_speed - (_speed * .5), _speed + (_speed * .5));
		
		healthBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 50, 5, this, "health", 0, health, true);
		healthBar.createFilledBar(0x00000000, 0xFF00FF00, true, 0xFF000000);
		healthBar.allowCollisions = FlxObject.NONE;
		healthBar.visible = false;
		
		visible = false;
		
		var randomColor:Int = Reg.random.int(150, 255);
		color = FlxColor.fromRGB(randomColor, randomColor, randomColor);
		startingColour = color;
		
		var riseTimer:FlxTimer = new FlxTimer();
		riseTimer.start(Reg.random.float(0, 2), rise);
		
		_raycastTimer = new FlxTimer();
		_raycastTimer.start(Reg.random.float(2, 4), checkRay, 0);
		
		facing = Reg.random.sign() == -1 ? FlxObject.LEFT : FlxObject.RIGHT;
	}
	
	private function rise(timer:FlxTimer):Void
	{
		visible = true;
		animation.play(RISING);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (!visible) return;
		
		if (animation.curAnim.name == RISING)
		{
			if (animation.finished) animation.play(WALKING);
			return;
		}
		
		if (killed) return;
		updateHealthBar();
		updateChasing();
		updateAnim(elapsed);
	}
	
	private function updateHealthBar():Void
	{
		healthBar.x = x - (healthBar.width - width) / 2;
		healthBar.y = y - healthBar.height - 5;
		
		healthBar.visible = health < _maxHealth && health > 0;
	}
	
	private function updateChasing():Void
	{
		if (chasing == null) return;
		if (!hasLineOfSight || chasing.alpha < 1) return;
		if (!attacking)
		{
			FlxVelocity.moveTowardsObject(this, chasing, _speed);
			if (getMidpoint().distanceTo(chasing.getMidpoint()) < 80) attacking = true;
			if (!chasing.alive) stopChasing();
		}
	}
	
	private function updateAnim(elapsed:Float):Void
	{
		if (attacking && animation.curAnim.name == ATTACKING && animation.finished)
		{
			if (getMidpoint().distanceTo(chasing.getMidpoint()) <= 100)
			{
				if (Std.is(chasing, Player)) cast(chasing, Player).lastPlayerToHit = null;
				chasing.hurt(_damage);
			}
			attacking = false;
			
			if (!chasing.alive)
			{
				if (Std.is(chasing, Player))
				{
					if (GameRules.gameType == GameRules.SLAYER) cast(chasing, Player).pointsToAdd -= 1;
					if (GameRules.gameType == GameRules.POINT) cast(chasing, Player).pointsToAdd -= 100;
				}
				Stats.deathsToZombies++;
			}
		}
		
		if (attacking) animation.play(ATTACKING)
		else if (chasing == null || !hasLineOfSight) animation.play(WALKING);
		else animation.play(RUNNING);
		
		if (chasing != null && hasLineOfSight) facing = x - chasing.x < 0 ? FlxObject.RIGHT : FlxObject.LEFT;
	}
	
	private function checkRay(timer:FlxTimer):Void
	{
		if (chasing == null) return;
		needToCheckLineOfSight = true;
	}
	
	public function startChasing(target:FlxSprite):Void
	{
		needToCheckLineOfSight = true;
		chasing = target;
		acceleration.set();
	}
	
	public function stopChasing():Void
	{
		if (killed) return;
		
		chasing = null;
		animation.play(WALKING);
		attacking = false;
		acceleration.set();
	}
	
	private function changeMovement(timer:FlxTimer):Void
	{
		if (chasing != null || killed || animation.curAnim.name == RISING || FlxG.state.subState != null) return;
		_changeShuffleTimer.time = Reg.random.float(4, 5);
		acceleration.x = Reg.random.float( -1000, 1000);
		acceleration.y = Reg.random.float( -1000, 1000);
		
		facing = acceleration.x < 0 ? FlxObject.LEFT : FlxObject.RIGHT;
	}
	
	override public function kill():Void 
	{
		healthBar.kill();
		animation.play(DYING);
		acceleration.set();
		velocity.set();
		allowCollisions = FlxObject.NONE;
		killed = true;
		_raycastTimer.cancel();
		
		needToDrop = Reg.random.bool(GameRules.getDropChance());
		needToCheckLineOfSight = false;
		Stats.zombieKills++;
		
		FlxTween.tween(this, { alpha: 0 }, 1, { onComplete: timerKill, startDelay: 30 } );
		
		maxVelocity.set(Reg.PLAYER_MAX_VELOCITY, Reg.PLAYER_MAX_VELOCITY);
		drag.set(maxVelocity.x * 2, maxVelocity.y * 2);
	}
	
	override public function hurt(Damage:Float):Void 
	{
		FlxTween.color(this, .25, 0xFFFF0000, startingColour);
		super.hurt(Damage);
	}
	
	public function timerKill(tween:FlxTween = null):Void { alpha = 1; healthBar.kill(); super.kill(); }
}