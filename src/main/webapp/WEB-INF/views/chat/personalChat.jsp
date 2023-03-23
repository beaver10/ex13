<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<title>채팅</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />

<script
   src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/personalChat.css">

<div class="inner">
      <div class="chat-container">
           <div class="title-container">
               <span class="glyphicon glyphicon-list list"></span>
               <span class="title"><i class="fa fa-comments-o" ></i> 채팅</span>
               <span class="glyphicon glyphicon-cog option"></span>
               <div class="function-conatiner">
                   <ul>
                       <li><span class = "glyphicon glyphicon-cog"> 채팅기능</span></li>
                       <li class = " cursor autoReload"><span class = "glyphicon glyphicon-play"></span> RELOAD자동</li>
                       <li class = " cursor manualReload"><span class = "glyphicon glyphicon-wrench"></span> RELOAD수동</li>
                       <li class = " cursor stopReload"><span class = "glyphicon glyphicon-stop"></span> RELOAD중지</li>
                       <li class = " cursor exit-btn"><span class="glyphicon glyphicon-log-out"></span> 채팅방나가기</li>
                   </ul>
               </div>
           </div>
           <div class="print"></div>
          
           <div class="text-container">
	       	 <input type="hidden" id="reciver" value="${dto.memberId}"> 
		 	 <input type="hidden" id="sender" value="${sessionScope.memberId}"> 
			 <input type="hidden" id="room"> 
			 <input type="hidden" id="listSize">
	         <textarea placeholder="메세지를 입력하세요." class="text"></textarea>
	         <span class="send-btn glyphicon glyphicon-send"></span>
         </div>
     </div>
  </div>
<script type="text/javascript">

var sock = new SockJS("http://localhost/echo/");
sock.onmessage = getMessageList;
sock.onclose = onClose;


	$(".function-conatiner").hide()
	$(".option").click(function () { 
		    $(".function-conatiner").toggle()
	})

	checkRoomInfo();
	//생성된 룸  정보 확인 
	function checkRoomInfo(){
		let sender = $("#sender").val();
		let reciver = $("#reciver").val();
		$.ajax({
			url: "../chat/getRoomNumber",
			method: "post",
			dataType: "json",
			data: {"sendId":sender, "recvId":reciver},
			success: function(data){
				$("#room").val(data);
				getMessageList();
				return;
			}
		})
	}	
	
	
	//메세지 내역 가져오기 
	function getMessageList() {
		
		let sender = $("#sender").val();
		let room = $("#room").val();
		$("#reportRoom").val(room)
		$.ajax({
			url: "../chat/chatList",
			method: "post",
			dataType: "json",
			data: {"sendId":sender, "room":room},
			success: function(data){
				$("#listSize").val(data.length)
				let count = 0;
				if(data.length != 0){
					count = data[0].exitCount;
				}
				let s = "<ul class='show-message'>";
				for(i=0; i<data.length; i++){
					if(sender == data[i].sendId){
						s += "<li class='chat-info'>";
						s += "<div class='right-container'>";
						s += "<pre class='sender-content'>"+data[i].content+"</pre>";
						s += "<span class='send-time right-time'>"+data[i].sendTime
						if(data[i].read_check == 0){
						s += "<span class ='unread-message'>  미확인</span>"
						}
						s += "</span>";
						s += "</div>";
						s += "</li>";
					}else{
		                s += "<li class='chat-info'>";
		                s += "<div class='left-container'>";
		                if(data[i].photo != null){
			                s += "<img class='profile-img' src='../profile_image/"+data[i].photo+"' alt='프로필이미지'>";
		                }else{
			                s += "<img class='profile-img' src='../profile_image/basic.jpg' alt='프로필이미지'>";
		                }
		                s += "<span class='reciver-id'>"+data[i].sendId+"</span>";
		                s += "<pre class='reciver-content'>"+data[i].content+"</pre>";
		                s += "<span class='send-time left-time'>"+data[i].sendTime+"</span>";
		                s += "</div>";
		                s += "</li>";
					}
					
					//만약 상대가 나갔다면 이렇게 보임  
					if(data[i].exitCount > 0){
						s += "<pre class='exit-message '><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</pre>"
						$(".text").attr({
							readonly:'readonly',
							placeholder:'메세지 전송이 불가능합니다.'
						})
						$(".send-btn").hide();
				 	}
				}
				
					
				s +="</ul>";
				$(".print").html(s);
				//스크롤 아래로 내리기  
				$(".show-message").scrollTop($(".show-message")[0].scrollHeight);
				
			}
		})
	}
	
	//메세지 최대 1000자 
	$(".text").keyup(function(){
		let content = $(this).val()
		let contentSize = (content.length+content.split('\n').length-1);
		if(contentSize > 1000){
			alert("1000자 이하로 입력해주세요")
			$(this).val(content.substring(0, 1000));
			return;
		}
	})
	
	
	//메세지 전송 버튼 
	$(".send-btn").click(function() {
		if(content.trim() == ""){
			alert("메세지를 입력해주세요")
			 $(".text").val("");
			 $(".text").focus("");
			return
		}
		$.ajax({
			url: "../chat/send",
			method: "post",
			data: {"sendId":sender, "recvId":reciver, "content":content, "room":room},
			success: function(data){
				//메세지 보내기  
				sock.send (sender+"|"+content+"|"+data);
/* 				getMessageList();
 */			}
		})
		
	});
	
	//엔터키로 메세지를 전송합니다 
	$(".text").keydown(function(key) {
    if (key.keyCode == 13) {
    	  if (!key.shiftKey){
    		  $('.send-btn').trigger('click');
          }
    	}
	});
	
	
	//채팅방 나가기 버튼 
	$(".exit-btn").click(function() {
		if($("#listSize").val() == 0){
			alert("채팅 내역이 없습니다.")
			return;
		}
		let exitId = $("#sender").val();
		let roomInfo = $("#room").val();
		let check = confirm("채팅방을 나가시 겠습니까?");
		if(check == true){
			$.ajax({
		  		url: "../chat/exit",
				method: "post",
		  		data: {"exitId":exitId, "room":roomInfo},
				success: function onClose(evt){
					$("#data").append("연결 끊김");
					location.href = "list";
				}	
			});
	  		
		}
  	});
	
	
	
	//채팅 목록으로 이동하기 
	$(".list").click(function() {
		if($("#listSize").val()>0){
			function onClose(evt){
				$("#data").append("연결 끊김");
				location.href='../chat/list';
			}
		}else{
			alert("채팅 내역이 없습니다.");
			return;
		}
	});

	
	
	//reload
  	$(window).keydown(function(key) {
        if (key.keyCode == 65 && key.shiftKey) {
        	$(".autoReload").trigger('click');
        }else if (key.keyCode == 83 && key.shiftKey) {
        	$(".stopReload").trigger('click');
		}else if (key.keyCode == 90 && key.shiftKey){
        	$(".manualReload").trigger('click');
		} 
    });
	//reload
	$(".manualReload").click(function() {
		getMessageList()
	})
	$(".autoReload").click(function() {
		StartReload()
	})
	$(".stopReload").click(function() {
		StopReload()
	})

   	function StartReload() {
   		getMessageList();
   		alert("auto reload start")
   	   	reload = setInterval(getMessageList, 1000);
   	}
   	function StopReload() {
   		clearInterval(reload);
   		alert("auto reload stop")
   	}
</script>