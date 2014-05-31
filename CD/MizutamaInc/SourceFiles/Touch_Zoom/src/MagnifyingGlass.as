package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class MagnifyingGlass extends Sprite 
	{
		private var _bitmap:Bitmap;
		private var _dimeter:Number = 50;
		private var _shape:Shape = new Shape();
		public function MagnifyingGlass() 
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
			
			//_shape.alpha = 0.7;
			addChild(_shape);
		}
		
		public function getZooms(pointList:Vector.<Point>):void {
			_shape.graphics.clear();
			var n:int = pointList.length;
			for (var i:int = 0; i < n; i++) 
			{
				getZoom(pointList[i].x, pointList[i].y);
			}
			
		}
		private function getZoom(x:Number, y:Number):void {
			
			var tx:Number = (x - _bitmap.x)/ _bitmap.scaleX;
			var ty:Number = (y - _bitmap.y)/ _bitmap.scaleY;
			
			tx -= x;
			ty -= y;
			
			_shape.graphics.lineStyle(3, 0xFFFFFF);
			_shape.graphics.beginBitmapFill(_bitmap.bitmapData, new Matrix(1, 0, 0, 1, -tx, -ty), false, false);
			_shape.graphics.drawCircle(x, y, _dimeter);
			_shape.graphics.endFill();
			
		}
		
		public function set bitmapData(value:BitmapData):void 
		{
			
			_bitmap = new Bitmap(value, "auto", true);
			scaling();
			_bitmap.x = int((stage.stageWidth - _bitmap.width) * 0.5);
			_bitmap.y = int((stage.stageHeight - _bitmap.height) * 0.5);
			addChildAt(_bitmap, 0);
			
		}
		
		public function scaling():void {
			_bitmap.scaleX = _bitmap.scaleY = 1;
			_bitmap.scaleX = _bitmap.scaleY = Math.max(stage.stageWidth / _bitmap.width, stage.stageHeight / _bitmap.height);
			_dimeter = Math.min(stage.stageWidth, stage.stageHeight) * 0.1;
		}
		
	}
	
	
}