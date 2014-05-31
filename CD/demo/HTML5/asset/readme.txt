Createjs.Textクラスの日本語入力は改行が利かない。これは、英単語の改行をスペース区切りで行っているため。
//------------------
var text = new createjs.Text(str, "30px _等幅", "#FF7700");
text.lineWidth = 800;//800を超えたら折り返しされるはずだが、日本語では無理。
//------------------

そこで今回はDOMElementを用いる。これはHTMLのテキストとして扱われる。DOMElementはすでに画面上には表示
されているのだが、改めてstageにaddChildしなければならない。
//------------------
var htmlElement:HTMLElement = <HTMLElement>document.getElementById("textArea");
var textArea:createjs.DOMElement = new createjs.DOMElement(htmlElement);
stage.addChild(textArea); //★
textArea.x = 20;
textArea.y = 550 + 40;
//テキストの変更
textArea.htmlElement.innerText = "テキスト";
//------------------
ただしHTMLTextはマスクが掛けれない。
