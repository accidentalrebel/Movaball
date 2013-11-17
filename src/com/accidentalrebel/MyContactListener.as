package com.accidentalrebel
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.*;
	import Box2D.Common.Math.*;
	import Box2D.Common.*;

	import Box2D.Common.b2internal;
	use namespace b2internal;

	public class MyContactListener extends b2ContactListener
	{
		/**
		 * Called when two fixtures begin to touch.
		 */
		override public virtual function BeginContact(contact:b2Contact):void 
		{ 
			/*var object1: * = contact.GetFixtureA().GetBody().GetUserData();
			var object2: * = contact.GetFixtureB().GetBody().GetUserData();
			
			// Only trigger if both objects are enemies
			if ( object1 is Ball && object2 is Ball )
			{
				// If the colliding enemies are not equal, kill them both
				if ( object1.currentColor != object2.currentColor )
				{
					object2.currentColor = object1.currentColor;
					object2.updateColor();
					//
					//We use canDie instead of kill because we can only
					//call kill() before the update of the object ends
					//
					//object1.canDie = true;
					//object2.canDie = true;
				}
				//else // If they are equal, then add score
				//{
				//	trace("SCORE!");
				//}
			}*/
			
		}

		/**
		 * Called when two fixtures cease to touch.
		 */
		override public virtual function EndContact(contact:b2Contact):void { }

		/**
		 * This is called after a contact is updated. This allows you to inspect a
		 * contact before it goes to the solver. If you are careful, you can modify the
		 * contact manifold (e.g. disable contact).
		 * A copy of the old manifold is provided so that you can detect changes.
		 * Note: this is called only for awake bodies.
		 * Note: this is called even when the number of contact points is zero.
		 * Note: this is not called for sensors.
		 * Note: if you set the number of contact points to zero, you will not
		 * get an EndContact callback. However, you may get a BeginContact callback
		 * the next step.
		 */
		override public virtual function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void {}

		/**
		 * This lets you inspect a contact after the solver is finished. This is useful
		 * for inspecting impulses.
		 * Note: the contact manifold does not include time of impact impulses, which can be
		 * arbitrarily large if the sub-step is small. Hence the impulse is provided explicitly
		 * in a separate data structure.
		 * Note: this is only called for contacts that are touching, solid, and awake.
		 */
		override public virtual function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void { }
		
		b2internal static var b2_defaultListener:b2ContactListener = new b2ContactListener();
	}
	
}

	