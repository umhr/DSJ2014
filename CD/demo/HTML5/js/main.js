;
var Main = (function () {
    function Main() {
        var _this = this;
        var loadManager = new LoadManager();
        loadManager.addEventListener(LoadManager.COMPLETE, function () {
            _this.layout();
            loadManager.removeEventListener(LoadManager.COMPLETE, null);
        });
        loadManager.loadStart();
    }
    Main.FPS = 30;
    Main.prototype.layout = function () {
        var _this = this;
        var idList;
        var canvas = document.getElementById("canvas");
        var stage = new createjs.Stage(canvas);
        this.dataListInstance = DataManager.dataListClass;
        idList = this.dataListInstance.idList;
        Main.currentID = idList[0];
        this.mainImageManager = new ImageManager();
        stage.addChild(this.mainImageManager);
        this.mainImageManager.x = 20;
        this.mainImageManager.y = 20;
        this.mainImageManager.setImages(this.dataListInstance.mainImageList);
        this.thumbnailManager = new ThumbnailManager();
        stage.addChild(this.thumbnailManager);
        this.thumbnailManager.x = 855;
        this.thumbnailManager.y = 98;
        this.thumbnailManager.setThumbnails(this.dataListInstance.thumbnailList);
        this.titleImageManager = new TitleImageManager();
        stage.addChild(this.titleImageManager);
        this.titleImageManager.x = 855;
        this.titleImageManager.y = 20;
        this.titleImageManager.setImages(this.dataListInstance.titleImageList);
        this.textManager = new TextManager();
        stage.addChild(this.textManager);
        this.textManager.x = 20;
        this.textManager.y = 570;
        this.thumbnailManager.addEventListener(ThumbnailManager.THUMBNAIL_CLICK, function (event) {
            _this.clickHandler(event);
        });
        this.textManager.addEventListener(TextManager.END_SCROLL, function (event) {
            _this.changeData();
        });
        var data = this.dataListInstance.getDataById(Main.currentID);
        this.startContents(stage);
        this.updateContents(data);
    };
    Main.prototype.clickHandler = function (event) {
        Main.currentID = event.id;
        var data = this.dataListInstance.getDataById(Main.currentID);
        this.updateContents(data);
    };
    Main.prototype.changeData = function () {
        var nextData = this.dataListInstance.getNextDataById(Main.currentID);
        Main.currentID = nextData.id;
        this.updateContents(nextData);
    };
    Main.prototype.startContents = function (stage) {
        var _this = this;
        createjs.Ticker.setFPS(Main.FPS);
        createjs.Ticker.addEventListener("tick", function (event) {
            _this.textManager.scroll();
            stage.update();
        });
    };
    Main.prototype.updateContents = function (data) {
        var currentData = data;
        this.thumbnailManager.updateColorMatrix(currentData.thumbBmpWithID);
        this.mainImageManager.updateImage(currentData.mainImage);
        this.titleImageManager.updateImage(currentData.titleImage);
        this.textManager.updateText(currentData.title, currentData.p1, currentData.recommend);
    };
    return Main;
})();
window.onload = function () {
    var main = new Main();
};
//@ sourceMappingURL=Main.js.map
