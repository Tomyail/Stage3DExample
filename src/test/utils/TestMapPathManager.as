package test.utils
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    
    import utils.MapPathManager;
    import utils.PathDatasAdapter;

    public class TestMapPathManager
    {
        private var data:Vector.<Object> = Vector.<Object>(
            [
                {id:0,x:1,y:2,l:"1_2"},
                {id:1,x:1,y:50,l:"3"},
                {id:2,x:30,y:20,l:""},
                {id:3,x:60,y:60,l:"4_5"},
                {id:4,x:40,y:80,l:""},
                {id:5,x:10,y:200,l:""}
            ]
        );
        public function TestMapPathManager(ct:Sprite)
        {
            var mpm:MapPathManager = new MapPathManager(ct);
            mpm.setPathDatas(PathDatasAdapter.adaptive(data));
            mpm.createPaths();
        }
    }
}