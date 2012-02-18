package
{
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;
    
    public class StarlingRoot extends Sprite
    {
        public function StarlingRoot()
        {
            //默认文本颜色和默认背景冲突都是黑色
            var tf:TextField = new TextField(100,100,"Test","Arial",12,0xff0000);
            //这里设置颜色无效
            tf.color = 0xff1111;
            addChild(tf);
            
            var quad:Quad = new Quad(50,50,0xff0000);
            addChild(quad);
            quad.y = tf.y+tf.height;
            
            //not work
            var image:Image = new Image(Texture.empty(64,64,0x00ff00));
//            addChild(image);
            image.y = quad.y+quad.height;
            
            var button:Button = new Button(Texture.empty(50,50,0x00ff00),"button");
//            addChild(button);
        }
    }
}