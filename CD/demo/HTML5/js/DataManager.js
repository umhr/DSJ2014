;
var DataManager;
(function (DataManager) {
    var DataListClass = (function () {
        function DataListClass() {
            this.dataList = [];
            this.idList = [];
            this.mainImageList = [];
            this.thumbnailList = [];
            this.titleImageList = [];
            this.titleList = [];
            this.p1List = [];
            this.recommendList = [];
        }
        DataListClass.prototype.pushToList = function (data) {
            var id = data.id;
            var mainImage = data.mainImage;
            var thumbnailBmp = data.thumbBmpWithID;
            var titleImage = data.titleImage;
            var title = data.title;
            var p1 = data.p1;
            var recommend = data.recommend;
            this.idList.push(id);
            this.mainImageList.push(mainImage);
            this.thumbnailList.push(thumbnailBmp);
            this.titleImageList.push(titleImage);
            this.titleList.push(title);
            this.p1List.push(p1);
            this.recommendList.push(recommend);
            this.dataList.push(data);
        };
        DataListClass.prototype.getDataById = function (id) {
            var i;
            var len = this.dataList.length;
            var data;
            for(i = 0; i < len; i++) {
                data = this.dataList[i];
                if(data.id === id) {
                    break;
                }
            }
            return data;
        };
        DataListClass.prototype.getNextDataById = function (id) {
            var i;
            var len = this.dataList.length;
            var data;
            for(i = 0; i < len; i++) {
                data = this.dataList[i];
                if(data.id === id) {
                    if(i === len - 1) {
                        data = this.dataList[0];
                    } else {
                        data = this.dataList[i + 1];
                    }
                    break;
                }
            }
            return data;
        };
        return DataListClass;
    })();
    DataManager.DataListClass = DataListClass;    
    DataManager.dataListClass = new DataListClass();
})(DataManager || (DataManager = {}));
//@ sourceMappingURL=DataManager.js.map
