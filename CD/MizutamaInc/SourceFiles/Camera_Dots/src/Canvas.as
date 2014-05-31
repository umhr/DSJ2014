package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _viewCanvas:ViewCanvas = ViewCanvas.getInstance();
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
			
			
			CameraManager.getInstance().addEventListener(Event.ACTIVATE, activate);
			
			addChild(CameraManager.getInstance());
			
			addChild(_viewCanvas);
		}
		
		private function activate(e:Event):void 
		{
			CameraManager.getInstance().removeEventListener(Event.ACTIVATE, activate);
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			_viewCanvas.enterFrame();
		}
	}
	
}