package {
    import flash.display.*;
    import flash.text.*;
    import flash.events.*;

    public class Cell extends Sprite {
        private var mark:String = null;
        private var curImg:Bitmap = null;
        [Embed(source='def.png')] private var ImageDef:Class;
        [Embed(source='one.png')] private var ImageOne:Class;
        [Embed(source='peke.png')] private var ImagePeke:Class;
        [Embed(source='ast.png')] private var ImageAst:Class;
        [Embed(source='a.png')] private var ImageA:Class;

        public function Cell(v:String) {
            setMark(v);
        }

        public function setMark(v:String):void {
            if (mark == v) return; 

            if (curImg != null) removeChild(curImg);

            switch(v) {
                case " ":
                    curImg = new ImageDef() as Bitmap;
                    break;
                case "1":
                    curImg = new ImageOne() as Bitmap;
                    break;
                case "x":
                    curImg = new ImagePeke() as Bitmap;
                    break;
                case "*":
                    curImg = new ImageAst() as Bitmap;
                    break;
                case "A":
                    curImg = new ImageA() as Bitmap;
                    break;
                defalut:
                    throw("Invalid mark");
            }
            mark = v;
            curImg.smoothing = true;
            curImg.height = 32;
            curImg.width = 32;
            addChild(curImg);
        }

        public function getMark():String {
            return mark;
        }
    }
}

