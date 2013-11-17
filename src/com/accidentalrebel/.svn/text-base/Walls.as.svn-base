package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import Box2D.Dynamics.b2World;
	 
	public class Walls extends B2FlxTileblock
	{
		
		public function Walls(X:Number, Y:Number, Width:Number, Height:Number, World: b2World) 
		{
			super(X, Y, Width, Height, World);
			createBody();
			loadTiles(imgWallSample);
			
			tileWidth = 25;
			tileHeight = 25;
			
			_friction = 1;
			_bodyDef.linearDamping = 0;
			_bodyDef.angularDamping = 0;
			_restitution = 1;
			_density = 1;
		}
		
	}

}