package  
{
	
	import br.com.stimuli.loading.lazyloaders.LazyXMLLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _magnifyingGlass:MagnifyingGlassManager = MagnifyingGlassManager.getInstance();
		private var _pointList:Vector.<Point>;
		private var _lazyXMLLoader:LazyXMLLoader;
		private var _launcher:Launcher = new Launcher();
		public function Canvas() 
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
			
			var n:int = Math.max(Multitouch.maxTouchPoints, 1);
			_pointList = new Vector.<Point>(n, true);
			for (var i:int = 0; i < n; i++) 
			{
				_pointList[i] = new Point();
			}
			
			move();
			
            _lazyXMLLoader = new LazyXMLLoader("images/config.xml", "theLazyLoader");
            _lazyXMLLoader.addEventListener(Event.COMPLETE, lazyXMLLoader_complete);
            _lazyXMLLoader.start();
			
			addChild(_magnifyingGlass);
			addChild(_launcher);
			
		}
		
		private function lazyXMLLoader_complete(e:Event):void 
		{
			_magnifyingGlass.bitmapData = _lazyXMLLoader.getBitmapData("img0");
			var n:int = _lazyXMLLoader.items.length;
			for (var i:int = 0; i < n; i++) 
			{
				_launcher.setBitmapData(_lazyXMLLoader.getBitmapData("img" + i));
			}
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function move():void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
			if (Multitouch.maxTouchPoints) {
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				stage.addEventListener(TouchEvent.TOUCH_MOVE, stage_touchMove);
			}
		}
		
		private function stage_touchMove(event:TouchEvent):void 
		{
			var id:int = event.touchPointID % Multitouch.maxTouchPoints;
			_pointList[id].x = event.localX;
			_pointList[id].y = event.localY;
		}
		
		private function stage_mouseMove(event:MouseEvent):void 
		{
			_pointList[0].x = mouseX;
			_pointList[0].y = mouseY;
		}
		
		private function stage_click(event:MouseEvent):void 
		{
			if(stage.displayState == "normal"){
				stage.displayState = "fullScreen";
			}else{
				stage.displayState = "normal";
			}
			_magnifyingGlass.scaling();
		}
		
		private function enterFrame(event:Event):void 
		{
			_magnifyingGlass.getZooms(_pointList);
		}
		
	}
	
}