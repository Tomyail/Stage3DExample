package
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2FixtureDef;
    import Box2D.Dynamics.b2World;
    
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    
    public class StarlingInBox2D extends Sprite
    {
        private const PIXELS_TO_METRE:int = 50;
        private var _world:b2World;

        private var _body:b2Body;

        private var _quad:Quad;
        private var _pos:b2Vec2;
        
        public function StarlingInBox2D()
        {
            addEventListener(Event.ADDED_TO_STAGE,init);
        }
        
        private function init(e:Event):void
        {
            createBox();
            createFloor();
            
            
            addEventListener(Event.ENTER_FRAME,update);
        }
        
        private function createBox():void
        {
            _quad = new Quad(PIXELS_TO_METRE,PIXELS_TO_METRE);
            //由于box2d对象的中心点都是物体的中心，所以设置Starling的中心点也是物体中心保持两者坐标系的一致
            _quad.pivotX = PIXELS_TO_METRE>>1;
            _quad.pivotY = PIXELS_TO_METRE>>1;
            //露出整个盒子
            _quad.x = 25;
            _quad.y = 25;
            addChild(_quad);
            
            _world = new b2World(new b2Vec2(0,10),true);
            
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = b2Body.b2_dynamicBody;
            //全宽为：0。5*50*2  = 50；
            bodyDef.position.Set(0.5,0.5);
            _body = _world.CreateBody(bodyDef);
            
            var box:b2PolygonShape = new b2PolygonShape();
            box.SetAsBox(0.5,0.5);
            
            var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
            groundFixtureDef.shape = box;
            _body.CreateFixture(groundFixtureDef);
        }
        
        private function createFloor():void
        {
            var floorDef:b2BodyDef = new b2BodyDef();
            floorDef.position.Set(stage.stageWidth/(2*PIXELS_TO_METRE),stage.stageHeight/PIXELS_TO_METRE);
            
            var floorBody:b2Body = _world.CreateBody(floorDef);
            
            var floorBox:b2PolygonShape = new b2PolygonShape();
            floorBox.SetAsBox((stage.stageWidth/2)/PIXELS_TO_METRE,0.5);
            
            var fixtureDef:b2FixtureDef = new b2FixtureDef();
            fixtureDef.shape = floorBox;
            
            floorBody.CreateFixture(fixtureDef);
            
            var floorSprite:Quad = new Quad(stage.stageWidth/2,PIXELS_TO_METRE);
            floorSprite.pivotX = floorSprite.width>>1;
            floorSprite.pivotY = floorSprite.height>>1;
            floorSprite.y = stage.stageHeight;
            addChild(floorSprite);
        }
        
        private function update(e:Event):void
        {
            _world.Step(1/30,8,3);
            _world.ClearForces();
            _pos = _body.GetPosition();
            //_pos 返回的是米，还要转换
            _quad.x = _pos.x *PIXELS_TO_METRE;
            _quad.y = _pos.y *PIXELS_TO_METRE; 
        }
    }
}