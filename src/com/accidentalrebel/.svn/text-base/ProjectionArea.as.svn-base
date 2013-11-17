package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import com.accidentalrebel.*;
	import org.flixel.*;
	 
	public class ProjectionArea extends FlxSprite
	{
		private var _launcher: Launcher;
		private var isDirty:Boolean;
		private var _mainBall:Ball;
		private var _lineColor: uint;
		private var _placeText: FlxText;
		
		public function ProjectionArea(mainBall: Ball, launcher: Launcher) 
		{			
			super(0, 0);
			
			_mainBall = mainBall;
			_launcher = launcher;
			isDirty = false;
			
			updateLineColor();			
			makeGraphic( FlxG.width, FlxG.height, 0x00);
			
			_placeText = new FlxText(0, 0, 300, "Reposition ball by clicking on the mouse"); 
			_placeText.visible = false;
			_placeText.size = 12;
			Registry.gForeground.add(_placeText);			
		}		
		
		override public function update() : void
		{
			if ( isDirty == true )
			{
				fill(0x00); // Clear the area
				isDirty = false;
			}
			_placeText.visible = false;
			if ( Registry.mainBall.allowBallPlacement == false && Registry.gui.visible == false && Registry.isSimulating == false )
			{			
				drawLine(_mainBall.x + ( _mainBall._radius ), _mainBall.y + ( _mainBall._radius ), FlxG.mouse.x + (35 / 2) , FlxG.mouse.y + (35 / 2), _lineColor, 40);
				isDirty = true;
			}
			else if ( Registry.mainBall.allowBallPlacement == true &&  Registry.gui.visible == false && Registry.isSimulating == false )
			{
				_placeText.visible = true;
				_placeText.color = _lineColor;
				_placeText.x = FlxG.mouse.x + 40;
				_placeText.y = FlxG.mouse.y - 5;
				drawLine(0, FlxG.mouse.y + (Registry.mainBall.height / 2 ) - 2, FlxG.width, FlxG.mouse.y + (Registry.mainBall.height / 2 ) -2 , _lineColor, 3);
				drawLine(FlxG.mouse.x + (Registry.mainBall.height / 2 ) - 2, 0, FlxG.mouse.x + (Registry.mainBall.height / 2 ) - 2, FlxG.height, _lineColor, 3);
				isDirty = true;
			}
			
			super.update();
		}
		
		public function updateLineColor():void 
		{
			if ( _mainBall.currentColor == Ball.BLUE )
			{
				_lineColor = 0x551570ae;
			}
			else if ( _mainBall.currentColor == Ball.RED )
			{
				_lineColor = 0x44ca2568;
			}
			else if ( _mainBall.currentColor == Ball.GREEN )
			{
				_lineColor = 0x4400AA00;
			}
			else
			{
				_lineColor = 0x551570ae;
			}
		}
		
	}

}