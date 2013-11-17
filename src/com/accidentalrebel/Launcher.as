package com.accidentalrebel 
{
	import Box2D.Dynamics.b2World;
	import com.accidentalrebel.Ball;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Karlo
	 */
	public class Launcher extends FlxSprite
	{
		[Embed(source = '../../assets/launcher.png')]private var imgLauncher: Class;
		[Embed(source = '../../assets/powerBars.png')]private var imgPowerBar: Class;
		[Embed(source = '../../assets/powerBars-blue.png')]private var imgPowerBarBlue: Class;
		[Embed(source = '../../assets/powerBars-red.png')]private var imgPowerBarRed: Class;
		[Embed(source = '../../assets/powerBars-green.png')]private var imgPowerBarGreen: Class;
		
		/**
		 * Configurable
		 */		
		public var reloadSpeed: Number = 1;	
		public var _maxLaunchPower: Number = 8;
		private var _timeBetweenLaunchPowerChange: Number = 0.3;
		/**
		 * Other variables
		 */
		public var canLaunch:Boolean = true;
		public var centerCoordinate: FlxPoint = new FlxPoint();
		private var _mainBall:Ball;
		public var _launchPower: Number = 1;
		public var _powerBarGoingUp: Boolean = true;
		private var _launchTimer: Number = 0;		
		
		private var _world: b2World;		
		
		public function Launcher(X: Number, Y:Number, World: b2World, MainBall: Ball) 
		{
			super(X, Y);
			_world = World;
			_mainBall = MainBall;

			//loadRotatedGraphic(imgLauncher, 360, -1, false, false);
			updateGraphic();
			addAnimation("level0", [0], 0, false);
			addAnimation("level1", [1], 0, false);
			addAnimation("level2", [2], 0, false);
			addAnimation("level3", [3], 0, false);
			addAnimation("level4", [4], 0, false);
			addAnimation("level5", [5], 0, false);
			addAnimation("level6", [6], 0, false);
			addAnimation("level7", [7], 0, false);
			addAnimation("level8", [8], 0, false);			
			play("level1");
			// visible = false;			
			
			updateCenterCoordinates();
			visible = false;

		}
		
		public function updateGraphic():void 
		{
			if ( _mainBall.currentColor == Ball.BLUE )
			{
				loadGraphic(imgPowerBarBlue, false, false, 59, 59);
			}
			else if ( _mainBall.currentColor == Ball.RED )
			{
				loadGraphic(imgPowerBarRed, false, false, 59, 59);
			}
			else if ( _mainBall.currentColor == Ball.GREEN )
			{
				loadGraphic(imgPowerBarGreen, false, false, 59, 59);
			}
		}
		
		private function updateCenterCoordinates():void 
		{
			centerCoordinate.x = x + (width / 2);
			centerCoordinate.y = y + (height / 2);
		}

		override public function update() : void
		{			
			x = _mainBall.x - 9;
			y = _mainBall.y - 9;
			
			updateCenterCoordinates();			
			checkForKeypresses();
			
			super.update();
		}
		
		/**
		 * Checks for keypresses
		 */
		private function checkForKeypresses():void
		{				
			if ( canLaunch == true )
			{
				if ( Registry.mainBall.allowBallPlacement == false )
				{
					/**
					 * This handles the changing of the launchPower
					 */
					if ( !Registry.isSimulating && FlxG.mouse.justPressed() )
					{
						visible = true;
						_launchPower = 0;
						_launchTimer = _timeBetweenLaunchPowerChange;
					}
					if ( !Registry.isSimulating && FlxG.mouse.pressed() )
					{				
						_launchTimer += FlxG.elapsed ;
						if ( _launchTimer > _timeBetweenLaunchPowerChange )
						{
							changeLaunchPower();
							_launchTimer = 0;
						}				
					}
					
					/**
					 * This releases the ball
					 */
					if ( !Registry.isSimulating && FlxG.mouse.justReleased() && canLaunch == true)
					{
						_mainBall.launchSpeed = _launchPower * (100 + (20 * _launchPower ));
						_mainBall.launch();
						Registry.isSimulating = true;
						canLaunch = false;
						visible = false;
					}
				}
			}			
			
			/**
			 * This lets the Launcher go left to right
			 * However, It doesn't let the launcher go out of the screen
			 */
			if ( x > 0 && (FlxG.keys.pressed("A") || FlxG.keys.pressed("LEFT")))
			{
				// x -= 150 * FlxG.elapsed;
				width -= 1;
			}
			else if ( x < FlxG.width - width && (FlxG.keys.pressed("D") || FlxG.keys.pressed ("RIGHT")))
			{
				x += 150 * FlxG.elapsed;
			}
		}
		
		public function placeBallToLocation():void 
		{
			// Place the mainball to where the mouse is
			Registry.mainBall._obj.SetPosition(new b2Vec2((FlxG.mouse.x + Registry.mainBall._radius) / Registry.mainBall.ratio, (FlxG.mouse.y + Registry.mainBall._radius) / Registry.mainBall.ratio));
			Registry.mainBall.allowBallPlacement = false;
			canLaunch = true;
			Registry.isScratched = false;
			FlxG.mouse.reset();
		}
		
		private function changeLaunchPower():void 
		{
			// This keeps the launch power from going below 0 and over the max launch power
			if ( _launchPower >= _maxLaunchPower )
			{
				_powerBarGoingUp = false;
			}
			else if ( _launchPower <= 1 )
			{
				_powerBarGoingUp = true;
			}
			
			// Then we change the launch power				
			if ( _powerBarGoingUp == true )
			{
				_launchPower ++;
			}
			else
			{
				_launchPower --;
			}			
			
			// Then depending on the launchPower amount, change
			// the appropriate sprite
			switch( _launchPower ) {
				case 0:
					play("level0");
					break;
				case 1:
					play("level1");
					break;
				case 2:
					play("level2");
					break;
				case 3:
					play("level3");
					break;
				case 4:
					play("level4");
					break;
				case 5:
					play("level5");
					break;
				case 6:
					play("level6");
					break;
				case 7:
					play("level7");
					break;
				case 8:
					play("level8");
					break;
				default:
					play("level8");	
			}
			
		}
		
	}

}