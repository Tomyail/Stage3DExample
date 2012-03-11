package test.ai
{
    import ai.VehicleProxy;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;

    public class TestVehicleProxy extends Sprite
    {
        private var _v:VehicleProxy;
        public function TestVehicleProxy(ct:Sprite)
        {
            var range:Rectangle = new Rectangle(0,0,800,600);
            var shape:Sprite = new Sprite();
            shape.graphics.beginFill(0);
            shape.graphics.drawTriangles(Vector.<Number>([10,0,-10,5,-10,-5]), Vector.<int>([0,1,2]));
            ct.addChild(shape);
            
            _v =  new VehicleProxy(shape,range);
            _v.velocity.x = 1;
            _v.velocity.y = 1;
            this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
        }
        
        private function onEnterFrame(e:Event):void
        {
            _v.update();
        }
    }
}