package  
{
	
	import br.com.stimuli.loading.lazyloaders.LazyXMLLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _lazyXMLLoader:LazyXMLLoader;
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
			var imgW:int = _lazyXMLLoader.getBitmapData(_lazyXMLLoader.items[0].url).width;
			var imgH:int = _lazyXMLLoader.getBitmapData(_lazyXMLLoader.items[0].url).height;
			
			var w:int = Math.ceil(stage.stageWidth/imgW);
			var h:int = Math.ceil(stage.stageHeight/imgH);
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					var photoSlider:PhotoSlider = new PhotoSlider();
					var len:int = _lazyXMLLoader.items.length;
					for (var k:int = 0; k < len; k++) 
					{
						photoSlider.addBitmapData(_lazyXMLLoader.getBitmapData("img" + k));
					}
					addChild(photoSlider);
					photoSlider.x = i * imgW;
					photoSlider.y = j * imgH;
					photoSlider.start();
				}
			}
		}
	}
	
}