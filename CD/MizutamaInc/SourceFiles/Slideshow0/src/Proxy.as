package
{
	public class Proxy
	{
		public var list:Array = [];
		private var _oldList:Array = [];
		private var _obj:Object = {};
		private var _itemList:Array = [];
		
		public function Proxy() { };
		
		public function setBitmap(arg:*, _id:*):void
		{
			var typeof_id:String = typeof _id;
			if (typeof_id == "number")
			{
				list[_id] = getObject(arg);
				_oldList[_id] = getObject(arg);
				_itemList[_id] = arg;
				_obj[_id] = getObject(arg);
			}
		}
		
		public function begin():void
		{
			for (var i:int = 0; i < list.length; i++)
			{
				list[i].scaleX = list[i].scaleY = 1;
				list[i].x = list[i].y = 0;
				list[i].alpha = 0;
				list[i].visible = false;
			}
			random();
		}
		
		public function random():void
		{
			for (var i:int = 0; i < list.length - 1; i++)
			{
				list[i]["random"] = int(Math.random() * 100);
			}
			list[list.length - 1]["random"] = 0;
		}
		
		public function run(ar:Array):void
		{
			for (var i:int = 0; i < ar.length; i++)
			{
				if (list[i].alpha != _oldList[i].alpha)
				{
					ar[i].alpha = _oldList[i].alpha = list[i].alpha;
				}
				if (list[i].scaleX != _oldList[i].scaleX)
				{
					ar[i].scaleX = _oldList[i].scaleX = list[i].scaleX;
				}
				if (list[i].scaleY != _oldList[i].scaleY)
				{
					ar[i].scaleY = _oldList[i].scaleY = list[i].scaleY;
				}
				if (list[i].visible != _oldList[i].visible)
				{
					ar[i].visible = _oldList[i].visible = list[i].visible;
				}
				if (list[i].x != _oldList[i].x)
				{
					ar[i].x = _oldList[i].x = list[i].x;
				}
				if (list[i].y != _oldList[i].y)
				{
					ar[i].y = _oldList[i].y = list[i].y;
				}
			}
		}
		
		private function getObject(arg:*):Object
		{
			var obj:Object = new Object();
			obj["alpha"] = arg.alpha;
			obj["originalWidth"] = arg.width;
			obj["originalHeight"] = arg.height;
			obj["visible"] = arg.visible;
			obj["x"] = arg.x;
			obj["y"] = arg.y;
			return obj;
		}
	}
}