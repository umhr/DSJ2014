package front 
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class TextCanvas extends Sprite 
	{
		
		[Embed(source = "img0.jpg")]
		public var img0:Class;
		[Embed(source = "img1.jpg")]
		public var img1:Class;
		[Embed(source = "img2.jpg")]
		public var img2:Class;
		[Embed(source = "img3.jpg")]
		public var img3:Class;
		[Embed(source = "img4.jpg")]
		public var img4:Class;
		[Embed(source = "img5.jpg")]
		public var img5:Class;
		
		private var imgList:Vector.<Bitmap> = new Vector.<Bitmap>();
		
		public function TextCanvas() 
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
			
			imgList[0] = new img0() as Bitmap;
			imgList[1] = new img1() as Bitmap;
			imgList[2] = new img2() as Bitmap;
			imgList[3] = new img3() as Bitmap;
			imgList[4] = new img4() as Bitmap;
			imgList[5] = new img5() as Bitmap;
			
			var n:int = imgList.length;
			for (var i:int = 0; i < n; i++) 
			{
				imgList[i].scaleX = imgList[i].scaleY = stage.stageWidth / 4800;
				imgList[i].alpha = 0;
				addChild(imgList[i]);
			}
			
			//addChild(imgList[0]);
			imgList[0].alpha = 1;
			fade();
			
		}
		public function fade():void {
			var target:DisplayObjectContainer = this;
			Tween24.loop(0,
				Tween24.wait(10),
				Tween24.prop(imgList[1]).alpha(0).visible(true),
				Tween24.tween(imgList[1], 1).alpha(1),
				Tween24.prop(imgList[0]).visible(false),
				Tween24.wait(10),
				Tween24.prop(imgList[2]).alpha(0).visible(true),
				Tween24.tween(imgList[2], 1).alpha(1),
				Tween24.prop(imgList[1]).visible(false),
				Tween24.wait(10),
				Tween24.prop(imgList[3]).alpha(0).visible(true),
				Tween24.tween(imgList[3], 1).alpha(1),
				Tween24.prop(imgList[2]).visible(false),
				Tween24.wait(10),
				Tween24.prop(imgList[4]).alpha(0).visible(true),
				Tween24.tween(imgList[4], 1).alpha(1),
				Tween24.prop(imgList[3]).visible(false),
				Tween24.wait(10),
				Tween24.prop(imgList[5]).alpha(0).visible(true),
				Tween24.tween(imgList[5], 1).alpha(1),
				Tween24.prop(imgList[4]).visible(false),
				
				
				Tween24.wait(10),
				Tween24.prop(imgList[0]).alpha(1).visible(true),
				Tween24.tween(imgList[5], 1).alpha(0),
				Tween24.prop(imgList[5]).visible(false)
				
			).play();
		}
	}
	
}