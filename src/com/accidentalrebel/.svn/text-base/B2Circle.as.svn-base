package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import org.flixel.*;
	 
	import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
	 
	public class B2Circle extends FlxSprite
	{
		/**
		 * Box2D Initialization
		 */
		public var ratio:Number;
 
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;
 
        public var _radius:Number;
        private var _world:b2World;
 
        //Physics params default value
        public var _friction:Number;
        public var _restitution:Number;
        public var _density:Number;
		public var bodyColor: String;
 
        //Default angle
        public var _angle:Number;
        //Default body type
        public var _type:uint;		
		
		public var dataToPass: Ball;
		
		public function B2Circle():void
		{
			
		}
		
		public function init(X:Number, Y:Number, Radius:Number, World:b2World) : void
		{
			/**
			 * Reinitialize values
			 */ 
			ratio = 30;
			_friction = 1;
			_restitution = 1;
			_density = 1;
	 		_angle = 0;
			_type = b2Body.b2_dynamicBody;		
			_bodyDef = new b2BodyDef();
			_bodyDef.angularDamping = 1;
			
			if ( Registry.gameMode == Registry.VERSUSMODE )
			{
				_bodyDef.linearDamping = 0.3;
			}
			else
			{
				_bodyDef.linearDamping = 0;
			}
			
			x = X;
			y = Y;
			
			_radius = Radius;
			_world = World;			
		}
		
		override public function update():void
        {
            x = (_obj.GetPosition().x * ratio) - _radius;
            y = (_obj.GetPosition().y * ratio) - _radius;
            // angle = _obj.GetAngle() * (180 / Math.PI);
            super.update();
        }
		
		public function createBody():void
        {
            _fixDef = new b2FixtureDef();
            _fixDef.friction = _friction;
            _fixDef.restitution = _restitution;
            _fixDef.density = _density;
            _fixDef.shape = new b2CircleShape(_radius/ratio);
 
            _bodyDef.position.Set((x + (_radius)) / ratio, (y + (_radius/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
			_bodyDef.userData = new Ball();			
			_bodyDef.userData = dataToPass;
			_bodyDef.allowSleep = true;
 
			if ( _obj != null )
			{
				trace("destroyed");
				_world.DestroyBody(_obj);
			}
			
            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
        }
	}

}