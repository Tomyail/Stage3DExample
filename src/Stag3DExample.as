package
{
    import com.adobe.utils.AGALMiniAssembler;
    
    import flash.display.Sprite;
    import flash.display.Stage3D;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.Matrix3D;
    import flash.geom.Vector3D;

    public class Stag3DExample extends Sprite
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
        public function Stag3DExample()
        {   
            //通常在主类中不需要添加此监听来检测舞台是否实例化，但还是为了保险起见
            this.addEventListener(Event.ADDED_TO_STAGE,onStageAdded);
//            this.graphics.beginFill(0);
//            this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
        }
        
        //对象添加到舞台触发
        private function onStageAdded(e:Event):void{
            //移除监听
            this.removeEventListener(Event.ADDED_TO_STAGE,onStageAdded);
            
            //获取一个stage3D对象
            stage3D = stage.stage3Ds[1]
            //给stage3D添加监听，在其创建Context3D完成后调用
            stage3D.addEventListener(Event.CONTEXT3D_CREATE,on3DCreated);
            
            //请求stage3D生成一个Context3D对象
            stage3D.requestContext3D();
        }
        
        //Context3D对象创建完毕调用
        private function on3DCreated(e:Event):void{
            //移除监听
            stage3D.removeEventListener(Event.CONTEXT3D_CREATE,on3DCreated);
            
            /**
            * 阶段1完成:获取context3D对象
            * 获取context3D的引用，
            */
            context3D = stage3D.context3D;
            //捕获渲染时的错误，用于debug
            context3D.enableErrorChecking = true;
            //查看显卡信息
            trace(context3D.driverInfo);
            
            /**
            * 阶段2完成:配置context3D场景 
            */
            context3D.configureBackBuffer(stage.stageWidth,stage.stageHeight,0);
            
            /**
            * 阶段3开始:预渲染 
            */
            preRender();
        }
        
        //预渲染阶段，此阶段准备渲染需要的顶点数据和一些渲染必要的类
        private function preRender():void{
            //设置顶点
            vertexData = Vector.<Number>(
            [   
              //x y z   r g b
                -1,0,0,  1,0,0,     
                1,0,0,  0,1,0,
                0,1,0,  0,0,1
            ]
            );
            //根据顶点定义三角形
            indexData = Vector.<uint>([0,1,2]);
            
            //顶义顶点缓冲
            var vertexBuff:VertexBuffer3D = context3D.createVertexBuffer(3,6);
            vertexBuff.uploadFromVector(vertexData,0,3);
            
            //顶义顶点所以缓冲
            var indexBuff:IndexBuffer3D = context3D.createIndexBuffer(3);
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
            
            //清楚创建并开始绘制三角形
            context3D.clear()
            context3D.drawTriangles(indexBuff);
            
            //呈现
            context3D.present();
               
        }
    }
}