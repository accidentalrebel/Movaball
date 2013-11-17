// TODO: makeSure that loadBullet is attached to the launcher perfectly when moving
// TODO: check if simulation has eneded
// TODO: Instead of magnetizing, consider creating a new enemy

// TODO: Computer AI
package com.accidentalrebel
{
	import flash.utils.Timer;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.b2ContactListener;
	import com.accidentalrebel.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.*;
 
	public class PlayState extends FlxState
	{
		/**
		 * Changeable variables
		 */
		private var timeBetweenSpawns: Number = 3;
		private var timeBetweenSimulationChecking:Number = 3;
		
		/**
		 * Variables
		 */		
		private var _gWalls: FlxGroup;
		private var _player: Bullet;
		private var _ballProjection: BallProjection;
		private var _launcher: Launcher;		
		private var _starField: StarfieldFX;
		private var _stars: FlxSprite;					
		private var _spawnTimer: Number;
		private var simulationCheckerTimer:Number;	
		private var isLevelComplete:Boolean = false;
		private var ballDiameter:Number = 40;
		public var _world:b2World;		
		private var _background:FlxTileblock;
		public var _projectionArea: ProjectionArea;
		private var isProjectionAreaDirty:Boolean = false;
		
		[Embed(source = '../../assets/ship.png')]public var imgBullet: Class;
		[Embed(source = '../../assets/mainBall.png')]private var imgMainBall: Class;
		[Embed(source = '../../assets/mainBallwShine.png')]private var imgMainBallwShine: Class;
		[Embed(source = '../../assets/gridLines.png')]private var imgGridLines: Class;		
		
		override public function create():void
		{
			/**
			 * Global setup
			 */			
			setupWorld();
			Registry.isSimulating = false;
			simulationCheckerTimer = 0;
			Registry.gBalls = new FlxGroup();
			Registry.gTrails = new FlxGroup();
			Registry.gHazard = new FlxGroup();		
			Registry.gForeground = new FlxGroup();
			Registry.isLevelFinished = false;
			Registry.playersTurn = Registry.PLAYER1;
			Registry.redBallsRelocated = 0;
			Registry.relocateRedBalls = false;
			Registry.isScratched = false;			
			FlxG.mouse.hide();
			FlxG.bgColor = 0xff0d213e;
			_spawnTimer = 0;			
			
			Registry.player1BallColor = Ball.BLUE;
			Registry.player2BallColor = Ball.GREEN;				
			
			/**
			 * Enable plugins
			 */
			/*if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}*/			
			
			/**
			 * Set up the starfield
			 */
			/*_starField = FlxSpecialFX.starfield();
			_starField.setStarSpeed(0, 0.2);	
			_stars = _starField.create(0, 0, FlxG.width, FlxG.height, 400, 1, 30);			
			add(_stars);*/
			
			/**
			 * Set up the background image
			 */
			_background = new FlxTileblock(0, 0, FlxG.width, FlxG.height);
			_background.loadTiles(imgGridLines, 10, 10);
			add(_background);			
			
			/**
			 * Set up the main ball
			 */
			Registry.mainBall = new Ball();
			Registry.mainBall.isMainBall = true;
				
			
			if ( Registry.gameMode == Registry.VERSUSMODE )
			{
				Registry.mainBall.init(FlxG.width / 2, FlxG.height / 2, ballDiameter / 2, _world);
			}
			else
			{				
				Registry.mainBall.init(FlxG.width / 2, FlxG.height - ballDiameter, ballDiameter / 2, _world);
			}			
			Registry.gBalls.add(Registry.mainBall);
			Registry.mainBall.currentColor = Registry.player1BallColor;				
			Registry.mainBall.createBody();
			Registry.mainBall._obj.SetAwake(false);
			
			/**
			 * Set up the projection 
			 */
			_ballProjection = new BallProjection(0, 0);			
			add(_ballProjection);
			
			/**
			 * Set up the launcher
			 */
			_launcher = new Launcher( FlxG.width / 2 , FlxG.height / 2, _world, Registry.mainBall);			
			
			/**
			 * Set up projection area
			 */
			_projectionArea = new ProjectionArea(Registry.mainBall, _launcher);
			add(_projectionArea);
			add(_launcher);
			
			/**
			 * Set up the walls
			 */
			_gWalls = new FlxGroup;
			if ( Registry.gameMode == Registry.VERSUSMODE )
			{
				_gWalls.add(new Walls(0, -20, FlxG.width, 25, _world)); // Top Wall
				_gWalls.add(new Walls(0, FlxG.height - 5, FlxG.width, 25, _world)); // Bottom Wall
				_gWalls.add(new Walls(-20, 0, 25, FlxG.height, _world)); // Left Wall
				_gWalls.add(new Walls(FlxG.width - 5, 0, 25, FlxG.height, _world)); // Right Wall
			}
			
			/**
			 * Spawn enemies at startup
			 */
			if ( Registry.gameMode == Registry.VERSUSMODE )
			{
				for ( var i: Number = 0 ; i < ( Registry.numberOfBallsPerPlayer * 2 ) + Registry.numberOfHazardBalls ; i++ )
				{
					var thisBall: Ball;
					(thisBall = Registry.gBalls.recycle(Ball) as Ball).init(FlxMath.rand( 50, FlxG.width - 50), FlxMath.rand( 50, FlxG.height - 50 ), ballDiameter/2, _world);
					thisBall.launcher = _launcher;		
					
					if ( i + 1 <= Registry.numberOfBallsPerPlayer )
					{
						thisBall.currentColor = Registry.player1BallColor;
					}
					else if ( i + 1 <= Registry.numberOfBallsPerPlayer * 2 )
					{
						thisBall.currentColor = Registry.player2BallColor;
					}
					else
					{
						thisBall.currentColor = Ball.RED;
						thisBall._density = 10000; // This is so that the ball will become immovable
						thisBall._bodyDef.linearDamping = 1000;
					}
					thisBall.updateColor();					
					thisBall.createBody();					
				}						
			}
			
			/**
			 * Let us set up the GUI
			 */
			Registry.gui = new GUI(_launcher);
						
			add(Registry.gTrails);
			add(Registry.gBalls);			
			add(Registry.gHazard);
			add(_gWalls);
			add(Registry.gui);
			add(Registry.gForeground);
			
			updateAllColors();				
			
			Registry.gui.reveal();			
		}
		
		override public function update():void
		{			
			/**
			 * Handles the world step for the physics engine
			 */
			_world.Step( FlxG.elapsed, 10, 10); 	// Box2D Step Update
			//_world.Step( (1/60), 10, 10); 	// Box2D Step Update
			_world.ClearForces(); 			// Clear the previous forces
			
			handleKeyPresses();					
			
			// Set the player projection to where the mouse is
			_ballProjection.x = FlxG.mouse.x - 2;
			_ballProjection.y = FlxG.mouse.y - 2;
			
			super.update();
			
			/**
			 * The following checks whether the simulation has finished
			 */
			if ( _launcher.canLaunch == false && Registry.isSimulating == true && Registry.isLevelFinished == false )
			{
				// This checks the timer
				simulationCheckerTimer += FlxG.elapsed;
				if ( simulationCheckerTimer > timeBetweenSimulationChecking )
				{
					// This checks if the level is complete
					if ( checkIfLevelComplete() && Registry.gui.visible == false )
					{
						Registry.gui.reveal();
						Registry.isLevelFinished = true;
					}
					else
					{
						if ( Registry.gBalls.members.every( checkForEndOfSimulation) == true )
						{							
							if ( Registry.isScratched == true )
							{
								Registry.mainBall.allowBallPlacement = true;
							}
							else
							{
								_launcher.canLaunch = true;															
							}							
							Registry.isSimulating = false;
							
							if ( Registry.gameMode == Registry.VERSUSMODE )
							{
								nextPlayer();								
							}
							
							Registry.relocateRedBalls = true;
							
							Registry.gBalls.callAll("stopMoving"); // Stop all balls from moving														
						}
						simulationCheckerTimer = 0;
					}					
				}			
			}
			
			if ( Registry.isLevelFinished && FlxG.mouse.justPressed() )
			{
				Registry.BGMusic.stop();
				FlxG.switchState(new MenuState());
			}
		}		
		
		private function nextPlayer():void 
		{
			// This changes the turn to the next player
			if ( Registry.playersTurn == Registry.PLAYER1 )
			{
				Registry.playersTurn = Registry.PLAYER2;
				Registry.mainBall.currentColor = Registry.player2BallColor;
			}
			else if ( Registry.playersTurn == Registry.PLAYER2 )
			{
				Registry.playersTurn = Registry.PLAYER1;
				Registry.mainBall.currentColor = Registry.player1BallColor;
			}
			_launcher.canLaunch = false;
			Registry.gui.reveal();
			
			updateAllColors();		
		}
		
		private function updateAllColors():void 
		{			
			// This then updates the colors
			Registry.mainBall.updateColor();
			_launcher.updateGraphic();
			_ballProjection.updateColor();
			_projectionArea.updateLineColor();	
		}
		
		private function handleKeyPresses():void 
		{
			/**
			 * Keypresses
			 */
			if ( FlxG.keys.justPressed("ESCAPE") )
			{
				Registry.BGMusic.stop();
				FlxG.switchState(new MenuState());
			}
			if ( FlxG.keys.justPressed("B"))
			{
				if ( FlxG.visualDebug == false )
				{
					FlxG.visualDebug = true;
				}
				else
				{
					FlxG.visualDebug = false;
				}
			}			
			if ( FlxG.keys.justPressed("SPACE") && Registry.isSimulating == false )
			{
				Registry.mainBall.switchColor();
				_launcher.updateGraphic();
				_ballProjection.updateColor();
				_projectionArea.updateLineColor();
			}
			
			/**
			 * When ballPlacement is on, clicking on the mouse
			 * sets the ball in place
			 */			
			if ( Registry.mainBall.allowBallPlacement == true && FlxG.mouse.justPressed() && Registry.gui.visible == false )
			{				
				// However only allow it if there is no ball in the current location
				//if ( _ballProjection.overlaps(Registry.gBalls) == false )
				if ( FlxG.overlap( _ballProjection, Registry.gBalls ) == false )
				{
					_launcher.placeBallToLocation();
				}
				else
				{
					trace("Can't place to location!");
				}
			}			
		}
		
		/**
		 * Checks whether if the level has been completed
		 * If all balls on the screen are of the same color
		 */
		private function checkIfLevelComplete(): Boolean
		{
			// If all members are the same color of the main ball
			// then return true
			if ( Registry.gBalls.members.every( checkIfAllSameColor ) )
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function checkIfAllSameColor(element: * , index: Number, arr: Array  ):Boolean
		{
			if ( element is Ball && element != null )
			{
				// Exclude red balls from the count
				if ( element.currentColor == Ball.RED )
				{
					return true;
				}
				
				// If there is one ball that is not equal to the current color of the main ball
				// then break the loop and check again next time
				if ( element.currentColor != Registry.mainBall.currentColor )
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			else
			{
				return true;
			}
		}
		
		private function checkForEndOfSimulation(element: * , index: Number, arr: Array  ):Boolean
		{
			if ( element is Ball && element != null && element.alive )
			{
				if ( element._obj != null )
				{
					// This checks whether the object's linear velocity is greater than 0.5
					if ( Math.abs(element._obj.GetLinearVelocity().x) > 0.5 ||
						Math.abs(element._obj.GetLinearVelocity().y) > 0.5 )
					{
						// If it is, then tell the loop to break
						// and wait for the next simulation end checking
						return false;
					}
					else
					{		
						// If it is not, then continue checking the next elements
						return true;							
					}
				}				
			}
			return true;
		}
		
		/**
		 * Spawning of enemies during the game
		 */
		private function spawnEnemiesAtRandom() : void
		{			
			_spawnTimer += FlxG.elapsed;
			if ( _spawnTimer > timeBetweenSpawns )
			{
				trace("spawned");
				var thisBall: Ball;
				(thisBall = Registry.gBalls.recycle(Ball) as Ball).init(FlxMath.rand(50, FlxG.width-50), -40, ballDiameter/2, _world);
				thisBall.launcher = _launcher;		
		
				_spawnTimer = 0;
			}	
		}
		
		private function setupWorld():void 
		{
			//var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			var gravity:b2Vec2 = new b2Vec2(0, 0);
			_world = new b2World(gravity, true);	
			/*var ballContactListener: MyContactListener = new MyContactListener();
			_world.SetContactListener(ballContactListener);		*/	
		}
		
		override public function destroy():void 
		{
			// FlxSpecialFX.clear(); // Disable the plugin
						
			super.destroy();
			
			Registry.gBalls.destroy();			
			
			_gWalls = null;
			_player = null;
			_ballProjection = null;
			_launcher = null;		
			_starField = null;
			_stars = null;		
			Registry.mainBall = null;
			_spawnTimer = 0;
			isLevelComplete = false;
			simulationCheckerTimer = 0;
			_world = null;			
		}
	}
}