package utils
{
    import data.PathData;
    
    import display.GridUnit;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;

    public class MapPathManager
    {
        private var _pathDatas:Vector.<PathData>;
        private var _paths:Vector.<GridUnit>;
        private var _container:Sprite;
        private var l:int,i:int,j:int;
        public function MapPathManager(container:Sprite)
        {
            _container = container;
            _pathDatas = new Vector.<PathData>();
            _paths = new Vector.<GridUnit>();
        }
        
        public function createPaths():void
        {
            l = _pathDatas.length;
            var count:int = 0;
            for(i = 0;i< l;i++)
            {
                _paths[i] = new GridUnit(20,20);
                _paths[i].x = _pathDatas[i].x;
                _paths[i].y = _pathDatas[i].y;
                _container.addChild(_paths[i]);
                
                if(_pathDatas[i].link.length >0)
                {
                    for(j = 0;j<_pathDatas[i].link.length;j++)
                    {
                        draw(_pathDatas[i].x,_pathDatas[i].y,_pathDatas[_pathDatas[i].link[j]].x,_pathDatas[_pathDatas[i].link[j]].y);
                    }
                }
            }
        }
        
        public function set setPathDatas(datas:Vector.<PathData>):void
        {
            _pathDatas = datas;
        }
        
        private function draw(startX:Number,startY:Number,endX:Number,endY:Number):void
        {
            _container.graphics.lineStyle(1);
            _container.graphics.moveTo(startX,startY);
            _container.graphics.lineTo(endX,endY);
            _container.graphics.endFill();
        }
    }
}