package
{
    import flash.display.Sprite;
    import flash.events.Event;
    
    import test.ai.TestVehicleProxy;
    import test.utils.TestMapPathManager;
    import test.utils.TestPathDatasAdapter;
    
    public class Tester extends Sprite
    {
        private var _layer:Sprite;
        public function Tester()
        {
            _layer = new Sprite();
            addEventListener(Event.ADDED_TO_STAGE,init);
        }
        
        
        private function init(e:Event):void
        {
//            var testPathDatasAdapter:TestPathDatasAdapter = new TestPathDatasAdapter();
            var testMapPathManager:TestMapPathManager = new TestMapPathManager(this,_layer);
//            var testVehicleProxy:TestVehicleProxy = new TestVehicleProxy(this);
        }
    }
}