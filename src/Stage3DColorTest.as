package
{
    import com.adobe.utils.AGALMiniAssembler;
    import com.bit101.components.HSlider;
    import com.bit101.components.PushButton;
    
    import flash.display.Sprite;
    import flash.display.Stage3D;
    import flash.display3D.Context3D;
    import flash.display3D.Context3DBlendFactor;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Context3DVertexBufferFormat;
    import flash.display3D.IndexBuffer3D;
    import flash.display3D.Program3D;
    import flash.display3D.VertexBuffer3D;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Matrix3D;
    
    import starling.utils.VertexData;
    
    import utils.Color;
    
    public class Stage3DColorTest extends Sprite
    {
        private var _vertexData:VertexData;
        private var _stage3D:Stage3D;
        private var _context3D:Context3D;
        private var _vertexBuff:VertexBuffer3D;
        private var _indexBuff:IndexBuffer3D;
        
        private const VERTICES_NUM:int = 3;
        private var _program3D:Program3D;
        private var _projectionMatrix:Matrix3D;
        public function Stage3DColorTest()
        {
            _stage3D = stage.stage3Ds[0];
            stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE,onContextCreate);
            _stage3D.requestContext3D();
            createUI();
        }
        
        private function createUI():void
        {
            for(var i:int = 0;i<3;i++)
            {
                var btn:PushButton = new PushButton(this,0,40*i,i.toString(),btnClickHandler);
                btn.name = "b"+i;
                var slider:HSlider = new HSlider(this,0,btn.y+btn.height,sliderChangeHandler);
                slider.name = "s"+i;
                slider.tick = 0.1;
                slider.minimum = 0;
                slider.maximum = 1;
            }
        }
        
        private function sliderChangeHandler(e:Event):void
        {
//            trace("Alpha",e.target.value)
            _vertexData.setAlpha(int(e.target.name.charAt(1)),e.target.value);
            updateVertexBuff();
        }
        
        private function btnClickHandler(e:MouseEvent):void
        {
            var color:uint = Math.random()*0xffffff;
            _vertexData.setColor(int(e.target.name.charAt(1)),color);
            e.target.label = Color.hexTorgb(color);
            updateVertexBuff();
        }
        
        protected function onContextCreate(event:Event):void
        {
            _context3D = _stage3D.context3D;
            _context3D.enableErrorChecking = true;
            trace(_context3D.driverInfo);
            _context3D.configureBackBuffer(stage.stageWidth,stage.stageHeight,0);
            //使3D舞台颜色和原生舞台颜色区分开来
            _context3D.clear();
            //显示颜色
            _context3D.present();
            
            _vertexData = new VertexData(VERTICES_NUM,true);
            _vertexData.setPosition(0,0,1);
            _vertexData.setPosition(1,-1,-1);
            _vertexData.setPosition(2,1,-1);
            _vertexData.setUniformColor(0xffffff);
            _vertexBuff = _context3D.createVertexBuffer(VERTICES_NUM,VertexData.ELEMENTS_PER_VERTEX);
            updateVertexBuff();
            
            _indexBuff = _context3D.createIndexBuffer(VERTICES_NUM);
            var index:Vector.<uint> = Vector.<uint>([0,1,2]);
            _indexBuff.uploadFromVector(index,0,3);
            
            var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
            vertexAssembler.assemble(Context3DProgramType.VERTEX,
                "m44 op, va0, vc0  \n" +        // 4x4 matrix transform to output clipspace
                "mov v0, va1       \n"         // pass color to fragment program "
                );
            var fragment:AGALMiniAssembler = new AGALMiniAssembler;
            fragment.assemble(Context3DProgramType.FRAGMENT,
                "mov oc, v0        \n"
                );
            _program3D = _context3D.createProgram();
            _program3D.upload(vertexAssembler.agalcode,fragment.agalcode);
            _context3D.setProgram(_program3D);//这句话忘了
            _projectionMatrix = new Matrix3D();
            
            _context3D.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            //不做任何坐标变换
            addEventListener(Event.ENTER_FRAME,render);
        }
        
        private function updateVertexBuff():void
        {
            _vertexBuff.uploadFromVector(_vertexData.rawData,0,_vertexData.numVertices);
        }
        
        private function render(e:Event):void
        {
            _context3D.clear(255,255,255);
            _context3D.setVertexBufferAt(0,_vertexBuff,VertexData.POSITION_OFFSET,Context3DVertexBufferFormat.FLOAT_3);//坐标信息放入va0
            _context3D.setVertexBufferAt(1,_vertexBuff,VertexData.COLOR_OFFSET,Context3DVertexBufferFormat.FLOAT_4);//颜色信息（rgba）放入va1
            _context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0,_projectionMatrix);//vc0设置变换矩阵
            
            _context3D.drawTriangles(_indexBuff,0,1);
            _context3D.present();
        }
    }
}