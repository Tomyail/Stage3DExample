package display
{
    import data.IntVec2;
    
    import display.GridUnit;
    
    import flash.display.Sprite;

    public class GridMap extends Sprite
    {
        private var _grids:Vector.<Vector.<GridUnit>>;
        private var _highLightColor:uint;
        private var _defaultColor:uint;
        private var _col:int;
        private var _row:int
        public function GridMap(hightColor:uint = 0x33,defaultColor:uint = 0x333333)
        {
            _highLightColor = hightColor;
            _defaultColor = defaultColor;
        }
        /**
         * 创建地图 
         * @param col 列数(x)
         * @param row 行数(y)
         * @param size 每个单元的长宽
         */
        public function createMap(col:int,row:int,size:Number = 30):void
        {
            _col = col;
            _row = row;
            _grids ? _grids.length = 0:_grids = new Vector.<Vector.<GridUnit>>;
            for(var i:int = 0;i<col;i++)
            {
                _grids[i] = new Vector.<GridUnit>();
                for(var j:int = 0;j<row;j++)
                {
                    _grids[i][j] = new GridUnit(size,size,_defaultColor);
                    _grids[i][j].x = size * i;
                    _grids[i][j].y = size * j;
                    this.addChild(_grids[i][j]);
                }
            }
        }
        
        public function clear():void
        {
            for(var i:int = 0;i<_col;i++)
            {
                for(var j:int = 0;j<_row;j++)
                {
                    _grids[i][j].setColor(_defaultColor);
                }
            }
        }
        
        public function drawPaths(datas:Vector.<IntVec2>):void
        {
            var l:int = datas.length;
            for(var i:int = 0;i<l;i++)
            {
                _grids[datas[i].x][datas[i].y].setColor(_highLightColor);
            }
        }
        
    }
}