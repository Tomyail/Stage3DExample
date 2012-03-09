package
{
    import display.BrushShape;
    import utils.FogMap;
    
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    
    public class WarFogTest extends Sprite
    {
        [Embed(source = "../media/images/googleLogo.png")]
        private var bgClass:Class;
        private var bg:Bitmap;
        private var warFog:FogMap;
        private var mx:int,my:int;
        public function WarFogTest()
        {
            bg = new bgClass;
            this.graphics.beginFill(0x00ff00);
//            this.graphics.drawRect(0,0,500,500);
            warFog = new FogMap(0xff0000,bg,this);
            warFog.seeTo(10,50);
            warFog.seeTo(60,60);
            warFog.seeTo(70,70);
            warFog.seeTo(80,80);
            
            this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
//            this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
            mx = 0;
            my = 0;
        }
        
        private function onKeyDown(e:KeyboardEvent):void
        {
            if(e.keyCode == Keyboard.C)
            {
                warFog.reset();
            }
        }
        
        
        private function onEnterFrame(e:Event):void
        {
            warFog.seeTo(mx+1,my+1);
        }
        
        private function onMouseMove(e:MouseEvent):void
        {
            warFog.seeTo(mouseX,mouseY);
        }
    }
}