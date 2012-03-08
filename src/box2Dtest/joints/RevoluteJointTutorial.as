package  box2Dtest.joints 
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class RevoluteJointTutorial extends MouseJointTutorial
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(400, 300, 30, 30);
			createBox(450, 30, 30, 30);
			
			var revoluteJointDef:b2RevoluteJointDef = new  b2RevoluteJointDef();  
			revoluteJointDef.Initialize(box1, _groundBody, box1.GetWorldCenter());  
			
			revoluteJointDef.maxMotorTorque = 1.0;
			revoluteJointDef.enableMotor = true;
			
			_world.CreateJoint(revoluteJointDef);
		}
	}
}