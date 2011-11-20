package simple
{
    import com.adobe.utils.AGALMiniAssembler;
    
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.Stage3D;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.Matrix3D;

    public class MiniStage3D extends Sprite
    {
        private const VERTEX_SHADER:String =
            "m44 op, va0, vc0    \n" +    // 4x4 matrix transform 
            "mov v0, va1"; //copy color to varying variable v0
        private const FRAGMENT_SHADER:String = 
            "mov oc, v0"; //Set the output color to the value interpolated from the three triangle vertices 
        private var vertexData:Vector.<Number>;
        private var indexData:Vector.<uint>;
        
        private var stage3D:Stage3D;
        private var context3D:Context3D;

        private var indexBuff:IndexBuffer3D;
        public function MiniStage3D()
        {
        }
        
        /**
         * 初始化一个stage3D 
         * @param stage
         * @param context3D
         * 
         */        
        public function initialization(stage:Stage,context3D:Context3D):void{
            this.context3D = context3D;
            
            context3D.configureBackBuffer(stage.stageWidth,stage.stageHeight,0);
            preRender();
        }
        
        //设置顶点
        public function setVertex(vertexData:Vector.<Number>):void{
            this.vertexData = vertexData;
        }
        //预渲染阶段，此阶段准备渲染需要的顶点数据和一些渲染必要的类
        private function preRender():void{
            //根据顶点定义三角形
            indexData = Vector.<uint>([0,1,2]);
            
            //顶义顶点缓冲
            var vertexBuff:VertexBuffer3D = context3D.createVertexBuffer(3,6);
            vertexBuff.uploadFromVector(vertexData,0,3);
            
            //顶义顶点所以缓冲
            indexBuff = context3D.createIndexBuffer(3);
            indexBuff.uploadFromVector(indexData,0,3);
            
            //将定义好的顶点坐标，颜色数据传给context3D准备
            context3D.setVertexBufferAt(0,vertexBuff,0,Context3DVertexBufferFormat.FLOAT_3);
            context3D.setVertexBufferAt(1,vertexBuff,3,Context3DVertexBufferFormat.FLOAT_3);
            
            //定义顶点字节码转换器（用于将顶点数据转换成GPU能识别的字节码）
            var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
            vertexAssembler.assemble(Context3DProgramType.VERTEX,VERTEX_SHADER,false);
            
            //定义片段字节码转换器
            var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
            fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,FRAGMENT_SHADER,false);
            
            //创建并设置3D可编程单元
            var program3D:Program3D = context3D.createProgram();
            program3D.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
            context3D.setProgram(program3D);
            
            //定义转换矩阵
            var modelView:Matrix3D = new Matrix3D();
            context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,modelView);
        }
        
        public function render():void{
            //清楚创建并开始绘制三角形
            context3D.clear()
            context3D.drawTriangles(indexBuff);
            
            //呈现
            context3D.present();
        }
    }
}