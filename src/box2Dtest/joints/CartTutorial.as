package box2Dtest.joints 
{
	
	import flash.events.Event;
	
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class CartTutorial extends MouseJointTutorial
	{
		private var _wheel1:b2Body;
		private var _wheel2:b2Body;
		
		override protected function setup():void
		{
			var cartBody:b2Body = createBox(400, 30, 100, 10);
			_wheel1 = createCircle(300, 30, 20);
			_wheel2 = createCircle(500, 30, 20);
			
			createBox(125, 30, 25, 25);
			createBox(675, 30, 25, 25);
			
			var firstWheelRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			firstWheelRevoluteJointDef.Initialize(_wheel1, cartBody, _wheel1.GetWorldCenter());
			_world.CreateJoint(firstWheelRevoluteJointDef);
			
			var secondWheelRevoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			secondWheelRevoluteJointDef.Initialize(_wheel2, cartBody, _wheel2.GetWorldCenter());
			_world.CreateJoint(secondWheelRevoluteJointDef);
		}
		
		private function createCircle(x:int,y:int,radius:int):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.position.Set(x / PIXELS_TO_METRE, y / PIXELS_TO_METRE);
			var body:b2Body = _world.CreateBody(bodyDef);
			
			var dynamicCircle:b2CircleShape = new b2CircleShape(radius / PIXELS_TO_METRE);
			
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = dynamicCircle;
			fixtureDef.density = 1;
			fixtureDef.friction = 0.4;//decent friction in tires, but not so much that the wheels can't spin out
			
			body.CreateFixture(fixtureDef);
			return body;
		}
		
		override protected function update(e:Event):void
		{
			var timeStep:Number = 1 / 30;
			var velocityIterations:int = 6;
			var positionIterations:int = 2;
			
			UpdateMouseWorld();
			MouseDestroy();
			MouseDrag();
			KeyboardUpdate();
			
			_world.Step(timeStep, velocityIterations, positionIterations);
			_world.ClearForces();
			_world.DrawDebugData();
			Input.update();
		}
		
		private function KeyboardUpdate():void
		{
			if(Input.isKeyDown(37))
			{
				_wheel1.ApplyTorque(-20);
			}
			if(Input.isKeyDown(39))
			{
				_wheel2.ApplyTorque(20);
			}
		}
	}
}