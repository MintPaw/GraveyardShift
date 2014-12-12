package ;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import input.InputLayout;
import input.InputManager;
import menu.substates.PlayerSelectSubState;

/**
 * ...
 * @author MintPaw
 */
class MintSubState extends FlxSubState
{
	public static inline var SLIDE_IN:Int = 0;
	public static inline var SLIDE_OUT:Int = 1;
	public static inline var CRASH_DOWN:Int = 2;
	
	private var _bg:FlxSprite;
	private var _container:FlxSpriteGroup;
	private var _controllerDelay:Float;
	
	public var goUp:Bool;
	public var goDown:Bool;
	public var goLeft:Bool;
	public var goRight:Bool;
	public var goConfirm:Bool;
	public var goBack:Bool;
	public var goY:Bool;
	
	public var noAnimation:Bool = false;
	public var animationIn:Int = SLIDE_IN;
	public var animationOut:Int = SLIDE_IN;
	public var animatingIn:Bool = true;
	public var animatingOut:Bool = false;
	
	public function new() 
	{
		super(0);
	}
	
	override public function create():Void 
	{
		super.create();
		
		_container = new FlxSpriteGroup();
		add(_container);
		
		_bg = new FlxSprite();
		_bg.makeGraphic(FlxG.width, FlxG.height, 0x55000000);
		//_container.add(_bg);
		
		_bg.scrollFactor.set();
		
		_controllerDelay = 0;
		
		if (!noAnimation) doInAnimation();
		
		persistentDraw = persistentUpdate = false;
	}
	
	public function makePrompt(n:Int):Void
	{
		var controller:String = "";
		var promptSuffix:String = !Reg.isSnowing ? "" : "_black";
		n++;
		
		#if ouya
			controller = "ouya";
		#elseif fire
			controller = "fire";
		#elseif pc
			if (FlxG.gamepads.getByID(0) != null) controller = "xbox" else controller = "pc";
		#end
		
		var prompt:FlxSprite = new FlxSprite();
		prompt = new FlxSprite(0, 0, "img/menu/" +  controller + "Prompt" + n + promptSuffix + ".png");
		prompt.x = FlxG.width - prompt.width - 20;
		prompt.y = FlxG.height - prompt.height - 20;
		prompt.scrollFactor.set();
		add(prompt);
		
	}
	
	public function doInAnimation():Void
	{
		if (animationIn == SLIDE_IN)
		{
			_container.x = FlxG.width;
			FlxTween.tween(_container, { x: 0 }, .5, { onComplete: endAnimation } );
		} else if (animationIn == CRASH_DOWN) {
			_container.y = -FlxG.height;
			FlxTween.tween(_container, { y: 0 }, .5, { ease: FlxEase.bounceOut, onComplete: endAnimation  } );
		}
	}
	
	private function endAnimation(tween:FlxTween):Void { animatingIn = false; }
	
	override function tryUpdate(elapsed:Float):Void 
	{
		super.tryUpdate(elapsed);
		
		if (subState != null)
		{
			for (i in 0..._container.members.length) _container.members[i].visible = false;
			return;
		} else {
			for (i in 0..._container.members.length) _container.members[i].visible = true;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		updateInput();
	}
	
	private function updateInput():Void
	{
		goUp = false;
		goDown = false;
		goLeft = false;
		goRight = false;
		goConfirm = false;
		goBack = false;
		goY = false;
		
		if (animatingIn) return;
		
		_controllerDelay -= FlxG.elapsed;
		
		for (i in 0...4)
		{
			var pad:FlxGamepad = FlxG.gamepads.getByID(i);
			if (pad == null) continue;
			
			#if !fire
			if  (pad.getXAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone) goLeft = true;
			if  (pad.getXAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone) goRight = true;
			if  (pad.getYAxis(InputLayout.LEFT_ANALOGUE) < -InputManager.deadZone) goUp = true;
			if  (pad.getYAxis(InputLayout.LEFT_ANALOGUE) > InputManager.deadZone) goDown = true;
			if  (pad.pressed(InputLayout.CONFIRM)) goConfirm = true;
			if  (pad.pressed(InputLayout.DENY)) goBack = true;
			if  (pad.pressed(InputLayout.Y)) goY = true;
			#end
			
			#if fire
			if  (pad.getAxis(0) < -InputManager.deadZone || pad.justReleased(InputLayout.DPAD_LEFT)) goLeft = true;
			if  (pad.getAxis(0) > InputManager.deadZone || pad.justReleased(InputLayout.DPAD_RIGHT)) goRight = true;
			if  (pad.getAxis(0) < -InputManager.deadZone || pad.justReleased(InputLayout.DPAD_UP)) goUp = true;
			if  (pad.getAxis(1) > InputManager.deadZone || pad.justReleased(InputLayout.DPAD_DOWN)) goDown = true;
			if  (pad.pressed(InputLayout.CONFIRM)) goConfirm = true;
			if  (pad.pressed(InputLayout.DENY)) goBack = true;
			if  (pad.pressed(InputLayout.Y)) goY = true;
			#end
		}
		
		if (FlxG.keys.justPressed.LEFT) goLeft = true;
		if (FlxG.keys.justPressed.RIGHT) goRight = true;
		if (FlxG.keys.justPressed.UP) goUp = true;
		if (FlxG.keys.justPressed.DOWN) goDown = true;
		if (FlxG.keys.justPressed.ENTER) goConfirm = true;
		if (FlxG.keys.justPressed.ESCAPE) goBack = true;
		if (FlxG.keys.justPressed.SPACE) goY = true;
		
		if (!goLeft && !goRight && !goUp && !goDown && !goConfirm) _controllerDelay = 0;
		
		if (_controllerDelay > 0)
		{
			goLeft = goRight = goUp = goDown = goConfirm = false;
			return;
		}
		
		if (goLeft || goRight || goUp || goDown || goConfirm) _controllerDelay = .2;
	}
	
	override public function close():Void 
	{
		animatingOut = true;
		if (Std.is(_parentState, PlayerSelectSubState)) cast(_parentState, PlayerSelectSubState).resetSelf();
		FlxTween.tween(_container, { x: FlxG.width }, .5, { onComplete: closeReal } );
	}
	
	private function closeReal(tween:FlxTween):Void
	{
		FlxG.camera.scroll.set();
		FlxG.camera.follow(null);
		super.close();
	}
}