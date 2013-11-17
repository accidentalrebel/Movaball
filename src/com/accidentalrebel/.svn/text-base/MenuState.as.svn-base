package com.accidentalrebel 
{
	/**
	 * ...
	 * @author Karlo
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	 
	public class MenuState extends FlxState
	{				
		[Embed(source = '../../assets/gui/frontBG.png')]private var imgFrontBG: Class;
		[Embed(source = '../../assets/gui/btnLeft.png')]private var imgBtnLeft: Class;
		[Embed(source = '../../assets/gui/btnRight.png')]private var imgBtnRight: Class;
		[Embed(source = '../../assets/gui/HowToPlay.png')]private var imgHowToPlay: Class;
		[Embed(source = '../../assets/Music/DanceWithAPandaNew.mp3')]private var mscDanceWithAPanda: Class;
		[Embed(source = '../../assets/SFX/sfxBump.mp3')]private var sBump: Class;
		[Embed(source = '../../assets/SFX/sfxSelect.mp3')]private var sSelect: Class;
		
		private var bg: FlxSprite;
		private var numOfBallsPerPlayer: FlxText;
		private var numOfHazardBalls: FlxText;
		private var btnIncNumOfBallsPerPlayer: FlxButtonPlus;
		private var btnDecNumOfBallsPerPlayer: FlxButtonPlus;
		private var btnIncNumOfHazardBalls: FlxButtonPlus;
		private var btnDecNumOfHazardBalls: FlxButtonPlus;
		private var btnStartGame: FlxButtonPlus;
		private var btnHowToPlay:FlxButtonPlus;
		private var howToPlayScreen: FlxSprite;
		private var sfxBump: FlxSound;
		private var sfxSelect: FlxSound;
		
		override public function create():void
		{
			FlxG.mouse.show();
			
			Registry.BGMusic = new FlxSound();
			Registry.BGMusic.loadEmbedded(mscDanceWithAPanda, true, false);
			Registry.BGMusic.play();
			
			sfxBump = new FlxSound();
			sfxBump.loadEmbedded(sBump, false, true);
			sfxBump.volume = 0.8;
			
			sfxSelect = new FlxSound();
			sfxSelect.loadEmbedded(sSelect, false, true);
			sfxSelect.volume = 0.8;
			
			Registry.numberOfBallsPerPlayer = 10;
			Registry.numberOfHazardBalls = 3;
			
			bg = new FlxSprite(0, 0, imgFrontBG);
			add(bg);
			
			btnStartGame = new FlxButtonPlus(170, 350, startGame, null, "Start Game", 150, 28);
			btnStartGame.textNormal.size = 14;
			btnStartGame.textHighlight.size = 14;
			btnStartGame.updateActiveButtonColors([0xff30578c8, 0xff0578c8]);
			btnStartGame.updateInactiveButtonColors([0xff3eaefc, 0xff0578c8]);
			// btnStartGame.screenCenter();
			add(btnStartGame);
			
			btnHowToPlay = new FlxButtonPlus(330, 350, showHowToPlay, null, "How to Play", 150, 28);
			btnHowToPlay.textNormal.size = 14;
			btnHowToPlay.textHighlight.size = 14;
			btnHowToPlay.updateActiveButtonColors([0xff30578c8, 0xff0578c8]);
			btnHowToPlay.updateInactiveButtonColors([0xff3eaefc, 0xff0578c8]);
			// btnStartGame.screenCenter();
			add(btnHowToPlay);
			
			btnDecNumOfBallsPerPlayer = new FlxButtonPlus(150, 238, decrementNumOfBalls, null, null, 10, 13);
			btnDecNumOfBallsPerPlayer.setGraphic(imgBtnLeft, false, false, 10, 13);
			btnDecNumOfBallsPerPlayer.buttonHighlight.loadGraphic(imgBtnLeft, false, false, 10, 13);
			add(btnDecNumOfBallsPerPlayer);
			
			btnIncNumOfBallsPerPlayer = new FlxButtonPlus(210, 238, incrementNumOfBalls, null, null, 10, 13);
			btnIncNumOfBallsPerPlayer.setGraphic(imgBtnRight, false, false, 10, 13);
			btnIncNumOfBallsPerPlayer.buttonHighlight.loadGraphic(imgBtnRight, false, false, 10, 13);
			add(btnIncNumOfBallsPerPlayer);
			
			btnDecNumOfHazardBalls = new FlxButtonPlus(150, 288, decrementNumOfHazards, null, null, 10, 13);
			btnDecNumOfHazardBalls.setGraphic(imgBtnLeft, false, false, 10, 13);
			btnDecNumOfHazardBalls.buttonHighlight.loadGraphic(imgBtnLeft, false, false, 10, 13);
			add(btnDecNumOfHazardBalls);
			
			btnIncNumOfHazardBalls = new FlxButtonPlus(210, 288, incrementNumOfHazards, null, null, 10, 13);
			btnIncNumOfHazardBalls.setGraphic(imgBtnRight, false, false, 10, 13);
			btnIncNumOfHazardBalls.buttonHighlight.loadGraphic(imgBtnRight, false, false, 10, 13);
			add(btnIncNumOfHazardBalls);
			
			numOfBallsPerPlayer = new FlxText(180, 235, 300, "3");
			numOfBallsPerPlayer.size = 14;
			add(numOfBallsPerPlayer);
			
			numOfHazardBalls = new FlxText(180, 285, 350, "1");
			numOfHazardBalls.size = 14;
			add(numOfHazardBalls);
			
			Registry.numberOfBallsPerPlayer = 3;
			Registry.numberOfHazardBalls = 1;
			
			howToPlayScreen = new FlxSprite(0, 0, imgHowToPlay);
			howToPlayScreen.kill();			
			add(howToPlayScreen);			
		}	
		
		private function incrementNumOfHazards():void 
		{			
			if ( Registry.numberOfHazardBalls < 10 )
			{
				Registry.numberOfHazardBalls++;
				numOfHazardBalls.text = "" + Registry.numberOfHazardBalls;				
				sfxBump.play(true);
			}		
		}
		
		private function decrementNumOfHazards():void 
		{
			if ( Registry.numberOfHazardBalls > 0 )
			{
				Registry.numberOfHazardBalls--;
				numOfHazardBalls.text = "" + Registry.numberOfHazardBalls;	
				sfxBump.play(true);
			}
		}
		
		private function incrementNumOfBalls():void 
		{
			if ( Registry.numberOfBallsPerPlayer < 10 )
			{
				Registry.numberOfBallsPerPlayer++;
				numOfBallsPerPlayer.text = "" + Registry.numberOfBallsPerPlayer;
				sfxBump.play(true);
			}			
		}
		
		private function decrementNumOfBalls():void 
		{
			if ( Registry.numberOfBallsPerPlayer > 2 )
			{
				Registry.numberOfBallsPerPlayer--;
				numOfBallsPerPlayer.text = "" + Registry.numberOfBallsPerPlayer;
				sfxBump.play(true);
			}	
		}
		
		private function startGame():void 
		{
			Registry.gameMode = Registry.VERSUSMODE;
			FlxG.switchState(new PlayState());
			Registry.BGMusic.play(true);
			sfxSelect.play(true);
		}
		
		override public function update(): void
		{			
			/*if ( FlxG.keys.justPressed("SPACE") || FlxG.mouse.justPressed() )
			{
				Registry.gameMode = Registry.VERSUSMODE;
				FlxG.switchState(new PlayState());
			}
			else if ( FlxG.keys.justPressed("P") )
			{
				Registry.gameMode = Registry.ACTIONMODE;
				FlxG.switchState(new PlayState());
			}*/
			
			/**
			 * VIsual debug toggle
			 */
			if ( FlxG.keys.justPressed("B"))
			{
				if ( FlxG.visualDebug == false )
				{
					FlxG.visualDebug = true;
				}
				else
				{
					FlxG.visualDebug = false;
				}
			}
			
			/**
			 * This handles the closing of the how to play screen
			 */
			if ( howToPlayScreen.alive == true && FlxG.mouse.justReleased() )
			{				
				trace("dumaandito");				
				howToPlayScreen.kill();
				btnDecNumOfBallsPerPlayer.active = true;
				btnDecNumOfHazardBalls.active = true;
				btnHowToPlay.active = true;
				btnIncNumOfBallsPerPlayer.active = true;
				btnIncNumOfHazardBalls.active = true;
				btnStartGame.active = true;
				sfxSelect.play(true);
			}
			
			super.update();
			
		}
		
		private function showHowToPlay():void 
		{
			FlxG.mouse.reset();
			howToPlayScreen.revive();
			btnDecNumOfBallsPerPlayer.active = false;
			btnDecNumOfHazardBalls.active = false;
			btnHowToPlay.active = false;
			btnIncNumOfBallsPerPlayer.active = false;
			btnIncNumOfHazardBalls.active = false;
			btnStartGame.active = false;
			sfxSelect.play(true);
		}
	}
}