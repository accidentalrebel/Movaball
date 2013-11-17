package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import Box2D.Dynamics.b2World;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	 
	public class Bullet extends Ship
	{
		[Embed(source = '../../assets/ship.png')]public var imgShip: Class;
		
		private var _thrustAcc:Number;		
		private var _maxThrust:Number;
		private var _launchAngle: Number;
		public var launcher: Launcher;
		
		private var hasLaunched: Boolean;
		
		public static var bulletWidth: Number = 25;
		public static var bulletHeight: Number = 25;
		
		public function Bullet() 
		{			
			super();
		}
		
		override public function init(X: Number, Y: Number, Radius: Number, World: b2World) : void
		{
			/**
			 * Initialize all values
			 */
			_thrustAcc = 600;		
			_maxThrust = 600;
			_launchAngle = -45;
			launcher = null;			
			hasLaunched = false;
			
			super.init(X, Y, Radius, World);
			
			loadGraphic(imgShip, false, false, 25, 25, false);
		}
		
		override public function update() : void
		{
			/*if ( hasLaunched == false && FlxG.mouse.justPressed() )
			{
				hasLaunched = true;
				launchBullet();
			}*/			
			
			super.update();
			
			// Stick to the launcher it it has not been launched yet
			if (hasLaunched == false )
			{
				_obj.SetPosition(new b2Vec2( (launcher.x + 22)/ratio, (launcher.y + 22) /ratio))
			}		
		}
		
		public function launch():void 
		{
			_force = new b2Vec2(0,0); // Reset to zero
			
			// Calculate for the x and y components of the force
			// according to the trajectory angle
			var xComponent: Number = _thrustAcc * Math.cos(FlxVelocity.angleBetweenMouse(this, false));
			var yComponent: Number = _thrustAcc * Math.sin(FlxVelocity.angleBetweenMouse(this, false));
			_force.Add(new b2Vec2(xComponent, yComponent));				
			
			FlxG.mouse.reset();
						
			// Only apply force if they are not null
			if ( _force.x || _force.y ) 
			{
				_obj.ApplyForce(_force, _obj.GetWorldCenter()); //Apply the force
			}
			hasLaunched = true;
		}
		
	}

}