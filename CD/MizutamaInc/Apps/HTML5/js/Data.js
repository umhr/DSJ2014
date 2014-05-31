;
var Data = (function () {
    function Data(id, mainImage, thumbnail, titleImage, title, p1, recommend) {
        this.id = id;
        this.mainImage = new createjs.Bitmap(mainImage);
        this.thumbBmpWithID = new BitmapWithID(thumbnail, id);
        this.titleImage = new createjs.Bitmap(titleImage);
        this.title = title;
        this.p1 = p1;
        this.recommend = recommend;
    }
    return Data;
})();
//@ sourceMappingURL=Data.js.map
