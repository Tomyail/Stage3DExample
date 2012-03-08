package box2Dtest.joints  
{
	import Box2D.Dynamics.Joints.b2GearJointDef;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Common.b2Settings;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class GearJointTutorial extends MouseJointTutorial
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(300, 300, 30, 30);
			var box2:b2Body = createBox(450, 300, 30, 30);
			
			var revoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();  
			revoluteJointDef.Initialize(_groundBody, box1, box1.GetWorldCenter());  //ground must be the first body
			revoluteJointDef.lowerAngle = -0.5 * b2Settings.b2_pi; // -90 degrees  
			revoluteJointDef.upperAngle = 0.25 * b2Settings.b2_pi; // 45 degrees  
			revoluteJointDef.enableLimit = true;  
			revoluteJointDef.maxMotorTorque = 10.0;  
			revoluteJointDef.motorSpeed = 0.0;  
			revoluteJointDef.enableMotor = true; 
			
			var revoluteJoint:b2RevoluteJoint = _world.CreateJoint(revoluteJointDef) as b2RevoluteJoint;
			var worldAxis:b2Vec2 = new b2Vec2(1.0, 0.0);  
			
			var prismaticJointDef:b2PrismaticJointDef = new b2PrismaticJointDef();  
			prismaticJointDef.Initialize(_groundBody, box2, box2.GetWorldCenter(), worldAxis);  //ground must be the first body
			prismaticJointDef.lowerTranslation = -5.0;  
			prismaticJointDef.upperTranslation = 2.5;  
			prismaticJointDef.enableLimit = true;  
			prismaticJointDef.maxMotorForce = 1.0;  
			prismaticJointDef.motorSpeed = 0.0;  
			prismaticJointDef.enableMotor = true; 
			
			var prismaticJoint:b2PrismaticJoint = _world.CreateJoint(prismaticJointDef) as b2PrismaticJoint;
			
			var gearJointDef:b2GearJointDef = new b2GearJointDef();  
			
			gearJointDef.joint1 = revoluteJoint;  
			gearJointDef.joint2 = prismaticJoint;  
			gearJointDef.bodyA = box1; 
			gearJointDef.bodyB = box2;
			gearJointDef.ratio = 2.0 * b2Settings.b2_pi / (300 / PIXELS_TO_METRE); 
			
			_world.CreateJoint(gearJointDef);
		}
	}
}