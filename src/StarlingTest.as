package
{
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.text.TextField;
    
    import starling.core.Starling;
    
    public class StarlingTest extends Sprite
    {

        //如果此变量是局部变量,starling不工作.
        private var starlnig:Starling;
        public function StarlingTest()
        {
            //Starling's TextFiled 在No_Scale 模式下无法工作（Ubuntu下测试）
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            starlnig = new Starling(StarlingRoot,stage);
            starlnig.start();
            
        }
    }
}