package
{
    import flash.display.Sprite;
    import flash.events.Event;
    
    import test.utils.TestPathDatasAdapter;
    
    public class Tester extends Sprite
    {
        public function Tester()
        {
            addEventListener(Event.ADDED_TO_STAGE,init);
        }
        
        
        private function init(e:Event):void
        {
            var testPathDatasAdapter:TestPathDatasAdapter = new TestPathDatasAdapter();
        }
    }
}