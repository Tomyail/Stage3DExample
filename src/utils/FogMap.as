package utils
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    
    public class FogMap
    {
        private var _fogContainer:Sprite;
        private var _fogDraw:Sprite;
        private var _unfogArea:Shape;
        private var _fog:Object;
        private var _mapWidth:Number;
        private var _mapHeight:Number;
        private var _oldX:Number;
        private var _oldY:Number;
        private var _unfogUnitRadius:int
        
        /**
         * 实例化迷雾地图
         * @param fog 可以是一个颜色值也可以是一张雾图片
         * @param unfogUnit 去除雾的单元形状(对于传入的对象不考虑其颜色只考虑其形状)
         * @param background 背景图层
         */
        public function FogMap(fog:Object,background:DisplayObject,container:DisplayObjectContainer,unfogUnitRadius:int = 30)
        {
            _fog = fog;
            _unfogUnitRadius = unfogUnitRadius;
            _mapWidth = background.width;
            _mapHeight = background.height;
            
            
            
            _unfogArea = new Shape;
            _fogContainer = new Sprite;
            container.addChild(_fogContainer);
            container.addChild(background);
            
            background.mask = _unfogArea
            
            if(_fog is uint)
            {
                _fogContainer.graphics.beginFill(_fog as uint);
                _fogContainer.graphics.drawRect(0,0,_mapWidth,_mapHeight);
                _fogContainer.graphics.endFill();
            }
            else if(_fog is DisplayObject)
            {
                _fogContainer.addChildAt(fog as DisplayObject,0);
            }
            else
            {
                throw new Error("fog type error");
            }
                
            
            container.addChild(_unfogArea);
            
        }
        
        public function reset():void
        {
            if(_fog is uint)
            {
                _fogContainer.graphics.clear();
                _fogContainer.graphics.beginFill(_fog as uint);
                _fogContainer.graphics.drawRect(0,0,_mapWidth,_mapHeight);
                _fogContainer.graphics.endFill();
            }
            else if(_fog is DisplayObject)
            {
                if(_fogContainer.contains(_fog as DisplayObject))
                {
                    _fogContainer.removeChild(_fog as DisplayObject);
                }
                _fogContainer.addChildAt(_fog as DisplayObject,0);
            }
            _unfogArea.graphics.clear();
            _oldX = NaN;
        }
        
        public function seeAt(x:Number,y:Number):void
        {
            _unfogArea.graphics.beginFill(0);
            _unfogArea.graphics.drawCircle(x,y,_unfogUnitRadius);
            _unfogArea.graphics.endFill();
            _oldX = x;
            _oldY = y;
        }
        
        public function seeTo(x:Number,y:Number):void
        {
        }
    }
}