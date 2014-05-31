package  
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	/**
	 * ...
	 * @author umhr
	 */
	public class CameraManager extends Sprite
	{
		private static var _instance:CameraManager;
		public function CameraManager(block:SingletonBlock){init();}
		public static function getInstance():CameraManager{
			if ( _instance == null ) {_instance = new CameraManager(new SingletonBlock());};
			return _instance;
		}
		
		private var _video:Video = new Video();
		private var _bitmapData:BitmapData;
		private var _scale:Number = 1;
		public var activating:Boolean = false;
		private var _count:uint = 0;
		private var _dx:Number = 0;
		private var _dy:Number = 0;
		private var _stageWidth:int = 0;
		public var rectangle:Rectangle = new Rectangle();
		private function init():void
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			var camera:Camera = Camera.getCamera();
			//カメラの存在を確認
			if (camera) {
				camera.setMode(160, 120, 30);
				camera.addEventListener(ActivityEvent.ACTIVITY, camera_activity);
				_video.attachCamera(camera);
				_scale = Math.min(320 / stage.stageWidth, 240 / stage.stageHeight);
				_dx = (320 - stage.stageWidth * _scale) * 0.5;
				_dy = (240 - stage.stageHeight * _scale) * 0.5;
				//_stageWidth = stage.stageWidth;
				_matrix = new Matrix( -1, 0, 0, 1, 320);
				scale2 = Math.max(stage.stageWidth / 320, stage.stageHeight / 240);
				_video.scaleX = -scale2;
				_video.scaleY = scale2;
				_video.x = int((stage.stageWidth - _video.width) * 0.5 + _video.width);
				_video.y = int((stage.stageHeight - _video.height) * 0.5);
				rectangle = new Rectangle(int((stage.stageWidth - _video.width) * 0.5), int((stage.stageHeight - _video.height) * 0.5));
				rectangle.width = scale2 * 320;
				rectangle.height = scale2 * 240;
				_video.filters = [new BlurFilter(16, 16)];
				addChild(_video);
				
				_bitmapData = new BitmapData(320, 240);
			} else {
				trace("カメラが見つかりませんでした。");
			}
		}
		
		private function camera_activity(event:ActivityEvent):void 
		{
			activating = true;
		}
		
		private var _matrix:Matrix;
		public var scale2:Number;
		/**
		 * カメラで取得した結果を_bitmapDataに保持する。
		 */
		public function enter():void {
			if (!activating) { return };
			if (_count % 4 == 0) {
				_bitmapData.draw(_video,_matrix);
			}
			_count ++;
		}
		
		public function getBitmapData():BitmapData {
			return _bitmapData;
		}
		
		/**
		 * 対応する座標の色を返す。
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function getPixel(x:int, y:int):int {
			if (!activating) { return 0x0 };
			var tx:int = x * _scale + _dx;
			var ty:int = y * _scale + _dy;
			return _bitmapData.getPixel(tx, ty);
		}
		
		public function get video():Video 
		{
			return _video;
		}
	}
	
}
class SingletonBlock { };