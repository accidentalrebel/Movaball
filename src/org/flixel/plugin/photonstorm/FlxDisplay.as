/**
 * FlxDisplay
 * -- Part of the Flixel Power Tools set
 * 
 * v1.3 Added "screenWrap", "alphaMask" and "alphaMaskFlxSprite" methods
 * v1.2 Added "space" method
 * v1.1 Updated for the Flixel 2.5 Plugin system
 * 
 * @version 1.3 - June 15th 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel.plugin.photonstorm 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	import flash.filters.ColorMatrixFilter;
	
	public class FlxDisplay 
	{
		static private var value:Number = 0;
		
		public function FlxDisplay() 
		{
		}
		
		public function pad():void
		{
			//	Pad the sprite out with empty pixels left/right/above/below it
		}
		
		public function flip():void
		{
			//	mirror / reverse?
			//	Flip image data horizontally / vertically without changing the angle
		}
		
		/**
		 * Takes two source images (typically from Embedded bitmaps) and puts the resulting image into the output FlxSprite.<br>
		 * Note: It assumes the source and mask are the same size. Different sizes may result in undesired results.<br>
		 * It works by copying the source image (your picture) into the output sprite. Then it removes all areas of it that do not<br>
		 * have an alpha color value in the mask image. So if you draw a big black circle in your mask with a transparent edge, you'll<br>
		 * get a circular image appear. Look at the mask PNG files in the assets/pics folder for examples.
		 * 
		 * @param	source		The source image. Typically the one with the image / picture / texture in it.
		 * @param	mask		The mask to apply. Remember the non-alpha zero areas are the parts that will display.
		 * @param	output		The FlxSprite you wish the resulting image to be placed in (will adjust width/height of image)
		 * 
		 * @return	The output FlxSprite for those that like chaining
		 */
		public static function alphaMask(source:Class, mask:Class, output:FlxSprite):FlxSprite
		{
			var data:BitmapData = (new source).bitmapData;
			
			data.copyChannel((new mask).bitmapData, new Rectangle(0, 0, data.width, data.height), new Point, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);			
			
			output.pixels = data;
			
			return output;
		}
		
		/**
		 * EDITED: For Trendsetter<br/>
		 * Takes the image data from two FlxSprites and puts the resulting image into the output FlxSprite.<br>
		 * Note: It assumes the source and mask are the same size. Different sizes may result in undesired results.<br>
		 * It works by copying the source image (your picture) into the output sprite. Then it removes all areas of it that do not<br>
		 * have an alpha color value in the mask image. So if you draw a big black circle in your mask with a transparent edge, you'll<br>
		 * get a circular image appear. Look at the mask PNG files in the assets/pics folder for examples.
		 * 
		 * @param	source		The source FlxSprite. Typically the one with the image / picture / texture in it.
		 * @param	mask		The FlxSprite containing the mask to apply. Remember the non-alpha zero areas are the parts that will display.
		 * @param	output		The FlxSprite you wish the resulting image to be placed in (will adjust width/height of image)
		 * 
		 * @return	The output FlxSprite for those that like chaining
		 */
		public static function alphaMaskFlxSprite(source:FlxSprite, mask:FlxSprite, output:FlxSprite, xOffset: Number, yOffset: Number):FlxSprite
		{			
			var data:BitmapData = source.pixels;
			
			//data.copyChannel(mask.pixels, new Rectangle(xOffset, yOffset, mask.width, mask.height), new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			//data.copyPixels(source.pixels, new Rectangle(-xOffset, -yOffset, mask.width, mask.height), new Point(0, 0), mask.pixels, new Point, false);		
			data.copyPixels(source.pixels, new Rectangle(-xOffset, -yOffset, mask.width, mask.height), new Point(0, 0), mask.pixels, new Point, false);		
			
			output.pixels = data;
			
			return output;
		}	
		
		/**
		 * For trendsetter: Changes the hue of the sprite
		 * @param	source
		 * @param	mask
		 * @param	output
		 * @param	xOffset
		 * @param	yOffset
		 * @return
		 */
		public static function changeHUE(source:FlxSprite, redValue:Number, greenValue:Number, blueValue:Number):FlxSprite
		{			
			var data:BitmapData = source.pixels;
			//var data: BitmapData = FlxG.addBitmap(Graphic, Reverse, Unique);			
			
			//data.copyChannel(mask.pixels, new Rectangle(xOffset, yOffset, mask.width, mask.height), new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			/*data.copyPixels(mask.pixels, new Rectangle(-xOffset, -yOffset, mask.width, mask.height), new Point(0, 0), source.pixels, new Point, true);*/
			/*value += 0.1;
			trace(value);*/			
			
			var matrix:Array = new Array();			
			
			matrix=matrix.concat([redValue,0,0,0,0]);// red
			matrix=matrix.concat([0,greenValue,0,0,0]);// green
			matrix=matrix.concat([0,0,blueValue,0,0]);// blue			
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			
			data.applyFilter(data, new Rectangle(0, 0, source.width, source.height), new Point(), new ColorMatrixFilter(matrix));
			
			/*const rc:Number = 1/3, gc:Number = 1/3, bc:Number = 1/3;
			data.applyFilter(data, data.rect, new Point(), new ColorMatrixFilter([rc, gc, bc, 0, 0,rc, gc, bc, 0, 0, rc, gc, bc, 0, 0, 0, 0, 0, 1, 0]));*/
			
			source.pixels = data;
			
			return source;
			//return null;
		}		
		
		public static function resetColor(source:FlxSprite, setToBlack:Boolean = false ): FlxSprite
		{
			var data:BitmapData = source.pixels;
			var matrix:Array = new Array();	
			trace(setToBlack);
			
			if ( setToBlack == false )
			{
				matrix = matrix.concat([1,1,1,1,0]);// red
				matrix = matrix.concat([1,1,1,1,0]);// green
				matrix = matrix.concat([1,1,1,1,0]);
				matrix = matrix.concat([0,0,0,1,0]);
			}
			else 
			{
				matrix=matrix.concat([0,0,0,0,0]);// red
				matrix=matrix.concat([0,0,0,0,0]);// green
				matrix = matrix.concat([0, 0, 0, 0, 0]);
				matrix = matrix.concat([0, 0, 0, 1, 0]);
			}			
			
			data.applyFilter(data, new Rectangle(0, 0, source.width, source.height), new Point(), new ColorMatrixFilter(matrix));
			
			source.pixels = data;
			
			return source;
		}
		
		public static function changeBrightness(source:FlxSprite, brighten: Boolean ): FlxSprite
		{
			var data:BitmapData = source.pixels;
			var matrix:Array = new Array();	
						
			if ( brighten == false )
			{
				matrix=matrix.concat([0.90,0,0,0,0]);// red
				matrix=matrix.concat([0,0.90,0,0,0]);// green
				matrix = matrix.concat([0, 0, 0.90, 0, 0]);
				matrix = matrix.concat([0, 0, 0, 1, 0]);		
			}
			else 
			{
				matrix=matrix.concat([1.1,0,0,0,0]);// red
				matrix=matrix.concat([0,1.1,0,0,0]);// green
				matrix = matrix.concat([0, 0, 1.1, 0, 0]);
				matrix = matrix.concat([0, 0, 0, 1, 0]);		
			}
						
			
			data.applyFilter(data, new Rectangle(0, 0, source.width, source.height), new Point(), new ColorMatrixFilter(matrix));
			
			source.pixels = data;
			
			return source;
		}
		
		/**
		 * Checks the x/y coordinates of the source FlxSprite and keeps them within the area of 0, 0, FlxG.width, FlxG.height (i.e. wraps it around the screen)
		 * 
		 * @param	source				The FlxSprite to keep within the screen
		 */
		public static function screenWrap(source:FlxSprite):void
		{
			if (source.x < 0)
			{
				source.x = FlxG.width;
			}
			else if (source.x > FlxG.width)
			{
				source.x = 0;
			}
			
			if (source.y < 0)
			{
				source.y = FlxG.height;
			}
			else if (source.y > FlxG.height)
			{
				source.y = 0;
			}
		}
		
		/**
		 * Takes the bitmapData from the given source FlxSprite and rotates it 90 degrees clockwise.<br>
		 * Can be useful if you need to control a sprite under rotation but it isn't drawn facing right.<br>
		 * This change overwrites FlxSprite.pixels, but will not work with animated sprites.
		 * 
		 * @param	source		The FlxSprite who's image data you wish to rotate clockwise
		 */
		public static function rotateClockwise(source:FlxSprite):void
		{
		}
		
		/**
		 * Aligns a set of FlxSprites so there is equal spacing between them
		 * 
		 * @param	sprites				An Array of FlxSprites
		 * @param	startX				The base X coordinate to start the spacing from
		 * @param	startY				The base Y coordinate to start the spacing from
		 * @param	horizontalSpacing	The amount of pixels between each sprite horizontally (default 0)
		 * @param	verticalSpacing		The amount of pixels between each sprite vertically (default 0)
		 * @param	spaceFromBounds		If set to true the h/v spacing values will be added to the width/height of the sprite, if false it will ignore this
		 */
		public static function space(sprites:Array, startX:int, startY:int, horizontalSpacing:int = 0, verticalSpacing:int = 0, spaceFromBounds:Boolean = false):void
		{
			var prevWidth:int = 0;
			var prevHeight:int = 0;
			
			for (var i:int = 0; i < sprites.length; i++)
			{
				var sprite:FlxSprite = sprites[i];
				
				if (spaceFromBounds)
				{
					sprite.x = startX + prevWidth + (i * horizontalSpacing);
					sprite.y = startY + prevHeight + (i * verticalSpacing);
				}
				else
				{
					sprite.x = startX + (i * horizontalSpacing);
					sprite.y = startY + (i * verticalSpacing);
				}
			}
		}
		
		/**
		 * Centers the given FlxSprite on the screen, either by the X axis, Y axis, or both
		 * 
		 * @param	source	The FlxSprite to center
		 * @param	xAxis	Boolean true if you want it centered on X (i.e. in the middle of the screen)
		 * @param	yAxis	Boolean	true if you want it centered on Y
		 * 
		 * @return	The FlxSprite for chaining
		 */
		public static function screenCenter(source:FlxSprite, xAxis:Boolean = true, yAxis:Boolean = false):FlxSprite
		{
			if (xAxis)
			{
				source.x = (FlxG.width / 2) - (source.width / 2);
			}
			
			if (yAxis)
			{
				source.y = (FlxG.height / 2) - (source.height / 2);
			}

			return source;
		}
		
	}

}