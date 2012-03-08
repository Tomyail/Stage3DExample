package  box2Dtest.joints 
{
	import Box2D.Dynamics.Joints.b2PulleyJointDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	/**
	 * @author Allan Bishop
	 */
	public class PulleyJointTutorial extends MouseJointTutorial
	{
		override protected function setup():void
		{
			var box1:b2Body = createBox(350, 300,30,30);
			var box2:b2Body = createBox(450, 300,30,30);
			
			var anchor1:b2Vec2 = box1.GetWorldCenter();  
			var anchor2:b2Vec2 = box2.GetWorldCenter();  
			
			var groundAnchor1:b2Vec2 = new b2Vec2(anchor1.x, anchor1.y - (300 / PIXELS_TO_METRE));
			var groundAnchor2:b2Vec2 = new b2Vec2(anchor2.x, anchor2.y - (300 / PIXELS_TO_METRE));
			
			var ratio:Number = 1.0;  
			
			var pulleyJointDef:b2PulleyJointDef = new b2PulleyJointDef();  
			pulleyJointDef.Initialize(box1, box2, groundAnchor1, groundAnchor2, anchor1, anchor2, ratio);  
			pulleyJointDef.maxLengthA = 600 / PIXELS_TO_METRE;  
			pulleyJointDef.maxLengthB = 600 / PIXELS_TO_METRE; 
			
			_world.CreateJoint(pulleyJointDef);
		}
	}
}