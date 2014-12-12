package game;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

/**
 * ...
 * @author MintPaw
 */
class Bullet extends FlxSpriteGroup
{
	public var playerThatShot:Player;
	public var damage:Int;
	public var sticky:Bool = false;
	public var laser:Bool = false;
	public var noHit:Bool = true;
	
	public var secondTimer:FlxTimer;
	public var timeTillExplode:Int = Reg.STICKY_TIMER;
	public var hasHit:Array<FlxSprite> = [];
	
	public var needToExplode:Bool = false;
	
	public var model:FlxSprite = new FlxSprite();
	
	private var _firstFrame:Bool = true;
	
	public function new(player:Player) 
	{
		super();
		
		add(model);
		
		mass *= .5;
		
		playerThatShot = player;
		sticky = playerThatShot.currentWeapon == Player.STICKY;
		laser = playerThatShot.currentWeapon == Player.LASER;
		
		model.setFacingFlip(FlxObject.LEFT, true, false);
		model.setFacingFlip(FlxObject.RIGHT, false, false);
		
		angle = player.muzzleFlash.angle;
		facing = player.muzzleFlash.facing;
		
		if (playerThatShot.currentWeapon == Player.BLASTER) model.loadGraphic("img/bullets/bulletOrange.png");
		if (playerThatShot.currentWeapon == Player.SHOTGUN) model.loadGraphic("img/bullets/bulletRed.png");
		if (playerThatShot.currentWeapon == Player.SMG)
		{
			model.frames = FlxAtlasFrames.fromTexturePackerJson("img/bullets/Green Bullet.png", "img/bullets/Green Bullet.json");
			model.animation.addByPrefix("default", "bulletGreen_");
			model.animation.play("default");
		}
		
		if (playerThatShot.currentWeapon == Player.LASER) model.loadGraphic("img/bullets/bulletBlue_end.png");
		
		if (playerThatShot.currentWeapon == Player.STICKY)
		{
			model.frames = FlxAtlasFrames.fromTexturePackerJson("img/bullets/Yellow Bullet.png", "img/bullets/Yellow Bullet.json");
			model.animation.addByPrefix("default", "yellowBullet_activate");
			model.animation.play("default");
		}
		
		if (sticky)
		{
			secondTimer = new FlxTimer();
			secondTimer.start(1, secondPassed, 0);
			drag.set(500, 500);
		}
		
		new FlxTimer().start(10, function c(t:FlxTimer):Void { kill(); } );
	}
	
	override public function update(elapsed:Float):Void 
	{
		noHit = false;
		if (laser)
		{
			angle += 1;
			
			if (_firstFrame)
			{
				FlxTween.tween(velocity, { x: velocity.x * .01, y: velocity.y * .01 }, .2);
				FlxTween.tween(velocity, { x: velocity.x * 20, y: velocity.y * 20 }, 1, { startDelay: .75 });
			}
		}
		
		_firstFrame = false;
		
		super.update(elapsed);
	}
	
	private function secondPassed(timer:FlxTimer):Void
	{
		timeTillExplode--;
		alpha = alpha == .5 ? 1 : .5;
		if (timeTillExplode <= 0)
		{
			explode();
		}
	}
	
	public function explode():Void
	{
		secondTimer.cancel();
		needToExplode = true;
	}
	
}