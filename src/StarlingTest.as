package
{
    import flash.display.Sprite;
    
    import starling.core.Starling;
    
    public class StarlingTest extends Sprite
    {

        //如果此变量是局部变量,starling不工作.
        private var starlnig:Starling;
        public function StarlingTest()
        {
            starlnig = new Starling(StarlingRoot,stage);
            starlnig.start();
        }
    }
}