package
{
	public class Utill
	{
		public static function shuffle(n:int):Array
		{
			var result:Array = new Array();
			for (var i:int = 0; i < n; i++)
			{
				result[i] = Math.random();
			}
			return result.sort(Array.RETURNINDEXEDARRAY);
		}
	}
}