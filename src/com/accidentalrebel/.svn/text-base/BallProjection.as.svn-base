package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo Licudine
	 */
	import org.flixel.FlxSprite
	 
	public class BallProjection extends FlxSprite
	{
		[Embed(source = '../../assets/ballRings.png')]public var imgBallRings: Class;
		
		public function BallProjection(X: Number = 0, Y: Number = 0)		
		{
			loadGraphic(imgBallRings, false, false, 40, 40);
			addAnimation("blue", [0], 0, false);
			addAnimation("red", [1], 0, false);
			addAnimation("green", [2], 0, false);
			
			updateColor();
			
			alpha = 0.5;
		}
		
		public function updateColor():void 
		{
			if ( Registry.mainBall.currentColor == Ball.BLUE )
			{
				play("blue");
			}
			else if ( Registry.mainBall.currentColor == Ball.RED )
			{
				play("red");
			}
			else if ( Registry.mainBall.currentColor == Ball.GREEN )
			{
				play("green");
			}
		}
		
	}

}