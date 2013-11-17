package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import Box2D.Dynamics.b2World;
	import com.accidentalrebel.HazardSign;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	 
	public class Ball extends Ship
	{
		/**
		 * Image initialization
		 */
		[Embed(source = '../../assets/enemyShip.png')]public var imgBall: Class;
		[Embed(source = '../../assets/normalBall.png')]private var normalBall: Class;
		[Embed(source = '../../assets/normalBallwShine.png')]private var normalBallwShine: Class;
		[Embed(source = '../../assets/mainBallwShine.png')]private var imgMainBallwShine: Class;
		
		[Embed(source = '../../assets/blueTrail.png')]private var imgBlueTrail: Class;
		[Embed(source = '../../assets/redTrail.png')]private var imgRedTrail: Class;
		[Embed(source = '../../assets/greenTrail.png')]private var imgGreenTrail: Class;
		
		[Embed(source = '../../assets/SFX/sfxBump.mp3')]private var sBump: Class;
		[Embed(source = '../../assets/SFX/sfxHazard.mp3')]private var sHazard: Class;
		
		public var launchSpeed:Number;		
		private var _getSpeed:Number;
		private var _launchAngle: Number;
		private var isMagnetized:Boolean;
		private var isDocked:Boolean;
		public var launcher: Launcher;
		public var _fallingSpeed: Number;
		public var currentColor: int;
		public var isMainBall:Boolean = false;
		public var canDie: Boolean;
		public var allowBallPlacement:Boolean;
		
		private var sfxBump: FlxSound;
		private var sfxHazard: FlxSound;
		
		private var emitter:FlxEmitter;
		private var trailTimer:Number;
		private var hazardSign:HazardSign;
		
		// Enums
		public static var RED: int = 0;
		public static var GREEN: int = 1;
		public static var BLUE: int = 2;		
		
		
		public function Ball() 
		{
			super();
		}
		
		override public function init(X: Number, Y: Number, Radius: Number, World: b2World) : void 
		{
			/**
			 * Initialize all values
			 */
			
			launchSpeed = 1200;				
			_getSpeed = 1500;
			_fallingSpeed = 40;
			isMagnetized = false;
			isDocked = false;
			currentColor = RED;
			canDie = false;
			trailTimer = 0;
			allowBallPlacement = false;
			
			/**
			 * Set up the sound effects
			 */
			sfxBump = new FlxSound();
			sfxBump.loadEmbedded(sBump, false, true);
			sfxBump.volume = 0.8;
			
			sfxHazard = new FlxSound();
			sfxHazard.loadEmbedded(sHazard, false);
			sfxHazard.volume = 0.8;
			
			/**
			 * Constructor stuff
			 */			
			revive();
			
			super.init(X, Y, Radius, World);			
			
			if ( isMainBall )
			{
				loadGraphic(imgMainBallwShine, false, false, 70, 70, false);
			}
			else
			{
				loadGraphic(normalBallwShine, false, false, 70, 70, false);
			}
			
			offset.x = 15;
			offset.y = 15;
			addAnimation("blue", [0]);
			addAnimation("red", [1]);
			addAnimation("green", [2]);
						
			if ( isMainBall )
			{
				if ( Registry.mainBall.currentColor == RED )
				{
					currentColor = RED;
				}
				else if ( Registry.mainBall.currentColor == BLUE )
				{
					currentColor = BLUE;
				}
				else if ( Registry.mainBall.currentColor == GREEN )
				{
					currentColor = GREEN;
				}
			}
			else
			{
				// rollForColor();
			}
			updateColor();
			
			dataToPass = this;
			
			// createBody();			
			
			if ( Registry.gameMode == Registry.ACTIONMODE && isMainBall == false )
			{
				_force = new b2Vec2(0,0); // Reset to zero			
				_force.Add(new b2Vec2(0, _fallingSpeed));	// Start moving downwards			
				_obj.ApplyForce(_force, _obj.GetWorldCenter()); //Apply the force
			}		
			
			// We then crop the bounding box
			width = 40;
			height = 40;
			
			setUpEmitter();
		}		
		
		override public function update() : void
		{		
			/**
			 * If physics is simulating, this handles the changing of colors
			 * when there is movement
			 * Instead of checking for a collision, it just checks if they are moving
			 * as a cause of getting hit
			 */
			if ( Registry.isSimulating == true )
			{
				handleChangingOfColor();
			}
			
			handleTrailing();			
			
			if ( canDie == true )
			{
				kill();
			}
			
			super.update();
			
			/**
			 * This handles the ball placement
			 * If it is activated, it follows the mouse
			 * 
			 * This overrides the x and y manipulation from b2Circle
			 */
			if ( allowBallPlacement == true && isMainBall )
			{
				/*x = FlxG.mouse.x;
				y = FlxG.mouse.y;*/
			}
			
			/**
			 * This handles the relocating of red balls
			 */
			if ( Registry.relocateRedBalls == true && currentColor == RED )
			{
				var acceptableLocation: Boolean = false;
				while ( acceptableLocation == false )
				{
					// First we roll for a value
					x = FlxMath.rand( 50, FlxG.width - 50);
					y = FlxMath.rand( 50, FlxG.height - 50);
					
					// We then check if there is any objects in this position
					if ( FlxG.overlap(this, Registry.gBalls) == false )
					{
						trace("this is acceptable!");
						// IF there is none then this is an acceptable locatin
						acceptableLocation = true;
					}		
					else 
					{
						trace("not acceptable");
					}					
				}
								
				// We then move the actual object to this position
				_obj.SetPosition(new b2Vec2( (x + width /2 ) / ratio, (y + height / 2) / ratio ));
				
				// This counts all red balls and sees if all of them are relocated
				Registry.redBallsRelocated ++;
				if ( Registry.redBallsRelocated >= Registry.numberOfHazardBalls )
				{
					trace("stop relocating red balls");
					Registry.relocateRedBalls = false;
					Registry.redBallsRelocated = 0;
				}
			}
			
			if ( currentColor == RED && _obj.IsAwake() && !Registry.gui.isFirstTurn )
			{
				if ( hazardSign == null )
				{
					hazardSign = new HazardSign(x + 3, y + 3);
					Registry.gHazard.add(hazardSign);
					_obj.SetAwake(false);
				}
				else if ( hazardSign.alive == false )
				{
					trace("SEETTT");
					hazardSign.timespan = 3;
					hazardSign.alive = true;
					hazardSign.visible = true;
					hazardSign.x = x + 3;
					hazardSign.y = y + 3;
					_obj.SetAwake(false);
				}		
			}
		}
		
		private function handleChangingOfColor():void 
		{
			// Check if this ball's color is different from the mainball
			if ( currentColor != Registry.mainBall.currentColor )
			{				
				// Then check if this ball is moving
				if ( _obj.IsAwake() == true )
				{
					// IF this is not a hazard ball...
					if ( currentColor != Ball.RED )
					{
						// change the color according to the color of the mainball
						currentColor = Registry.mainBall.currentColor;
						updateColor();
						sfxBump.play(true);
					}
					else if ( currentColor == Ball.RED && !Registry.gui.isFirstTurn )
					{
						// Set scratch flag as true
						Registry.isScratched = true;
						trace("OMG SCRATCH!");
						sfxHazard.play(true);
					}
				}
			}
		}
		
		/**
		 * This just cycles the color from blue to red to green and back to blue
		 */
		public function switchColor():void 
		{
			if ( isMainBall == true )
			{
				if ( currentColor == BLUE )
				{
					currentColor = RED;
									}
				else if ( currentColor == RED )
				{
					currentColor = GREEN;
				}
				else if ( currentColor == GREEN )
				{
					currentColor = BLUE;					
				}
			}
			updateColor();
		}
		
		/**
		 * This handles the trailing and turns the emitter off
		 * when the ball is almost at stop
		 */
		private function handleTrailing():void 
		{
			if ( Registry.isSimulating == true )
			{
				if ( Math.abs(_obj.GetLinearVelocity().x ) >= 0.4 
					|| Math.abs(_obj.GetLinearVelocity().y ) >= 0.4 )
				{
					if ( emitter.on == false )
					{
						emitter.on = true;
					}
					emitter.x = x;
					emitter.y = y;
				}
				else
				{
					if ( emitter.on == true )
					{
						emitter.on = false;
					}
				}
			}
		}
		
		public function stopMoving() : void
		{
			_obj.SetLinearVelocity(new b2Vec2(0, 0));
		}
		
		public function updateColor():void 
		{
			if ( currentColor == BLUE )
			{
				play("blue");
			}
			else if ( currentColor == RED )
			{
				play("red");
			}
			else if ( currentColor == GREEN)
			{
				play("green");
			}
			
			setUpEmitter();
		}
		
		public function launch():void 
		{
			_force = new b2Vec2(0,0); // Reset to zero
			
			// Calculate for the x and y components of the force
			// according to the trajectory angle
			var xComponent: Number = launchSpeed * Math.cos(FlxVelocity.angleBetweenMouse(this, false));
			var yComponent: Number = launchSpeed * Math.sin(FlxVelocity.angleBetweenMouse(this, false));
			_force.Add(new b2Vec2(xComponent, yComponent));				
			
			FlxG.mouse.reset();
						
			// Only apply force if they are not null
			if ( _force.x || _force.y ) 
			{
				_obj.ApplyForce(_force, _obj.GetWorldCenter()); //Apply the force
			}
			
			isDocked = false;
			isMagnetized = false;
		}
		
		private function setUpEmitter():void 
		{
			Registry.gTrails.remove(emitter);
			emitter = new FlxEmitter(); //x and y of the emitter
			emitter.setSize(40, 40);
			emitter.setYSpeed(0, 0);
			emitter.setXSpeed(0, 0);
			emitter.setRotation(0, 0);
			emitter.gravity = 0;
			
			if ( currentColor == BLUE )
			{
				emitter.makeParticles(imgBlueTrail, 7, 0, true, 0);			 
			}
			else if ( currentColor == RED )
			{
				emitter.makeParticles(imgRedTrail, 7, 0, true, 0);			 
			}
			else if ( currentColor == GREEN )
			{
				emitter.makeParticles(imgGreenTrail, 7, 0, true, 0);			 
			}		
			
			Registry.gTrails.add(emitter);
			emitter.start(false, 2, 0.2, 0);
			emitter.on = false;
		}
		
		private function rollForColor():void 
		{
			// Roll for the color
			var colorRoll: int = Math.floor(Math.random() * 3);
			if ( colorRoll == 0 )
			{
				currentColor = RED;
				//_obj.SetUserData(RED);
			}
			else if ( colorRoll == 1 )
			{
				currentColor = GREEN;
				//_obj.SetUserData(GREEN);
			}
			else if ( colorRoll == 2 )
			{
				currentColor = BLUE;
				// _obj.SetUserData(BLUE);
			}
		}
	}
}