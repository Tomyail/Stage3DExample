package
{
	import display.BrushShape;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 笔刷测试 
	 * 修改自http://bit.ly/wTfZyp
     * 基本原理:
     * 让一个图形跟着鼠标走动,让bitmapdata在帧刷新中绘制整个舞台.
	 */
	public class Brush extends Sprite
	{
        /**当前定义的笔刷,用于跟随鼠标显示*/
		private var _brush:BrushShape;
        
		private var oldX:Number;
		private var oldY:Number;
		private var isDown:Boolean = false;
        private var bmpd:BitmapData;
        private var bmp:Bitmap;
        private var b_mc:Sprite;
        private var brush_mc:Sprite;
		public function Brush()
		{
			_brush = new BrushShape();
			addChild(_brush);
			
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
            
            //注意场景内和场景外的结果差距
            bmpd=new BitmapData(800,600);
            bmp=new Bitmap(bmpd);
            brush_mc=new Sprite();
            addChild(brush_mc);
            
            b_mc=new Sprite();
            addChild(b_mc);
            b_mc.addChild(bmp);
            
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			isDown=true;
			_brush.x=mouseX;
			_brush.y=mouseY;
			_brush.startDrag();
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			isDown=false;
			oldX=NaN;
			_brush.stopDrag();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (! isDown) {
				return;
			}
			if (! isNaN(oldX)) {
				b_mc.graphics.beginFill(0xff0000,.3);
				b_mc.graphics.moveTo(_brush.x-_brush.width/2,_brush.y-_brush.height/2);
				b_mc.graphics.lineTo(_brush.x+_brush.width/2,_brush.y+_brush.height/2);
				b_mc.graphics.lineTo(oldX+_brush.width/2,oldY+_brush.height/2);
				b_mc.graphics.lineTo(oldX-_brush.width/2,oldY-_brush.height/2);
//				为防止鼠标移动速度过快，计算老坐标和新坐标直接的距离，在两个坐标中间填充若干笔触
				var disX:Number=mouseX-oldX;
				var disY:Number=mouseY-oldY;
				var dis:Number=Math.sqrt(oldX*oldX+oldY*oldY);
				
				var count:int=Math.floor(dis/15);
				for (var i:int=0; i<count; i++) {
					var brush:BrushShape=new BrushShape();
					brush_mc.addChild(brush);
					brush.x=(disX/count)*(i+1)+oldX;
					brush.y=(disY/count)*(i+1)+oldY;
				}
				bmpd.draw(this);
				//删除填充的笔触
				while (brush_mc.numChildren>0) {
					brush_mc.removeChildAt(0);
				}
			}
			oldX=_brush.x;
			oldY=_brush.y;
		}
	}
}