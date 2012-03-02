package ai
{
    import data.IntVec2;
    
    import flash.geom.Point;

    /**视线法追逐产生的路径*/
    public class LineofSightChasing
    {
        public function LineofSightChasing()
        {
        }
        
        public static function buildPathToTarget(current:IntVec2,target:IntVec2):Vector.<IntVec2>
        {
           var result:Vector.<IntVec2> = new Vector.<IntVec2>;
           var stepX:int,stepY:int;
           var delta:IntVec2 = IntVec2.minus(target,current);
           var currentTemp:IntVec2 = current;
           var error:Number = 0;
           //斜率
           var k:Number = Math.abs(delta.y/delta.x);
           //以下两步决定下一步的进退
           stepX = delta.x > 0 ? 1:-1;
           stepY = delta.y > 0 ? 1:-1;
           
           result[0] = new IntVec2(current.x,current.y);
           //X轴距离更远，所以以X轴是否到达终点作为依据
           if(k <1)
           {
               while(currentTemp.x != target.x)
               {
                       error += k;
                       if(error > 0.5)
                       {
                           currentTemp.y += stepY;
                           error -= 1;
                       }
                   currentTemp.x +=stepX;
                  result.push(new IntVec2(currentTemp.x,currentTemp.y));
               }
           }
           else
           {
               while(currentTemp.y != target.y)
               {
                   error += 1/k;
                   if(error > 0.5)
                   {
                       currentTemp.x += stepX;
                       error -= 1;
                   }
                   currentTemp.y += stepY;
                   result.push(new IntVec2(currentTemp.x,currentTemp.y));
               }
           }
           
           return result;
        }
    }
}