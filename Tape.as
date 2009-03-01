package {
    import flash.display.*;
    import flash.text.*;
    import flash.events.*;
    import flash.utils.Timer;
         
    public class Tape extends Sprite {
        private var cellWidth:int = 32;
        private var moveSpeed:int = 4;
        private var tape:String;
        private var idx:int;

        private var targetPos:int;
        private var curPos:int;

        private var cells:Array = new Array();

        public function Tape(tape:String, basePos:int) {
            idx = basePos;
            curPos = -idx * cellWidth;
            targetPos = curPos;

            for (var i:int = 0; i < tape.length; i++) {
                var char:String = tape.substr(i, 1);
                var cell:Cell = new Cell(char);
                addChild(cell);
                cells.push(cell);
            }

            addEventListener(Event.ENTER_FRAME, disp);
        }

        private function disp(event:Event):void {
            if (targetPos < curPos) {
                curPos -= moveSpeed;
                if (curPos <= targetPos) { curPos = targetPos; }
            }
            else if (targetPos > curPos) {
                curPos += moveSpeed;
                if (curPos >= targetPos) { curPos = targetPos; }
            }

            for (var i:int = 0; i < cells.length; i++) {
                cells[i].x = cellWidth * i + curPos;
            }
        }

        public function right():void {
            idx++;
            targetPos -= cellWidth;
        }

        public function left():void {
            idx--;
            targetPos += cellWidth;
        }

        public function getCellMark():String {
            return cells[idx].getMark();
        }

        public function setCellMark(mark:String):void {
            cells[idx].setMark(mark);
        }
    }
}
