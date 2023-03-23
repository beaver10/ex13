

//<script type="text/javascript">
   getList();
   var memberId = "${memberId}";

   
   $("#txtMessage").on("keydown", function(e) {
      if (e.keyCode == 13 && !e.shiftKey) {
         e.preventDefault();
         var message = $("#txtMessage").val();
         if (message == "") {
            alert("내용을 입력하세요!");
            return;
         }
         $("#txtMessage").val("");
         
       	 //메세지 테이블에 등록
         $.ajax({
        	 type: "post",
        	 url: "/chat/add",
        	 data: {"sender": memberId, "message":message},
        	 success: function(data){
        		//메세지 보내기...
                sock.send(memberId + "|" + message + "|" + data);
        		//sock.send("insert");
        	 }
         });
      }
   });

   //웹소켓 생성
   var sock = new SockJS("http://192.168.1.199/echo/");
   sock.onmessage = onMessage;
   
   //서버로부터 메세지 받기...
   function onMessage(msg) {
      var items = msg.data.split("|");
      var sender = items[0];   
      var message = items[1];
      var id= items[2];
      var date = items[3];
      
      var data = {
         "message" : message,
         "sender" : sender,
         "chatDate" : date,
         "id": id,
      };

      var template = Handlebars.compile($("#temp1").html());
      $("#chat").append(template(data));

      //스크롤바 아래 고정
      window.scrollTo(0, $('#chat').prop('scrollHeight'));
   }

    function getList() {
      $.ajax({
         type : "get",
         url : "/chat.json",
         dataType : "json",
         success : function(data) {
            var template = Handlebars.compile($("#temp").html());
            $("#chat").html(template(data));
         }
      });
   } 
// </script>