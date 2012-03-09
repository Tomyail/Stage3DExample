package display
{
	import flash.display.Sprite;
	
	public class BrushShape extends Sprite
	{
		public function BrushShape()
		{
			this.graphics.beginFill(0);
			this.graphics.drawCircle(0,0,10);
			this.graphics.endFill();
		}
	}
}