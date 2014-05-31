;
var Utility = (function () {
    function Utility() { }
    Utility.getShape = function getShape(width, height, color) {
        if(!color) {
            color = "white";
        }
        var shape = new createjs.Shape();
        var g = shape.graphics;
        g.beginFill(color);
        g.drawRect(0, 0, width, height);
        g.endFill();
        shape.mouseEnabled = false;
        return shape;
    };
    return Utility;
})();
//@ sourceMappingURL=Utility.js.map
