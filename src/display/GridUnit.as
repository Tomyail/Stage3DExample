package display
{
    import flash.display.Sprite;
    
    public class GridUnit extends Sprite
    {
        private var _color:uint;
        private var _width:Number;
        private var _height:Number;
        public function GridUnit(width:Number,height:Number,color:uint = 0x333333)
        {
            this._width = width;
            this._height = height;
            this._color = color;
            draw(_width,_height,_color);
        }
        
        
        public function setColor(color:uint):void
        {
            this._color = color;
            draw(_width,_height,_color);
        }
        
        private function draw(width:Number,height:Number,color:uint):void
        {
            this.graphics.beginFill(color);
            this.graphics.lineStyle(1);
            this.graphics.drawRect(0,0,width,height);
            this.graphics.endFill();
        }

    }
}