package data
{
    public class IntVec2
    {
        public var x:int;
        public var y:int;
        public function IntVec2(x:int = 0,y:int = 0)
        {
            this.x = x;
            this.y = y;
        }
        
        public static function minus(subtrahend:IntVec2,minuend:IntVec2):IntVec2
        {
            var result:IntVec2 = new IntVec2(subtrahend.x - minuend.x,subtrahend.y - minuend.y);
            return result;
        }
        
        public function toString():String
        {
            return "x"+x+" y"+y;
        }
    }
}