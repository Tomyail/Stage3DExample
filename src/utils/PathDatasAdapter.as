package utils
{
    import data.PathData;
    
    import flash.sensors.Accelerometer;

    public class PathDatasAdapter
    {
        public function PathDatasAdapter()
        {
        }
        
        
        /**
         *  
         * @param data 数据格式
         * {
         * {id:0,x:1,y:2,l:"1"},
         * {id:1,x:1,y:10,l:"3"},
         * {id:2,x:1,y:20,l:""},
         * {id:3,x:1,y:30,l:"4_5"}
         * etc... 
         * }
         */
        public static function adaptive(data:Object):Vector.<PathData>
        {
            
            var result:Vector.<PathData> = new Vector.<PathData>;
            
            for each (var obj:Object in data)
            {
                var pd:PathData = new PathData();
                pd.id = obj.id;
                pd.x = obj.x;
                pd.y = obj.y;
                if((obj.l as String).length != 0)
                {
                    pd.addLinks((obj.l as String).split("_"));
                }
                result.push(pd);
            }
            return result;
        }
        
    }
}