package box2Dtest.joints  
{
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class PrismaticJointTutorial extends MouseJointTutorial
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(400, 300, 30, 30);
			
			var worldAxis:b2Vec2 = new b2Vec2(1.0, 0.0);  
			
			var prismaticJointDef:b2PrismaticJointDef = new b2PrismaticJointDef();  
			prismaticJointDef.Initialize(box1, _groundBody, box1.GetWorldCenter(), worldAxis);
			prismaticJointDef.lowerTranslation = -5.0;  
			prismaticJointDef.upperTranslation = 2.5;  
			prismaticJointDef.enableLimit = true;  
			prismaticJointDef.maxMotorForce = 1.0;  
			prismaticJointDef.motorSpeed = 0.0;  
			prismaticJointDef.enableMotor = true; 
			
			_world.CreateJoint(prismaticJointDef);
		}
	}
}