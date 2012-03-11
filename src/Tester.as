package
{
    import flash.display.Sprite;
    import flash.events.Event;
    
    import test.ai.TestVehicleProxy;
    import test.utils.TestMapPathManager;
    import test.utils.TestPathDatasAdapter;
    
    public class Tester extends Sprite
    {
        public function Tester()
        {
            addEventListener(Event.ADDED_TO_STAGE,init);
        }
        
        
        private function init(e:Event):void
        {
//            var testPathDatasAdapter:TestPathDatasAdapter = new TestPathDatasAdapter();
//            var testMapPathManager:TestMapPathManager = new TestMapPathManager(this);
            var testVehicleProxy:TestVehicleProxy = new TestVehicleProxy(this);
        }
    }
}