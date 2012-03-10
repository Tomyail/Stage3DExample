package test.utils
{
    import data.PathData;
    
    import utils.PathDatasAdapter;

    public class TestPathDatasAdapter
    {
        private var data:Vector.<Object> = Vector.<Object>(
            [
                {id:0,x:1,y:2,l:"1"},
                {id:1,x:1,y:10,l:"3"},
                {id:2,x:1,y:20,l:""},
                {id:3,x:1,y:30,l:"4_5"},
                {id:4,x:1,y:40,l:""},
                {id:5,x:1,y:50,l:""}
            ]
            );
        
//        private var d:Vector.<Object> = new <Object>[{},{}];

        public function TestPathDatasAdapter()
        {
            var result:Vector.<PathData> = PathDatasAdapter.adaptive(data);
            for(var i:int = 0;i< result.length;i++)
            {
                trace(result[i].link.length);
            }
        }
    }
}