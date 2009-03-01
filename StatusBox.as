package {
    public class StatusBox {
        private var stats:Array = new Array();

        public function add(condStat:int, condMark:String, nextStat:int, 
                            printMark:String, dir:String):void {
            var stat:Status = new Status(condStat, condMark, nextStat, printMark, dir); 
            stats.push(stat);
        }

        public function find(stat:int, mark:String):Status {
            for (var i:int = 0; i < stats.length; i++) {
                var s:Status = stats[i];
                if (s.getCondStat() == stat && s.getCondMark() == mark) {
                    return s;
                }
            }
            return null;
        }
    }
}
