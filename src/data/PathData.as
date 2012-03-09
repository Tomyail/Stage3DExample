package data
{
    public class PathData
    {
        public var id:int;
        public var x:Number;
        public var y:Number;
        private var _link:Vector.<int>
        
        public function PathData()
        {
            _link = new Vector.<int>();
        }
        public function addLinks(...args):void
        {
//            _link[_link.length-1] = id;
            for(var i:int = 0;i< args.length;i++)
            {
                _link[_link.length-1] = args[i];
            }
        }
        
        public function get link():Vector.<int>
        {
            return _link;
        }
        
    }
}