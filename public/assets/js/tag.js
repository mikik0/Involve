const request = new XMLHttpRequest()
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