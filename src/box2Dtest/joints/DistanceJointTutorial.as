package box2Dtest.joints  
{
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class DistanceJointTutorial extends MouseJointTutorial
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(400, 300, 30, 30);
			var box2:b2Body = createBox(450, 30, 30, 30);
			
			var distanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();  
			distanceJointDef.Initialize(box1, box2, box1.GetWorldCenter(), box2.GetWorldCenter());
			_world.CreateJoint(distanceJointDef);
		}
	}
}