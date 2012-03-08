package box2Dtest.joints  
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2LineJointDef;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class LineJointTutorial extends MouseJointTutorial
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(400, 350, 30, 30);
			
			var worldAxis:b2Vec2 = new b2Vec2(0, 1);  
			
			var lineJointDef:b2LineJointDef = new b2LineJointDef();  
			lineJointDef.Initialize(_groundBody,box1,box1.GetWorldCenter(), worldAxis);
			lineJointDef.lowerTranslation = -2.0;  
			lineJointDef.upperTranslation = 2.0;  
			lineJointDef.enableLimit = true
			lineJointDef.maxMotorForce = 200.0;  
			lineJointDef.motorSpeed = 10.0;  
			lineJointDef.enableMotor = true
			
			_world.CreateJoint(lineJointDef);
		}
	}
}