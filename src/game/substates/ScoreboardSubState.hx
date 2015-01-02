package game.substates;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.FlxInput.FlxInputState;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import game.GameState;
import game.Player;
import input.InputLayout;
import menu.MenuState;
import menu.substates.VersusSubState;

/**
 * ...
 * @author MintPaw
 */
class ScoreboardSubState extends MintSubState
{
	private var _players:Array<Player>;
	private var _bars:Array<FlxBar>;
	private var _scores:Array<FlxText>;
	private var _labels:Array<FlxText>;
	private var _barTips:Array<FlxSprite>;
	
	private var _winner:Player;
	
	private var _frameCount:Int = 0;
	private var _barExtra:Float = GameRules.pointsToWin * .05;
	private var _goToMenu:Bool = false;
	private var _goToModeSelect:Bool = false;
	private var _goRestart:Bool = false;
	
	public function new(players:Array<Player>) 
	{
		super();
		
		_players = players;
	}
	
	override public function create():Void 
	{
		noAnimation = true;
		
		super.create();
		
		_bars = [];
		_scores = [];
		_labels = [];
		_barTips = [];
		
		var b:FlxSprite = new FlxSprite(0, 0, "img/gui/backgroundScore.png");
		b.x = FlxG.width / 2 - b.width / 2;
		b.y = FlxG.height / 2 - b.height / 2 + 100;
		_container.add(b);
		
		var labelPadding:Int = 50;
		var barColours:Array<Int> = [0xFF074E96, 0xFFC52C2C, 0xFF5DB407, 0xFFF09030, 0xFF663666];
		var barTipColours:Array<Int> = [0xFF032C56, 0xFF912020, 0xFF3F7B04, 0xFFB66C23, 0xFF482548];
		
		for (i in 0..._players.length)
		{
			var label:FlxText = new FlxText(0, 0, 300, "Player " + (i + 1), 30);
			label.alignment = "center";
			label.autoSize = true;
			label.font = "dekar";
			label.y = FlxG.height - label.height - 100;
			_container.add(label);
			
			_labels.push(label);
			
			var b:FlxBar = new FlxBar(0, 0, FlxBarFillDirection.BOTTOM_TO_TOP, 100, 400, null, "", 0, GameRules.pointsToWin + _barExtra);
			b.createFilledBar(0, barColours[_players[i].modelNumber]);
			b.value = _players[i].score + _barExtra;
			b.y = label.y - b.height - 50;
			_container.add(b);
			
			_bars.push(b);
			
			var score:FlxText = new FlxText(0, 0, 200, "test", 50);
			score.text = "XX";
			score.font = "impact";
			score.autoSize = true;
			score.allowCollisions = FlxObject.ANY;
			score.x = b.x + b.width / 2 - score.textField.textWidth / 2;
			score.y = b.y + b.height - 100;
			_scores.push(score);
			
			var tip:FlxSprite = new FlxSprite();
			tip.makeGraphic(Math.floor(b.width), 10, barTipColours[_players[i].modelNumber]);
			_container.add(tip);
			
			_barTips.push(tip);
			
			_container.add(score);
			
			if (_players[i].score + _players[i].pointsToAdd < 0) _players[i].pointsToAdd = 0;
			
			FlxTween.tween(b, { value: b.value + _players[i].pointsToAdd }, .5, { startDelay: Reg.random.float(.75, 1.5), ease: FlxEase.elasticOut } );
			
			_players[i].score += _players[i].pointsToAdd;
			_players[i].pointsToAdd = 0;
			
			if (_players[i].score >= GameRules.pointsToWin) _winner = _players[i];
		}
		
		if (_winner != null)
		{
			var banner:FlxSprite = new FlxSprite(0, 0, "img/gui/winningTextBox" + Std.string(_winner.modelNumber) + ".png");
			banner.x = FlxG.width / 2 - banner.width / 2;
			banner.y = 50;
			_container.add(banner);
			
			var bannerText:FlxText = new FlxText(0, 0, banner.width, "test", 70);
			bannerText.alignment = "center";
			bannerText.font = "dekar";
			bannerText.text = "Player " + Std.string(_winner.playerNum + 1) + "\nIs the winner!";
			bannerText.x = banner.x;
			bannerText.y = banner.y + 10;
			_container.add(bannerText);
		}
		
		members[members.length - 1] = members[members.indexOf(_container)];
		
		animationIn = MintSubState.CRASH_DOWN;
		doInAnimation();
		
		if (_winner == null) makePrompt(3) else makePrompt(5);
	}

	override public function endAnimation(tween:FlxTween):Void
	{
		FlxG.camera.shake(.001, .1);
		super.endAnimation(tween);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (_goToMenu || _goToModeSelect) return;
		
		var needToContinue:Bool = false;
		_goToMenu = false;
		_goToModeSelect = false;
		
		for (i in 0..._players.length)
		{
			if (_players[i].controller != null) 
			{
				if (_players[i].controller.pressed(InputLayout.CONFIRM) && _winner == null) needToContinue = true;
				if (_players[i].controller.pressed(InputLayout.DENY) && _winner != null) _goToMenu = true;
				if (_players[i].controller.pressed(InputLayout.X) && _winner != null)
				{
					Reg.levelNumber = Reg.random.int(0, 16);
					_goRestart = true;
				}
				if (_players[i].controller.pressed(InputLayout.Y) && _winner != null) _goRestart = true;
			} else {
				if (FlxG.keys.pressed.SPACE) needToContinue = true;
				if (FlxG.keys.pressed.ESCAPE && _winner != null) _goToMenu = true;
				if (FlxG.keys.pressed.SPACE && _winner != null)
				{
					Reg.levelNumber = Reg.random.int(0, 16);
					_goRestart = true;
				}
				if (FlxG.keys.pressed.ENTER && _winner != null) _goRestart = true;
			}
		}
		
		if (needToContinue && _winner == null)
		{
			cast(FlxG.state, GameState).needToReset = true;
			close();
		}
		
		if (_goToMenu) FlxG.camera.fade(FlxColor.BLACK, 1, false, FlxG.switchState.bind(new MenuState()));
		if (_goToModeSelect)
		{
			Reg.menuGoingToVersus = true;
			FlxG.camera.fade(FlxColor.BLACK, 1, false, FlxG.switchState.bind(new MenuState()));
		}
		if (_goRestart) FlxG.camera.fade(FlxColor.BLACK, 1, false, FlxG.switchState.bind(new GameState()));
		
		if (animatingOut) return;
		
		for (i in 0..._scores.length)
		{
			_scores[i].text = Std.string(Math.round((_bars[i].value - _barExtra) * 10) / 10);
			_scores[i].x = _bars[i].x + _bars[i].width / 2 - _scores[i].textField.textWidth / 2;
			_scores[i].y = _bars[i].y + _bars[i].height - (_bars[i].height * (_bars[i].value / _bars[i].max)) - 48;
			
			_barTips[i].x = _bars[i].x;
			_barTips[i].y = _bars[i].y + _bars[i].height - (_bars[i].height * (_bars[i].value / _bars[i].max));// - _barTips[i].height;
			
			_labels[i].x = i * (_labels[i].width + 300) + (FlxG.width - (_labels[i].fieldWidth + 300) * (_players.length - 1)) / 2 - _labels[0].fieldWidth / 2;
			
			_bars[i].x = _labels[i].x + _labels[i].textField.textWidth / 2 - _bars[i].width / 2;
		}
		
	}
	
}