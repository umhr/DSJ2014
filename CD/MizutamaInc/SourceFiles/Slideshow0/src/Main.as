package
{
	import br.com.stimuli.loading.lazyloaders.LazyXMLLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		private var _bitmapList:Array = [];
		private var _countList:Array = new Array();
		private var _scaleList:Array = new Array();
		private var _count:uint;
		private var _stageWidth:int;
		private var _stageHeight:int;
		private var _proxy:Proxy = new Proxy();
		
		private var _lazyXMLLoader:LazyXMLLoader;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = "TL";
			
			_lazyXMLLoader = new LazyXMLLoader("images/config.xml", "theLazyLoader");
			_lazyXMLLoader.addEventListener(Event.COMPLETE, lazyXMLLoader_complete);
			_lazyXMLLoader.start();
		
		}
		
		private function lazyXMLLoader_complete(event:Event):void
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			var n:int = _lazyXMLLoader.items.length;
			for (var i:int = 0; i < n; i++)
			{
				var bitmap:Bitmap = _lazyXMLLoader.getBitmap("img" + i);
				_proxy.setBitmap(bitmap, i);
				var bitmapData:BitmapData = new BitmapData(bitmap.width, bitmap.height);
				bitmapData.draw(bitmap);
				_bitmapList[i] = new Bitmap(bitmapData, "auto", true);
				_countList[i] = 0;
				_bitmapList[i].alpha = 0;
				addChild(_bitmapList[i]);
			}
			stage_resize(null);
			stage.addEventListener(Event.RESIZE, stage_resize);
		}
		
		
		private function enterFrame(event:Event):void 
		{
			_count++;
			var length:int = _countList.length;
			var n:int = int(_count / 300) % length;
			var i:int;
			var cnt:Number = (_count % 300 + 1) / 300;
			
			for (i = 0; i < length; i++)
			{
				_proxy.list[i].visible = false;
			}
			
			if (cnt == 1 && n == length - 1)
			{
				for (i = 0; i < length; i++)
				{
					_countList[i] = 0;
				}
				_proxy.begin();
			}
			else
			{
				if (n < length - 1 && cnt > 0.9)
				{
					_countList[n + 1] += 1 / 330;
					_proxy.list[n + 1].visible = true;
				}
				_countList[n] += 1 / 330;
				_proxy.list[n].visible = true;
			}
			for (i = 0; i < length; i++)
			{
				slideSaver(i, _countList[i]);
			}
			_proxy.run(_bitmapList);
		
		}
		
		private function slideSaver(num:int, per:Number):void
		{
			if (per > 1)
			{
				per = 1
			}
			;
			var poz:int = _proxy.list[num].random;
			var _scale:Number;
			if (poz > 50)
			{
				_scale = 0.9 + per / 10;
			}
			else
			{
				_scale = 1 - per / 10;
			}
			if (poz % 7 == 0)
			{
				_proxy.list[num].x = (_stageWidth - _bitmapList[num].width) / 2;
				_proxy.list[num].y = (_stageHeight - _bitmapList[num].height) / 2;
			}
			else if (poz % 7 == 1)
			{
				_proxy.list[num].x = _stageWidth - _bitmapList[num].width + 2;
				_proxy.list[num].y = 0;
			}
			else if (poz % 7 == 2)
			{
				_proxy.list[num].x = _stageWidth - _bitmapList[num].width + 2;
				_proxy.list[num].y = _stageHeight - _bitmapList[num].height + 2;
			}
			else if (poz % 7 == 3)
			{
				_proxy.list[num].x = 0;
				_proxy.list[num].y = _stageHeight - _bitmapList[num].height + 2;
			}
			else if (poz % 7 == 4)
			{
				_proxy.list[num].x = 0;
				_proxy.list[num].y = 0;
			}
			else if (poz % 7 == 5)
			{
				_proxy.list[num].x = 0;
				_proxy.list[num].y = (_stageHeight - _bitmapList[num].height) / 2;
			}
			else if (poz % 7 == 6)
			{
				_proxy.list[num].x = _stageWidth - _bitmapList[num].width + 2;
				_proxy.list[num].y = (_stageHeight - _bitmapList[num].height) / 2;
			}
			
			_proxy.list[num].scaleX = _proxy.list[num].scaleY = _scaleList[num] * _scale;
			var alpha:Number = Math.min(1, per * 10);
			_proxy.list[num].alpha = alpha;
			if (num > 0 && (0.8 < alpha && alpha < 1))
			{
				_proxy.list[num - 1].visible = true;
			}
		}
		
		private function stage_resize(event:Event):void
		{
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			var n:int = _bitmapList.length;
			for (var i:int = 0; i < n; i++)
			{
				_scaleList[i] = (Math.max(_stageWidth / _proxy.list[i].originalWidth, _stageHeight / _proxy.list[i].originalHeight)) * 1.15;
			}
		}
	}
}

