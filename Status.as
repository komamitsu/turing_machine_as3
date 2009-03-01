package {
    public class Status {
        private var condStat:int;
        private var condMark:String;
        private var nextStat:int;
        private var printMark:String;
        private var dir:String;

        public function Status(
            condStat:int, condMark:String, nextStat:int, 
            printMark:String, dir:String
        ) {
            this.condStat = condStat;
            this.condMark = condMark;
            this.nextStat = nextStat;
            this.printMark = printMark;
            this.dir = dir;
        }

        public function getCondStat():int { return condStat; }
        public function getCondMark():String { return condMark; }
        public function getNextStat():int { return nextStat; }
        public function getPrintMark():String { return printMark; }
        public function getDir():String { return dir; }
    }
}
