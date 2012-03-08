package box2Dtest.joints  
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	/**
	 * @author Allan Bishop
	 */
	public class WeldJointTutorial extends MouseJointTutorial 
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(400, 300, 30, 30);
			var box2:b2Body = createBox(430, 330, 30, 30);
			
			
			
			var weldJointDef:b2WeldJointDef = new b2WeldJointDef();  
			weldJointDef.Initialize(box1, box2, box1.GetWorldCenter());
			
			_world.CreateJoint(weldJointDef);
		}
	}
}