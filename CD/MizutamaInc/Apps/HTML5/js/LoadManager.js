var __extends = this.__extends || function (d, b) {
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
;
var LoadManager = (function (_super) {
    __extends(LoadManager, _super);
    function LoadManager() {
        _super.call(this);
        this.idList = [];
        this.titleList = [];
        this.p1List = [];
        this.recommendList = [];
    }
    LoadManager.COMPLETE = "complete";
    LoadManager.prototype.loadStart = function () {
        var _this = this;
        var queue = new createjs.LoadQueue(true);
        queue.addEventListener("complete", function (event) {
            var result = queue.getResult("data", true);
            var itemNodeList = result.getElementsByTagName("item");
            var mainImageNodeList = result.getElementsByTagName("mainPath");
            var thumbImageNodeList = result.getElementsByTagName("thumbnailPath");
            var titleImageNodeList = result.getElementsByTagName("titlePath");
            var titleTextNode = result.getElementsByTagName("title");
            var p1TextNode = result.getElementsByTagName("p1");
            var recommendTextNode = result.getElementsByTagName("recommend");
            var i;
            var item;
            var id;
            var mainPath, thumbPath, titlePath;
            var title, p1, p2, recommend;
            var manifest = [];
            _this.itemNum = itemNodeList.length;
            for(i = 0; i < _this.itemNum; i++) {
                item = itemNodeList.item(i);
                id = item.getAttribute("id");
                _this.idList.push(id);
                mainPath = mainImageNodeList[i].childNodes[0].nodeValue;
                thumbPath = thumbImageNodeList[i].childNodes[0].nodeValue;
                titlePath = titleImageNodeList[i].childNodes[0].nodeValue;
                manifest.push({
                    src: mainPath,
                    id: "main" + id
                });
                manifest.push({
                    src: thumbPath,
                    id: "thumbnail" + id
                });
                manifest.push({
                    src: titlePath,
                    id: "title" + id
                });
                title = titleTextNode[i].childNodes[0].nodeValue;
                p1 = p1TextNode[i].childNodes[0].nodeValue;
                recommend = recommendTextNode[i].childNodes[0].nodeValue;
                _this.titleList.push(title);
                _this.p1List.push(p1);
                _this.recommendList.push(recommend);
            }
            _this.loadImages(manifest);
        });
        queue.loadFile({
            id: "data",
            src: "asset/data.xml"
        });
    };
    LoadManager.prototype.loadImages = function (manifest) {
        var _this = this;
        var imageQueue = new createjs.LoadQueue(true);
        imageQueue.addEventListener("complete", function (event) {
            var i;
            var id;
            var title, p1, p2, recommend;
            var mainImage, thumbnail, titleImage;
            var data;
            var dataList = DataManager.dataListClass;
            for(i = 0; i < _this.itemNum; i++) {
                id = _this.idList[i];
                title = _this.titleList[i];
                p1 = _this.p1List[i];
                recommend = _this.recommendList[i];
                mainImage = imageQueue.getResult("main" + id);
                thumbnail = imageQueue.getResult("thumbnail" + id);
                titleImage = imageQueue.getResult("title" + id);
                data = new Data(id, mainImage, thumbnail, titleImage, title, p1, recommend);
                dataList.pushToList(data);
            }
            _this.dispatchEvent(LoadManager.COMPLETE, null);
        });
        imageQueue.loadManifest(manifest);
    };
    return LoadManager;
})(createjs.EventDispatcher);
//@ sourceMappingURL=LoadManager.js.map
