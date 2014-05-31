package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	/**
	 * ...
	 * @author umhr
	 */
	public class Launcher extends Sprite
	{
		private var thumbList:Vector.<Sprite> = new Vector.<Sprite>();
		public function Launcher() 
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
			
		}
		
		public function setBitmapData(bitmapData:BitmapData):void {
			var thumb:Sprite = new Sprite();
			thumb.graphics.beginFill(0x000000, 0.5);
			thumb.graphics.drawRoundRect(0, 0, 110, 110, 8, 8);
			thumb.graphics.endFill();
			
			var bitmap:Bitmap = new Bitmap(bitmapData, "auto", true);
			bitmap.width = 100;
			bitmap.scaleY = bitmap.scaleX;
			bitmap.x = 5;
			bitmap.y = 5 + int((100 - bitmap.height) * 0.5);
			thumb.addChild(bitmap);
			thumb.x = 5 + 115 * thumbList.length;
			thumb.y = 5;
			addChild(thumb);
			
			thumb.addEventListener(MouseEvent.MOUSE_UP, thumb_touchTap);
			if (Multitouch.maxTouchPoints) {
				thumb.addEventListener(TouchEvent.TOUCH_TAP, thumb_touchTap);
			}
			thumbList.push(thumb);
			
			graphics.clear();
			graphics.beginFill(0x333333, 0.7);
			graphics.drawRoundRect(0, 0, thumbList.length * 115 + 5, 120, 8, 8);
			graphics.endFill();
		}
			
		private function thumb_touchTap(event:Event):void 
		{
			var sprite:Sprite = event.target as Sprite;
			var bitmap:Bitmap = sprite.getChildAt(0) as Bitmap;
			
			MagnifyingGlassManager.getInstance().bitmapData = bitmap.bitmapData;
			
		}
		
	}

}