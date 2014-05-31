var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
;
var ImageManager = (function (_super) {
    __extends(ImageManager, _super);
    function ImageManager() {
        _super.call(this);
        this.prevImage = null;
        this.currentImage = null;
    }
    ImageManager.prototype.setImages = function (list) {
        this.imageList = list;
        var i;
        var len = this.imageList.length;
        var bmp;
        for(i = 0; i < len; i++) {
            bmp = this.imageList[i];
            this.addChild(bmp);
            bmp.cache(0, 0, 815, 550);
            bmp.alpha = 0;
        }
    };
    ImageManager.prototype.updateImage = function (bmp) {
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
    return ImageManager;
})(createjs.Container);
//@ sourceMappingURL=ImageManager.js.map
