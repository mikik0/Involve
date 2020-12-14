var xmlHttpRequest = new XMLHttpRequest();
xmlHttpRequest.onreadystatechange = function () {
  var READYSTATE_COMPLETED = 4;
  var HTTP_STATUS_OK = 200;

  if (this.readyState == READYSTATE_COMPLETED
    && this.status == HTTP_STATUS_OK) {
    // レスポンスの表示
    document.cookie = "user=" + JSON.parse(this.responseText).data.user_id
    console.log(document.cookie, this.responseText);
  }
}
var cookies = document.cookie; //全てのcookieを取り出して
var cookiesArray = cookies.split('; '); // ;で分割し配列に
var value;

for (var c of cookiesArray) { //一つ一つ取り出して
  var cArray = c.split('='); //さらに=で分割して配列に
  if (cArray[0] == 'user') { // 取り出したいkeyと合致したら
    value = cArray[1]
  }
}
xmlHttpRequest.open('POST', "http://localhost:3000/api/v1/users?user_id=" + value);

// データをリクエスト ボディに含めて送信する
xmlHttpRequest.send();


request = new XMLHttpRequest()
request.open("GET", "http://localhost:3000/api/v1/logs", true)
request.responseType = "json"

request.onload = function () {
  const data = this.response
  console.log("data", data)
}
request.send()
console.log(document.cookie)
document.cookie = "user=testuser"

console.log(document.cookie)

//var data = { uri: '' }; // POSTメソッドで送信するデータ
xmlHttpRequest = new XMLHttpRequest();
xmlHttpRequest.onreadystatechange = function () {
  var READYSTATE_COMPLETED = 4;
  var HTTP_STATUS_OK = 200;

  if (this.readyState == READYSTATE_COMPLETED
    && this.status == HTTP_STATUS_OK) {
    // レスポンスの表示
    console.log(this.responseText);
  }
}
url = location.href;
xmlHttpRequest.open('POST', "http://localhost:3000/api/v1/logs?uri=" + url);

// データをリクエスト ボディに含めて送信する
xmlHttpRequest.send();
