package
{
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass = "Preloader")]
	
	public class Loader extends Sprite
	{
		public function Loader():void
		{
			if (stage)
			{
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var game:Main = new Main;
			addChild(game);
		}
	}
}