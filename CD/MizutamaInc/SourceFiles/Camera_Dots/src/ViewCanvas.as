package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author umhr
	 */
	public class ViewCanvas extends Sprite 
	{
		private static var _instance:ViewCanvas;
		public function ViewCanvas(block:Block){init();};
		public static function getInstance():ViewCanvas{
			if ( _instance == null ) {_instance = new ViewCanvas(new Block());};
			return _instance;
		}
		
		private var _bitmap:Bitmap;
		private var _blurBitmap:Bitmap;
		private const FADE:ColorTransform = new ColorTransform(1.1, 1.1, 1.1, 1);
		private var _cameraManager:CameraManager = CameraManager.getInstance();
		private var _stageWidth:int;
		private var _stageHeight:int;
		private var _circleR:Number;
		private function init():void
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			
			_bitmap = new Bitmap(new BitmapData(_stageWidth, _stageHeight, false, 0xFF000000));
			addChild(_bitmap);
			_circleR = Math.max(_stageWidth / 40, _stageHeight / 40);
			_blurBitmap = new Bitmap(new BitmapData(_circleR*10, _circleR*10, true, 0xFFFFFFFF));
		}
		
		public function enterFrame(e:Event = null):void 
		{
			setBlur();
			setBlur();
			
			_cameraManager.enter();
			
			drawTextSet();
			
		}
		
		private function setBlur():void 
		{
			var tx:int = Math.random() * _stageWidth - 50;
			var ty:int = Math.random() * _stageHeight - 50;
			
			_blurBitmap.bitmapData.fillRect(_blurBitmap.bitmapData.rect, 0x00000000);
			_blurBitmap.bitmapData.draw(_bitmap, new Matrix(1, 0, 0, 1, -tx, -ty));
			
			_bitmap.bitmapData.draw(_blurBitmap, new Matrix(1, 0, 0, 1, tx, ty), FADE);
		}
		
		private function drawTextSet():void 
		{
			var tx:int;
			var ty:int;
			var n:int = 100;
			for (var i:int = 0; i < n; i++) 
			{
				tx = _stageWidth * Math.random();
				ty = _stageHeight * Math.random();
				drawText(tx, ty);
			}
		}
		
		private var _charctor:Bitmap;
		private function drawText(tx:int,ty:int):void 
		{
			var rgb:int = _cameraManager.getPixel(tx, ty);
			
			if (_charctor) {
				var scale:Number = Math.random()*0.8 + 0.1;
				_bitmap.bitmapData.draw(_charctor, new Matrix(scale, 0, 0, scale, tx-10, ty-10),Utils.colorFromRGB(rgb),null,null,true);
			}else {
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0x0);
				shape.graphics.drawCircle(_circleR, _circleR, _circleR);
				shape.graphics.endFill();
				
				_charctor = new Bitmap(new BitmapData(_circleR*2, _circleR*2, true, 0x0));
				_charctor.bitmapData.draw(shape);
				
			}
			
		}
		
	}
	
}
class Block { };