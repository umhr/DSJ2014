var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
;
var TextManager = (function (_super) {
    __extends(TextManager, _super);
    function TextManager() {
        _super.call(this);
        var bg;
        var textMask;
        bg = Utility.getShape(815, 178, "#426CEB");
        this.addChild(bg);
        this.titleText = new createjs.Text("", "36px sans-serif", "#FFFFFF");
        this.addChild(this.titleText);
        this.titleText.x = 12;
        this.titleText.y = 12;
        this.p1Text = new createjs.Text("", "24px sans-serif", "#FFFFFF");
        this.addChild(this.p1Text);
        this.p1Text.x = 12;
        this.p1Text.y = 58;
        this.recommendText = new createjs.Text("", "60px sans-serif", "#FFFFFF");
        this.addChild(this.recommendText);
        this.recommendText.x = 12;
        this.recommendText.y = 110;
        textMask = Utility.getShape(800, 178, "#FF0000");
        textMask.x = 10;
        textMask.y = 110;
        this.recommendText.mask = textMask;
    }
    TextManager.END_SCROLL = "end_scroll";
    TextManager.prototype.scroll = function () {
        this.recommendText.x -= 1;
        if(this.recommendText.x < -(this.recommendWidth - 400)) {
            var eventObj = {
                type: TextManager.END_SCROLL
            };
            this.dispatchEvent(eventObj, null);
        }
    };
    TextManager.prototype.updateText = function (title, p1, recommend) {
        this.titleText.text = title;
        this.p1Text.text = this.setNewLine(p1);
        this.p1Text.lineHeight = (this.p1Text.getMeasuredLineHeight() + 0.5 | 0) + 5;
        this.recommendText.text = recommend;
        this.recommendText.x = 815;
        this.recommendWidth = this.recommendText.getMeasuredWidth();
    };
    TextManager.prototype.setNewLine = function (str) {
        var len = str.length;
        var i;
        var text = new createjs.Text("", "24px sans-serif", "#FFFFFF");
        for(i = 0; i < len; i++) {
            text.text += str.charAt(i);
            if(text.getMeasuredWidth() > 795) {
                break;
            }
        }
        str = str.substr(0, i) + "\n" + str.substr(i, len);
        return str;
    };
    return TextManager;
})(createjs.Container);
//@ sourceMappingURL=TextManager.js.map
