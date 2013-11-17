package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import org.flixel.*;
	 
	public class HazardSign extends FlxSprite
	{
		[Embed(source='../../assets/hazardSign.png')]private var imgHazardSign: Class;
		public var timespan:Number;
		
		public function HazardSign(X: Number, Y:Number, Timespan:Number = 3) 
		{
			super(X, Y);
			
			visible = false;
			alive = false;
			
			loadGraphic(imgHazardSign, true, false, 34, 29);
			addAnimation("stand", [0], 0, false);
			addAnimation("spin", [0, 1, 2, 3, 4, 3, 2, 1], 24, true);
			play("stand");
			
			timespan = Timespan;
		}
		
		override public function update():void 
		{
			// Don't kill if timespan == -1
			if ( timespan != -1 )
			{
				timespan -= FlxG.elapsed;
				if ( timespan <= 0 )
				{
					alive = false;
					visible = false;
				}
			}			

			super.update();
		}
		
	}

}