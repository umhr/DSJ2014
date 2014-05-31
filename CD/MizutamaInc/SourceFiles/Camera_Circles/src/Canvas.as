package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var circleCanvas:Shape = new Shape();
		private var _cameraManager:CameraManager;
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
			
			setUp();
			
			addChild(circleCanvas);
		}
		
		private function setUp():void 
		{
			_cameraManager = CameraManager.getInstance();
			addChild(_cameraManager);
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			_cameraManager.enter();
			
			draw(_cameraManager.getBitmapData());
		}
		
		private function draw(bitmapData:BitmapData):void 
		{
			var scale:Number = 0.1;
			var miniBitmapData:BitmapData = new BitmapData(320 * scale, 240 * scale);
			miniBitmapData.draw(new Bitmap(bitmapData), new Matrix(scale, 0, 0, scale));
			
			circleCanvas.graphics.clear();
			circleCanvas.x = _cameraManager.rectangle.x;
			circleCanvas.y = _cameraManager.rectangle.y;
			circleCanvas.graphics.beginFill(0xffffff, 0.2);
			circleCanvas.graphics.drawRect(0, 0, _cameraManager.rectangle.width, _cameraManager.rectangle.height);
			circleCanvas.graphics.endFill();
			
			serch(miniBitmapData);
		}
		
		/**
		 * 
		 * @param	miniBitmapData
		 */
		private function serch(miniBitmapData:BitmapData):void 
		{
			var w:int = miniBitmapData.width;
			var h:int = miniBitmapData.height;
			
			var checkList:Vector.<Boolean> = new Vector.<Boolean>(w * h);
			
			for (var i:int = 0; i < h; i++) 
			{
				for (var j:int = 0; j < w; j++) 
				{
					if(!checkList[i * w + j]){
						var resultAR:Array = circleCheck(i, j, h, w, 1, miniBitmapData, checkList);
						var circleSize:int = resultAR[0];
						var circleRGB:int = resultAR[1];
						drawCircle(circleRGB, circleSize, w, i, j, checkList);
					}
				}
			}
		}
		
		/**
		 * 近い色で正方形をどこまで作れるかを探索します。
		 * @param	i
		 * @param	j
		 * @param	h
		 * @param	w
		 * @param	size
		 * @param	miniBitmapData
		 * @param	checkList
		 * @return	[size,rgb];
		 */
		private function circleCheck(i:int, j:int, h:int, w:int, size:int, miniBitmapData:BitmapData, checkList:Vector.<Boolean>):Array {
			var maxSize:int = 24; // 最小単位から何倍の大きさまで探査するか。小さくすると、全体的に小さな円で描かれる。
			var tolerance:int = 40; // 色の距離の許容度。小さくすると、色の差にシビアになる。
			var result:Array = [];
			
			var nearResult:Array;
			if(size == 1){
				nearResult = [0, miniBitmapData.getPixel(j, i)];
			}else {
				nearResult = nearColor(miniBitmapData.getVector(new Rectangle(j, i, size, size)));
			}
			
			if (nearResult[0] < tolerance) {
				result[0] = size;
				result[1] = nearResult[1];
				
				if (size < maxSize ) {
					if ((i < h - size) && (j < w - size) && !(j < w - size && checkList[i * w + j + size])) {
						var resultAR:Array = circleCheck(i, j, h, w, size + 1, miniBitmapData, checkList);
						if (resultAR.length > 0) {
							result[0] = resultAR[0];
							result[1] = resultAR[1];
						}
					}
				}
			}
			return result;
		}
		
		/**
		 * 円を描画します。
		 * @param	rgb
		 * @param	size
		 * @param	w
		 * @param	ti
		 * @param	tj
		 * @param	checkList
		 */
		private function drawCircle(rgb:int, size:int, w:int, ti:int, tj:int, checkList:Vector.<Boolean>):void {
			
			// 彩度を二倍に
			var argbData:ARGBData = new ARGBData();
			argbData.setByRGBUINT(rgb);
			rgb = argbData.getRGBBySaturation(2);
			
			var scale:Number = 10*_cameraManager.scale2;
			
			// 円を描く
			circleCanvas.graphics.beginFill(rgb);
			circleCanvas.graphics.drawCircle(scale * (tj + 0.5 * size), scale * (ti + 0.5 * size), scale * size * 0.5);
			circleCanvas.graphics.endFill();
			
			// 同じ場所に二重に描かないようにフラグを立てる。
			for (var i:int = 0; i < size; i++) 
			{
				for (var j:int = 0; j < size; j++) 
				{
					checkList[(ti + i) * w + tj + j] = true;
				}
			}
		}
		
		/**
		 * 色の近さを取得します。
		 * 
		 * @param	pixels
		 * @return	[average, rgb] 平均色からの平均距離、平均色
		 */
		private function nearColor(pixels:Vector.<uint>):Array 
		{
			var argbDataList:Vector.<ARGBData> = new Vector.<ARGBData>();
			var averageRGB:ARGBData = new ARGBData();
			
			// 色を取り出し、平均色を求める。
			var n:int = pixels.length;
			for (var i:int = 0; i < n; i++) 
			{
				var argbData:ARGBData = new ARGBData().setByUINT(pixels[i]);
				argbDataList[i] = argbData;
				averageRGB.r += argbData.r / n;
				averageRGB.g += argbData.g / n;
				averageRGB.b += argbData.b / n;
			}
			
			// 平均色からの距離を求める。知覚的な距離をつかう。
			var average:uint = 0;
			for (i = 0; i < n; i++) 
			{
				average += averageRGB.distanceByNTSCCoefficients(argbDataList[i]);
			}
			average /= n;
			
			return [average, averageRGB.rgb];
		}
		
	}
	
}