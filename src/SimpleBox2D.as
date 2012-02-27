package
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2DebugDraw;
    import Box2D.Dynamics.b2FixtureDef;
    import Box2D.Dynamics.b2World;
    
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    
    [SWF(backgroundColor="0x333333",width="800",height="600",frameRate="30")]
    public class SimpleBox2D extends Sprite
    {
        private const PIXELS_TO_METRE:int = 50;
        private var _world:b2World;
        public function SimpleBox2D()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            //定义重力向量
            var gravity:b2Vec2 = new b2Vec2(0,10);
            //实例化世界（接受两个参数重力向量和当物体停止移动时是否允许物体休眠，一个休眠中的物体不需要任何模拟）
            _world = new b2World(gravity,true);
            
            //实例化刚体定义数据
            var groundBodyDef:b2BodyDef= new b2BodyDef();
            //设置刚体的初始坐标在1，1米处
            groundBodyDef.position.Set(1,1);
            groundBodyDef.type = b2Body.b2_dynamicBody;
            
            //实例化一个刚体（将刚体定义数据交给世界能自动创建刚体）
            var groundBody:b2Body = _world.CreateBody(groundBodyDef);
            
            //实例化刚体的形状
            var groundBox:b2PolygonShape = new b2PolygonShape();
            //将形状定义成2X2的方形
            groundBox.SetAsBox(1,1);
            
            //实例化粘物
            var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
            //粘上形状。。。
            groundFixtureDef.shape = groundBox;
            //让刚体表现出粘物绑定形状的形状
            groundBody.CreateFixture(groundFixtureDef);
            
            
            /**
            * 以上的工作只是定义好必要的数据，但还是需要下面相关的代码来渲染出来
            * 绘图相关
            */
            var debugSprite:Sprite = new Sprite();
            addChild(debugSprite);
            var debugDraw:b2DebugDraw = new b2DebugDraw();
            debugDraw.SetSprite(debugSprite);
            debugDraw.SetLineThickness( 1.0);
            debugDraw.SetAlpha(1);
            debugDraw.SetFillAlpha(0.4);
            //设置缩放量
            debugDraw.SetDrawScale(PIXELS_TO_METRE);
            //设置绘图模式
            debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
            _world.SetDebugDraw(debugDraw);
            
//            _world.DrawDebugData();
            
            addEventListener(Event.ENTER_FRAME,updateFrame);
        }
        
        protected function updateFrame(event:Event):void
        {
            var timeStep:Number = 1/ 30;
            var velocityIterations:int = 8;
            var positionIterations:int = 3;
            
            _world.Step(timeStep,velocityIterations,positionIterations);
            _world.ClearForces();
            _world.DrawDebugData();
        }
    }
}      

