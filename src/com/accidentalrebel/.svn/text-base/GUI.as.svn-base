package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import org.flixel.*;
	 
	public class GUI extends FlxSprite
	{
		[Embed(source = '../../assets/gui/centerSpread.png')]private var imgCenterSpread: Class;
		[Embed(source = '../../assets/hazardSign.png')]private var imgHazardSign: Class;		
		
		private var revealStepper: Number = 0;
		private var lineNumber:Number = 0;
		private var _launcher: Launcher;
		
		private var currentAnimation: int = 0;
		public var waitingForKeypress:Boolean = false;
		public var textMain:FlxText;
		public var textSub:FlxText;
		public var isFirstTurn: Boolean = true;
		
		public var icon: HazardSign;
		
		//Enums
		static public var REVEALING: int = 0;
		static public var HIDING: int = 1;
		static public var NONE: int = 2;
		
		public function GUI(launcher: Launcher) 
		{
			super(0, 0);
			
			_launcher = launcher;
			
			visible = false;
			
			loadGraphic(imgCenterSpread, true, false, 643, 86);
			
			x = 0;
			y = ( FlxG.height / 2 ) - ( height / 2);
			
			addAnimation("reveal", [5, 5, 5, 4, 3 , 2, 1, 0], 25, false);
			addAnimation("hide", [0, 1, 2, 3, 4, 5], 25, false);
			
			textMain = new FlxText( (FlxG.width / 2) - 150, y + 20, 300, "test");
			textMain.visible = false;
			textMain.size = 18;
			textMain.color = 0xff69d7f3;
			
			textSub = new FlxText( (FlxG.width / 2) - 150, y + 45, 400, "sub text");
			textSub.size = 12;
			textSub.visible = false;
			
			/**
			 * Set up the icon
			 */
			icon = new HazardSign( (FlxG.width / 2) - 150 - 45, y + 25, -1);
			icon.visible = false;
			
			Registry.gForeground.add(icon);
			Registry.gForeground.add(textMain);
			Registry.gForeground.add(textSub);
		}
		
		public function reveal() : void 
		{						
			visible = true;
			play("reveal", true);		
			currentAnimation = REVEALING;
			_launcher.canLaunch = false;
		}
		
		public function hide() : void 
		{
			hideText();
			icon.visible = false;
			play("hide", true);
			currentAnimation = HIDING;
			trace("called");
			FlxG.mouse.reset();
			_launcher.canLaunch = true;		
		}
		
		override public function update():void 
		{
			/**
			 * This handles what happens when an animation is finished
			 */
			if ( finished == true )
			{					
				if ( currentAnimation == REVEALING )
				{				
					showText();					
					
					if ( isFirstTurn )
					{	
						textMain.text = "First Turn: Player 1";	
						textSub.text = "Click any mouse button to continue";
					}		
					else if ( Registry.isLevelFinished == true )
					{
						if ( Registry.playersTurn == Registry.PLAYER1 )
						{							
							textMain.text = "Player 1 wins the game!";						
						}
						else if ( Registry.playersTurn == Registry.PLAYER2 )
						{							
							textMain.text = "Player 2 wins the game!";							
						}
						textSub.text = "Click on your mouse to go back to the main menu";
					}
					else
					{
						if ( Registry.playersTurn == Registry.PLAYER1 )
						{
							textMain.text = "Next Turn: Player 1";
						}
						else
						{
							textMain.text = "Next Turn: Player 2";
						}
						textSub.text = "Click any mouse button to continue";
					}					
					
					
					if ( Registry.isScratched && Registry.isLevelFinished == false) 
					{
						icon.visible = true;
						
						if ( Registry.playersTurn == Registry.PLAYER1 )
						{
							textMain.text = "Player 2 has hit red ball";
							textSub.text = "Player 1 can position their ball anywhere";
						}
						else
						{
							textMain.text = "Player 1 has hit red ball";
							textSub.text = "Player 2 can position their ball anywhere";
						}						
					}
					
					showText();
				}
				else if ( currentAnimation == HIDING )
				{
					trace("hiding animation finished");
					visible = false;
					isFirstTurn = false;
					Registry.isScratched = false;
				}
				currentAnimation = NONE;				
			}
			
			/**
			 * This handles the keypress
			 */
			if ( FlxG.mouse.justPressed() && waitingForKeypress == true && Registry.isLevelFinished == false  )
			{				
				if ( visible == true )
				{
					hide();
				}
				else if ( visible == false )
				{
					reveal();
				}
				waitingForKeypress = false;				
			}
		}
		
		private function showText():void 
		{
			textMain.visible = true;
			textSub.visible = true;
			waitingForKeypress = true;			
		}
		
		private function hideText() : void
		{
			textMain.visible = false;
			textSub.visible = false;
		}
	}
}