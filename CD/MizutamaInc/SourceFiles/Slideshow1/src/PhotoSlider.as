package  
{
	
	import a24.tween.Ease24;
	import a24.tween.EventTween24;
	import a24.tween.Tween24;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class PhotoSlider extends Sprite 
	{
		private var _bitmapList:Array/*Bitmap*/ = [];
		private var _count:int = 0;
		public function PhotoSlider() 
		{
			init();
		}
		
		public function addBitmapData(bitmapData:BitmapData):void 
		{
			_bitmapList.push(new Bitmap(bitmapData.clone()));
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
		}
		
		public function start():void {
			var maskShape:Shape = new Shape();
			maskShape.graphics.beginFill(0xFF0000);
			maskShape.graphics.drawRect(0, 0, _bitmapList[0].width, _bitmapList[0].height);
			maskShape.graphics.endFill();
			addChild(maskShape);
			mask = maskShape;
			
			_count = Math.floor(Math.random() * _bitmapList.length);
			setTween();
		}
		
		private function setTween(e:EventTween24 = null):void 
		{
			_count += Math.ceil(Math.random() * (_bitmapList.length - 1));
			//_count ++;
			_count %= _bitmapList.length;
			var target:Bitmap = _bitmapList[_count];
			if (Math.random() > 0.5) {
				target.x = target.width * (Math.round(Math.random()) * 2 - 1);
			}else {
				target.y = target.height * (Math.round(Math.random()) * 2 - 1);
			}
			addChild(target);
			Tween24.tween(target, 1, Ease24._1_SineOut).xy(0, 0).onComplete(setTween).play();
			
		}
	}
	
}