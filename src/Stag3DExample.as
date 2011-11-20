package
{
    import com.adobe.utils.AGALMiniAssembler;
    
    import flash.display.Sprite;
    import flash.display.Stage3D;
    import flash.display3D.*;
    import flash.events.*;
    import flash.geom.Matrix3D;
    import flash.geom.Vector3D;
    
    import simple.MiniStage3D;

    public class Stag3DExample extends Sprite
    {
        private var stage3D0:Stage3D;
        private var stage3D1:Stage3D;
        private var context3D:Context3D;
        private var miniStage3D:Array = new Array
        
        private var vertexData0:Vector.<Number> = Vector.<Number>(
            [   
                //x y z   r g b
                -1,0,0,  1,0,0,     
                1,0,0,  0,1,0,
                0,1,0,  0,0,1
            ]
        );
        private var vertexData1:Vector.<Number> = Vector.<Number>(
            [   
                //x y z   r g b
                -.5,0.1,0,  0,1,0,     
                1,0.1,0,  0,1,0,
                0,1.1,0,  0,1,0
            ]
        );
        public function Stag3DExample()
        {   
            //通常在主类中不需要添加此监听来检测舞台是否实例化，但还是为了保险起见
            this.addEventListener(Event.ADDED_TO_STAGE,onStageAdded);
        }
        
        //对象添加到舞台触发
        private function onStageAdded(e:Event):void{
            //移除监听
            this.removeEventListener(Event.ADDED_TO_STAGE,onStageAdded);
            
            for(var i:int = 1;i>-1;i--){
                miniStage3D[i] = new MiniStage3D();
                //获取一个stage3D对象
                this["stage3D"+i] = stage.stage3Ds[i];
                //给stage3D添加监听，在其创建Context3D完成后调用
                this["stage3D"+i].addEventListener(Event.CONTEXT3D_CREATE,this["create3D"+i]);
                //请求stage3D生成一个Context3D对象
            }
            this["stage3D1"].requestContext3D();
            this["stage3D0"].requestContext3D();
        }
        
        private function create3D0(e:Event):void{
            e.target.removeEventListener(Event.CONTEXT3D_CREATE,create3D0);
            miniStage3D[0].setVertex(vertexData0);
            miniStage3D[0].initialization(stage,(e.target as Stage3D).context3D);
            trace("0");
        }
        
        private function create3D1(e:Event):void{
            e.target.removeEventListener(Event.CONTEXT3D_CREATE,create3D1);
            miniStage3D[1].setVertex(vertexData1);
            miniStage3D[1].initialization(stage,(e.target as Stage3D).context3D);
            trace("1");
            miniStage3D[1].render();
            miniStage3D[0].render();
        }
        
    }
}