package com.accidentalrebel 
{	
	/**
	 * ...
	 * @author Karlo
	 */

	import org.flixel.*;
	import com.accidentalrebel.B2Circle;
	 
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*
	 
	public class Ship extends B2Circle
	{		
		public var centerCoordinates: FlxPoint;
		public var _force:b2Vec2;
		
		public function Ship() 
		{
			super();
		}
		
		override public function init(X:Number, Y:Number, Radius: Number, World: b2World) : void
		{
			revive();
			super.init(X, Y, Radius, World);				
			
			// Set the width and height to override the automaically created ones
			width = Radius * 2;
			height = Radius * 2;

			centerCoordinates = new FlxPoint(0, 0);
			updateCenterCoordinates();
		}
		
		override public function update() : void
		{
			updateCenterCoordinates();						
			
			super.update();
			
			checkIfOutsideMap();
		}
		
		/**
		* If this goes outside the map, then kill it
		*/
		private function checkIfOutsideMap():void 
		{			
			if ( x < -50 || x > FlxG.width + 50 || y < 0 - 100 || y > FlxG.height + 50)
			{
				kill();
			}
		}
		
		/**
		 * Gets the center coordiantes
		 */
		private function updateCenterCoordinates():void 
		{
			centerCoordinates.x = x + ( width / 2);
			centerCoordinates.y = y + ( height / 2);
		}
		
		override public function kill() : void 
		{
			if ( !alive )
				return
				
			trace("killed");
			_obj.SetActive(false);
			
			active = false;
			solid = false;
			alive = false;
			
			super.kill();
		}
		
		override public function revive() : void 
		{
			if ( alive )
				return
				
			trace("revived");
			_obj.SetActive(true);
			
			active = true;
			solid = true;
			alive = true;
			
			super.revive();
		}
		
	}

}