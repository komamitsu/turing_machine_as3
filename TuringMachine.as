package {
    import flash.display.*;
    import flash.text.*;
    import flash.events.*;
    import flash.utils.Timer;

    public class TuringMachine extends Sprite {
        private var tape:Tape;
        private var curStatId:int;
        private var statBox:StatusBox = new StatusBox();
        private const tapeMarginSize:int = 32;
        private var timer:Timer;
        private var status:TextField;
        private var message:TextField;
        private var val1:TextField;
        private var val2:TextField;
        private var run:TextField;
        private var speed:TextField;
        private const input_x:int = 20;
        private const input_y:int = 30;
        private const tape_x:int = 100;
        private const tape_y:int = 100;
        private const stat_x:int = 300;
        private const stat_y:int = 0;
        private const msg_x:int = 20;
        private const msg_y:int = 0;
        private const speed_x:int = 20;
        private const speed_y:int = 60;

        public function TuringMachine() {
            setStat();

            addChild(createTextField(tape_x + 10, tape_y - 10, '▼'));

            addChild(createTextField(speed_x, speed_y, 'なんmsecごとに動くの?'));
            addChild(speed = createTextField(speed_x + 150, speed_y, '1000', 4));

            addChild(createTextField(input_x, input_y, 'なに掛けるなに?'));
            addChild(val1 = createTextField(input_x + 100, input_y, '3', 1));
            addChild(createTextField(input_x + 115, input_y, 'x'));
            addChild(val2 = createTextField(input_x + 130, input_y, '2', 1));

            addChild(run = 
                createTextField(input_x + 150, input_y, 'かけざん開始！')
            );
            run.border = true;
            run.addEventListener('click', 
                function (event:Event):void {
                    init();
                    if (timer) timer.stop();
                    timer = new Timer(parseInt(speed.text));
                    timer.addEventListener(TimerEvent.TIMER, process);
                    timer.start();
                }
            );
        }

        private function charLine(char:String, len:int):String {
            return (new Array(len + 1)).join(char.substr(0, 1));
        }

        private function init():void {
            curStatId = 0;

            if (tape) removeChild(tape);
            var tapeStr:String = 
                charLine("1", parseInt(val1.text)) + 'x' + 
                charLine("1", parseInt(val2.text));
            var tapeMarginStr:String = charLine(" ", tapeMarginSize);
            tape = new Tape(tapeMarginStr + tapeStr + tapeMarginStr, tapeMarginSize);
            tape.x = tape_x;
            tape.y = tape_y;
            addChild(tape);

            if (status) removeChild(status);
            addChild(status = createTextField(stat_x, stat_y, ''));

            if (message) removeChild(message);
            addChild(message = createTextField(msg_x, msg_y, ''));

        }

        private function createTextField(
            x:int, y:int, content:String, inputLen:int = 0 
        ):TextField {
            var tf:TextField = new TextField();
            tf.x = x;
            tf.y = y;
            tf.text = content;
            tf.autoSize = TextFieldAutoSize.LEFT;
            if (inputLen > 0) {
                tf.type = TextFieldType.INPUT;
                tf.background = true;
                tf.restrict = "0-9";
                tf.maxChars = inputLen;
            }
            return tf;
        }

        private function process(event:Event):void {
            var curMark:String = tape.getCellMark();
            var stat:Status = statBox.find(curStatId, curMark);

            status.text = 
                "現在の状態: " + stat.getCondStat() + "\n" +
                "現在の記号: " + stat.getCondMark() + "\n" +
                "次の状態: " + stat.getNextStat() + "\n" +
                "印刷する記号: " + stat.getPrintMark() + "\n" +
                "移動する方向: " + stat.getDir() + "\n";

            tape.setCellMark(stat.getPrintMark());

            switch (stat.getDir()) {
            case "R":
                tape.right();
                break;
            case "L":
                tape.left();
                break;
            case "S":
                timer.stop();
                message.text = 'おしま〜い';
                break;
            }
            curStatId = stat.getNextStat();
        }

        private function setStat():void {
            statBox.add( 0, " ",  0, " ", "R");
            statBox.add( 0, "1",  1, "1", "L");
            statBox.add( 1, " ",  2, "*", "R");
            statBox.add( 2, " ",  3, " ", "L");
            statBox.add( 2, "*",  2, "*", "R");
            statBox.add( 2, "1",  2, "1", "R");
            statBox.add( 2, "x",  2, "x", "R");
            statBox.add( 2, "A",  2, "A", "R");
//            statBox.add( 3, "1",  9, " ", "L");
            statBox.add( 3, "1",  4, " ", "L");
            statBox.add( 3, "x",  9, "x", "L");
            statBox.add( 4, "1",  4, "1", "L");
            statBox.add( 4, "x",  5, "x", "L");
            statBox.add( 5, "*",  8, "*", "R");
            statBox.add( 5, "1",  6, "A", "L");
            statBox.add( 5, "A",  5, "A", "L");
            statBox.add( 6, " ",  7, "1", "R");
            statBox.add( 6, "*",  6, "*", "L");
            statBox.add( 6, "1",  6, "1", "L");
            statBox.add( 7, "*",  7, "*", "R");
            statBox.add( 7, "1",  7, "1", "R");
            statBox.add( 7, "x",  5, "x", "L");
            statBox.add( 7, "A",  7, "A", "R");
            statBox.add( 8, " ",  3, " ", "L");
            statBox.add( 8, "1",  8, "1", "R");
            statBox.add( 8, "x",  8, "x", "R");
            statBox.add( 8, "A",  8, "1", "R");
//            statBox.add( 9, "*", 10, " ", "S");
            statBox.add( 9, "*", 10, " ", "R");
            statBox.add( 9, "1",  9, "1", "L");
//            statBox.add( 9, "x",  9, "x", "L");
            statBox.add(10, " ", 11, " ", "L");
            statBox.add(10, "1", 10, " ", "R");
            statBox.add(10, "x", 10, " ", "R");
            statBox.add(11, " ", 11, " ", "L");
            statBox.add(11, "1", 12, "1", "L");
            statBox.add(12, "1", 12, "1", "L");
            statBox.add(12, " ", 13, " ", "S");
        }
    }
}

