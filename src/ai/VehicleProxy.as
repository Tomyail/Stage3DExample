package ai
{
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.geom.Vector3D;

    /**
     * 用来表示一个可视对象的坐标和速度（有方向）,并有一些接口让该对象进行基本的运动
     * @author tomyail
     * 
     */
    public class VehicleProxy
    {
        public static const WRAP:String = "wrap";
        public static const BOUNCE:String = "bounce";
        private var _position:Vector3D;
        private var _velocity:Vector3D;
        /**可视对象*/
        private var _shape:Sprite;
        /**可视对象的活动范围*/
        private var _range:Rectangle;
        private var _edgeBehavior:String = WRAP;
        public function VehicleProxy(shape:Sprite,range:Rectangle)
        {
            _position = new Vector3D();
            _velocity = new Vector3D();
            _shape = shape;
            _range = range;
        }
        
        public function update():void
        {
            _position.incrementBy(_velocity);
            
            _shape.x = _position.x;
            _shape.y = _position.y;
            _shape.rotation = Vector3D.angleBetween(_velocity,Vector3D.X_AXIS)*180/Math.PI;
        }
        
        
        
        /**遇到边界掉头*/
        private function bounce():void
        {
            if(_position.x > _range.right)
            {
                _position.x = _range.right;
                _velocity.x *= -1;
            }
            else if(_position.x < _range.left)
            {
                _position.x = _range.left;
                _velocity.x *= -1;
            }
            else if(_position.y > _range.bottom)
            {
                _position.y = _range.bottom;
                _velocity.y *= -1;
            }
            else if(_position.y < _range.top)
            {
                _position.y = _range.top;
                _velocity.y *= -1;
            }
        }
        
        /**遇到边界从相对面出来*/
        private function wrap():void
        {
            if(_position.x>_range.right) _position.x = _range.left;
            if(_position.x < _range.left) _position.x = _range.right;
            if(_position.y > _range.bottom) _position.y = _range.top;
            if(_position.y < _range.top) _position.y = _range.bottom;
        }

        /**边界处理类型*/
        public function get edgeBehavior():String
        {
            return _edgeBehavior;
        }

        /**
         * @private
         */
        public function set edgeBehavior(value:String):void
        {
            _edgeBehavior = value;
        }

        /**速度*/
        public function get velocity():Vector3D
        {
            return _velocity;
        }

        /**
         * @private
         */
        public function set velocity(value:Vector3D):void
        {
            _velocity = value;
        }

        /**坐标*/
        public function get position():Vector3D
        {
            return _position;
        }

        /**
         * @private
         */
        public function set position(value:Vector3D):void
        {
            _position = value;
        }
        
        
    }
}