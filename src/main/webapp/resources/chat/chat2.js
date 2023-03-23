let sock = new SockJS("http://192.168.1.199/echo/");

$("#txtMessage").on("keydown", function(e) {
    if (e.keyCode == 13 && !e.shiftKey) {
       e.preventDefault();
       var message = $("#txtMessage").val();
       if (message == "") {
          alert("내용을 입력하세요!");
          return;
        }     
          //메세지 테이블에 등록
       sock.send($("#txtMessage").val())
       $("#txtMessage").val("")
 }
});

sock.addEventListener('open', function (event) {
    console.log("연결 성공")
    // 연결이 성공했을 때 처리할 작업
});
  
sock.addEventListener('message', function (event) {
    console.log(event.data)
});
  
sock.addEventListener('error', function (event) {
    console.log(event)
    // 오류 처리 작업
});
  
sock.addEventListener('close', function (event) {
    // 웹소켓이 닫혔을 때 처리할 작업
});