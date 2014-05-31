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
		private var _photoSliderList:Array /*PhotoSlider*/;
		private var _timer:Timer;
		
		public function Canvas()
		{
			init();
		}
		
		private function init():void
		{
			if (stage)
				onInit();
			else
				addEventListener(Event.ADDED_TO_STAGE, onInit);
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
			var n:int = Math.floor(imgH / 32);
			for (var i:int = 0; i < n; i++)
			{
				var photoSlider:PhotoSlider = new PhotoSlider();
				var len:int = _lazyXMLLoader.items.length;
				for (var k:int = 0; k < len; k++) 
				{
					photoSlider.addBitmapData(_lazyXMLLoader.getBitmapData("img" + k), new Rectangle(0, i * 32, imgW, 32));
				}
				addChild(photoSlider);
				photoSlider.position = new Point(0, i);
				photoSlider.x = 0;
				photoSlider.y = i * 32;
				photoSlider.setMask();
				_photoSliderList.push(photoSlider);
			}
			
			_timer = new Timer(7000, 0);
			_timer.addEventListener(TimerEvent.TIMER, timer_timer);
			_timer.start();
			
			timer_timer(null);
		}
		
		private function timer_timer(e:TimerEvent):void
		{
			var n:int = _photoSliderList.length;
			for (var i:int = 0; i < n; i++)
			{
				var photoSlider:PhotoSlider = _photoSliderList[i];
				photoSlider.doTween(i * (n - i) * 5);
			}
		}
	}

}