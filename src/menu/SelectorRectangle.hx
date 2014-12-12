package menu;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author MintPaw
 */
class SelectorRectangle extends FlxSprite
{
	public var graphicalWidth:Float;
	public var graphicalHeight:Float;
	
	public function new() 
	{
		super();
		
		makeGraphic(10, 10, Reg.isSnowing ? 0xFF000000 : 0xFFFFFFFF);
		
		graphicalWidth = width;
		graphicalHeight = height;
		
		origin.set();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		setGraphicSize(Math.round(graphicalWidth), Math.round(graphicalHeight));
	}
	
	public function gotoItem(item:FlxSprite, force:Bool = false, fromTheLeft:Bool = false):Void
	{
		var goingToPos:FlxPoint = new FlxPoint(item.x, item.y + item.height);
		var goingToSize:FlxPoint = new FlxPoint(item.width, 10);
		
		if (fromTheLeft)
		{
			goingToPos.set(item.x, item.y + item.height / 2 - 5);
			goingToSize.set(10, item.height);
		}
		
		if (force)
		{
			graphicalWidth = goingToSize.x;
			graphicalHeight = goingToSize.y;
			x = goingToPos.x;
			y = goingToPos.y;
			y -= 3;
		} else FlxTween.tween(this, { graphicalWidth: goingToSize.x, graphicalHeight: goingToSize.y, x: goingToPos.x, y: goingToPos.y }, .1 );
	}
	
}