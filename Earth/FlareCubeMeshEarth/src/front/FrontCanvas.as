package front 
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author umhr
	 */
	public class FrontCanvas extends Sprite 
	{
		private var _title:TitleCanvas = new TitleCanvas();
		private var _title2:TextCanvas = new TextCanvas();
		
		public function FrontCanvas() 
		{
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			
			addChild(_title2);
			addChild(_title);
			
			var timer:Timer = new Timer(15*1000, 0);
			timer.addEventListener(TimerEvent.TIMER, timer_timer);
			timer.start();
		}
		
		private function timer_timer(e:TimerEvent):void 
		{
			var shuffleList:Array = shuffle(3);
			
			var stageWidth:int = stage.stageWidth;
			var stageHeight:int = stage.stageHeight;
			
			var titleX:int = 0;
			var titleY:int = 0;
			var rtmfpX:int = 0;
			var rtmfpY:int = 0;
			
			titleX = shuffleList[0] * (stageWidth / 3);
			titleX += (stageWidth / 3 - _title.width) * 0.5;
			titleY = int((stageHeight-_title.height) * 0.5);
			
			rtmfpX = shuffleList[1] * (stageWidth / 3);
			rtmfpX += (stageWidth / 3 - _title2.width) * 0.5;
			rtmfpY = int((stageHeight-_title2.height) * 0.5);
			
			Tween24.parallel(
				Tween24.tween(_title, 2, Ease24._5_QuintInOut).x(titleX),
				Tween24.tween(_title, 2, Ease24._5_QuintInOut).y(titleY),
				Tween24.tween(_title2, 2, Ease24._5_QuintInOut).x(rtmfpX),
				Tween24.tween(_title2, 2, Ease24._5_QuintInOut).y(rtmfpY)
			).play();
			
		}
		
		private function shuffle(num:int):Array {
			var _array:Array = new Array();
			for (var i:int = 0; i < num; i++) {	
				_array[i] = Math.random();
			}
			return _array.sort(Array.RETURNINDEXEDARRAY);
		}
	}
	
}