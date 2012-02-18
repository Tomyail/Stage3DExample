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
            var t:Texture = Texture.empty();
            var image:Image = new Image(Texture.empty());
//            addChild(image);
            
            var button:Button = new Button(Texture.empty(),"Test");
            addChild(button);
            
            
            var tf:TextField = new TextField(50,50,"asdasd");
            addChild(tf);
        }
    }
}