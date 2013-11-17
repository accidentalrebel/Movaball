package
{	
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	import com.accidentalrebel.*;	
	
	[Frame(factoryClass="Preloader")] 
 
	public class Main extends FlxGame
	{		
		public function Main()
		{
			super(640, 480, MenuState, 1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			forceDebugger = true;
		}
	}
}