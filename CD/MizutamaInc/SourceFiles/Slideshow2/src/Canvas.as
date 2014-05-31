package  
{
	
	import br.com.stimuli.loading.lazyloaders.LazyXMLLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _lazyXMLLoader:LazyXMLLoader;
		private var _photoSliderList:Array/*PhotoSlider*/;
		private var _timer:Timer;
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
			
			_lazyXMLLoader = new LazyXMLLoader("images/config.xml", "theLazyLoader");
			_lazyXMLLoader.addEventListener(Event.COMPLETE, lazyXMLLoader_complete);
			_lazyXMLLoader.start();
			
		}
		
		private function lazyXMLLoader_complete(e:Event):void 
		{
			var imgW:int = _lazyXMLLoader.getBitmapData("img0").width;
			var imgH:int = _lazyXMLLoader.getBitmapData("img0").height;
			_photoSliderList = [];
			var w:int = Math.floor(imgW / 64);
			var h:int = Math.floor(imgH / 64);
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					var photoSlider:PhotoSlider = new PhotoSlider();
					var len:int = _lazyXMLLoader.items.length;
					for (var k:int = 0; k < len; k++) 
					{
						photoSlider.addBitmapData(_lazyXMLLoader.getBitmapData("img"+k), new Rectangle(i * 64, j * 64, 64, 64));
					}
					addChild(photoSlider);
					photoSlider.position = new Point(i, j);
					photoSlider.x = i * 64;
					photoSlider.y = j * 64;
					photoSlider.setMask();
					_photoSliderList.push(photoSlider);
				}
			}
			
			_timer = new Timer(10000, 0);
			_timer.addEventListener(TimerEvent.TIMER, timer_timer);
			_timer.start();
			
			timer_timer(null);
		}
		
		private function timer_timer(e:TimerEvent):void 
		{
			var n:int = _photoSliderList.length;
			for (var i:int = 0; i < n; i++) 
			{
				var isVertical:Boolean = (_timer.currentCount + i) % 2 == 0;
				var photoSlider:PhotoSlider = _photoSliderList[i];
				photoSlider.doTween((photoSlider.position.x + photoSlider.position.y) * 150, isVertical);
			}
		}
	}
	
}