package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 1024, height = 768, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = "noScale";
			stage.align = "TL";

			var canvas:Canvas = new Canvas();
			addChild(canvas);
			//canvas.x = int((stage.stageWidth - 640) * 0.5);
			//canvas.y = int((stage.stageHeight - 480) * 0.5);
		}
		
	}
	
}