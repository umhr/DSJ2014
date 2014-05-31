var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
;
var TitleImageManager = (function (_super) {
    __extends(TitleImageManager, _super);
    function TitleImageManager() {
        _super.call(this);
        this.prevImage = null;
        this.currentImage = null;
    }
    TitleImageManager.prototype.setImages = function (list) {
        this.titleImageList = list;
        var i;
        var len = this.titleImageList.length;
        var bmp;
        for(i = 0; i < len; i++) {
            bmp = this.titleImageList[i];
            this.addChild(bmp);
            bmp.alpha = 0;
            bmp.cache(0, 0, 491, 78);
        }
    };
    TitleImageManager.prototype.updateImage = function (bmp) {
        this.prevImage = this.currentImage;
        this.currentImage = bmp;
        if(this.prevImage) {
            createjs.Tween.get(this.prevImage).to({
                alpha: 0
            }, 600);
        }
        createjs.Tween.get(this.currentImage).to({
            alpha: 1
        }, 600);
    };
    return TitleImageManager;
})(createjs.Container);
//@ sourceMappingURL=TitleImageManager.js.map
