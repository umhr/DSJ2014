var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
;
var ThumbnailManager = (function (_super) {
    __extends(ThumbnailManager, _super);
    function ThumbnailManager() {
        _super.call(this);
        var shape = Utility.getShape(491, 650, "#DDDDDD");
        this.addChild(shape);
    }
    ThumbnailManager.THUMBNAIL_CLICK = "thumbnail_click";
    ThumbnailManager.prototype.setThumbnails = function (thumbnailList) {
        var _this = this;
        this.thumbList = thumbnailList;
        var i;
        var len = this.thumbList.length;
        var colorMatrix;
        var thumbnail;
        for(i = 0; i < len; i++) {
            thumbnail = this.thumbList[i];
            this.addChild(thumbnail);
            thumbnail.x = 6 + 160 * (i % 3);
            thumbnail.y = 5 + 160 * Math.floor(i / 3);
            if(i === 0) {
                this.currentThumbnail = thumbnail;
                this.currentThumbnail.selected(true);
            } else {
                thumbnail.selected(false);
                colorMatrix = new createjs.ColorMatrix(80, -20, 0, 0);
                thumbnail.setColorMatrix(colorMatrix);
            }
            thumbnail.addEventListener("click", function (event) {
                _this.clickHandler(event);
            }, false);
        }
    };
    ThumbnailManager.prototype.updateColorMatrix = function (bmpWithId) {
        var colorMatrix;
        colorMatrix = new createjs.ColorMatrix(80, -20, 0, 0);
        this.prevThumbnail = this.currentThumbnail;
        this.prevThumbnail.selected(false);
        this.prevThumbnail.setColorMatrix(colorMatrix);
        colorMatrix = new createjs.ColorMatrix(0, 0, 0, 0);
        this.currentThumbnail = bmpWithId;
        this.currentThumbnail.selected(true);
        this.currentThumbnail.setColorMatrix(colorMatrix);
    };
    ThumbnailManager.prototype.clickHandler = function (event) {
        var target = event.target;
        var id = target.bitmapID;
        if(id === Main.currentID) {
            return;
        }
        var eventObj = {
            type: ThumbnailManager.THUMBNAIL_CLICK,
            id: id
        };
        this.dispatchEvent(eventObj, null);
    };
    return ThumbnailManager;
})(createjs.Container);
//@ sourceMappingURL=ThumbnailManager.js.map
