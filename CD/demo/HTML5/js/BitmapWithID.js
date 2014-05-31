var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
;
var BitmapWithID = (function (_super) {
    __extends(BitmapWithID, _super);
    function BitmapWithID(img, id) {
        _super.call(this);
        this.selectedBG = Utility.getShape(160, 160, "#426CEB");
        this.addChild(this.selectedBG);
        this.selectedBG.mouseEnabled = false;
        this.selectedBG.cache(0, 0, 160, 160);
        this.image = new createjs.Bitmap(img);
        this.addChild(this.image);
        this.image.x = 5;
        this.image.y = 5;
        this.image.cache(0, 0, 150, 150);
        this.bitmapID = id;
    }
    BitmapWithID.prototype.selected = function (boolean) {
        this.selectedBG.visible = boolean;
    };
    BitmapWithID.prototype.setColorMatrix = function (myMatrix) {
        this.filters = [
            new createjs.ColorMatrixFilter(myMatrix)
        ];
        this.cache(0, 0, 160, 160);
    };
    return BitmapWithID;
})(createjs.Container);
//@ sourceMappingURL=BitmapWithID.js.map
