<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />

<script
   src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/message.css">

<div class="inner">
	<div class="list-container">
		<div class="title-container">
			<span class="title"><i class="fa fa-comments-o"></i> 채팅</span>
		</div>
		<c:choose>
			<c:when test="${list.size() == 0}">
				<p class="empty-message">
					참여중인 채팅이 없습니다. <br> <span class="empty-message2">맴버와
						채팅을 시작해보세요</span>
				</p>
			</c:when>
			<c:otherwise>
				<ul>
					<c:forEach var="messageInfo" items="${list}">
						<%-- <c:if test="${messageInfo.exitId != sessionScope.id}"> --%>
						<li class="info-container">
							<div class="open-chat">
								<input type="hidden" id="loginUser" value="${sessionScope.memberId}">
								<input type="hidden" id="exitCount" value="${messageInfo.exitCount}"> 
								<input type="hidden" id="room" value="${messageInfo.room}">
								<c:choose>
									<c:when test="${messageInfo.profileEmojiNum == null}">
										<img class="profile-img" src="../profile_image/basic.jpg"alt="프로필이미지">
									</c:when>
									<c:otherwise>
										<img class="profile-img" src="../profile_image/${messageInfo.profileEmojiNum}" alt="프로필이미지">
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${messageInfo.recvId == sessionScope.memberId}">
										<input type="hidden" id="reciver" value="${messageInfo.sendId  }">
									</c:when>
									<c:otherwise>
										<input type="hidden" id="reciver" value="${messageInfo.recvId  }">
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${messageInfo.sendId == sessionScope.id}">
										<span class="chat-id">${messageInfo.recvId}</span>
									</c:when>
									<c:otherwise>
										<span class="chat-id">${messageInfo.sendId }</span>
									</c:otherwise>
								</c:choose>
								<span class="chat-time">${messageInfo.sendTime}</span>
								<c:choose>
									<c:when test="${messageInfo.exitCount >0}">
										<span class="chat-content"><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</span>
									</c:when>
									<c:otherwise>
										<span class="chat-content">${messageInfo.content}</span>
									</c:otherwise>
								</c:choose>
								<c:if test="${messageInfo.unRead != 0}">
									<span class="unRead-count">안읽은메세지 ${messageInfo.unRead}</span>
								</c:if>
							</div>
							<div class="option-cotainer">
								<span class="glyphicon glyphicon-option-vertical list-btn"></span>
								<div class="option-list">
									<span class="read-btn cursor">읽음</span> <input type="hidden" id="unReadCheck" value="${messageInfo.unRead}">
									<hr>
									<span class="exit-list cursor">나가기</span>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="chat-container">
		<div class="title-container">
			<span class="glyphicon glyphicon-list list"
				onclick="location.href='list'"></span> <span class="title"><i
				class="fa fa-comments-o"></i> 채팅</span> <span
				class="glyphicon glyphicon-cog option"></span>
			<div class="function-conatiner">
				<ul>
					<li><span class="glyphicon glyphicon-cog"> 채팅기능</span></li>
					<li class=" cursor autoReload"><span class="glyphicon glyphicon-play"></span> RELOAD자동</li>
					<li class=" cursor manualReload"><span class="glyphicon glyphicon-wrench"></span> RELOAD수동</li>
					<li class=" cursor stopReload"><span class="glyphicon glyphicon-stop"></span> RELOAD중지</li>
					<li class=" cursor exit-btn"><span class="glyphicon glyphicon-log-out"></span> 채팅방나가기</li>
					<!-- <li class = " cursor report-btn"><span class="glyphicon glyphicon-bullhorn"></span> 신고하기</li> -->
				</ul>
			</div>
		</div>
		<div class="print"></div>
	<script id="temp" type="text/x-handlebars-template">
      {{#each .}}
      <div class="{{printLeftRight sender}}">
      	<div class="sender" style="display:{{printImg sender}}">
			{{sender}}
		</div>
      	<div class="message">
			{{message}} 
		</div>
      	<div class="date">{{chatDate}}</div>
      </div>
      {{/each}}
      </script>
      <script id="temp1" type="text/x-handlebars-template">
      	<div class="{{printLeftRight sender}}">
      	<div class="sender" style="display:{{printImg sender}}">
			{{sender}}
		</div>
      	<div class="message">
			{{message}}
		</div>
      	<div class="date">{{regdate}}</div>
      	</div>
      </script>
      <script>
         var memberId = "${memberId}";
         Handlebars.registerHelper("printLeftRight", function(sender) {
            if (memberId != sender) {
               return "left";
            } else {
               return "right";
            }
         });
         Handlebars.registerHelper("printNone", function(sender) {
             if (memberId != sender) return "none";             
         });
         Handlebars.registerHelper("printImg", function(sender) {
             if (memberId== sender) return "none";             
         });
      </script>

		<div class="text-container">
			<input type="hidden" id="reciverInfo"> <input type="hidden" id="senderInfo"> 
			<input type="hidden" id="roomInfo">
			<input type="hidden" id="exitCountInfo">
			<textarea placeholder="메세지를 입력하세요." class="text"></textarea>
			<span class="send-btn glyphicon glyphicon-send"></span>
		</div>
	</div>
</div>


<script>



var sock = new SockJS("http://localhost/echo/");
sock.onmessage = getMessageList;



	//숨기기
	$(".option-list").hide()
	$(".chat-container").hide()
	$(".function-conatiner").hide()
	
	//채팅리스트에 있는 옵션기능 버튼
	$(".list-btn").click(
		function() {
			$(this).parent().parent().siblings().children().children(
					".option-list").hide();
			$(this).next(".option-list").toggle();
		})
		
	//채팅화면에 있는 기능버튼
	$(".option").click(function() {
		$(".function-conatiner").toggle()
	})
	
	
//대화목록중 선택시 채팅정보 가져오고 채팅 시작
	$(".open-chat").click(function() {
		$(".chat-container").show();
		$(".list-container").hide();
		$(".text").focus();
		let sender = $(this).find("#loginUser").val();
		let reciver = $(this).find("#reciver").val();
		let room = $(this).find("#room").val();
		let exitCount = $(this).find("#exitCount").val();

		$("#reportRoom").val(room)
		$("#senderInfo").val(sender);
		$("#reciverInfo").val(reciver);
		$("#roomInfo").val(room);
		$("#exitCountInfo").val(exitCount);

		senderInfo = $("#senderInfo").val();
		roomInfo = $("#roomInfo").val();

		$.ajax({
			url : "../chat/chatList",
			method : "post",
			dataType : "json",
			data : {
				"sendId" : sender,
				"room" : room
			},
			success : function(data) {
				let s = "<ul class='show-message'>";
				for (i = 0; i < data.length; i++) {
					if (sender == data[i].sendId) {
						s += "<li class='chat-info'>";
						//본인이 보낸 메세지 관련 정보
						s += "<div class='right-container'>";
						s += "<pre class='sender-content'>"+ data[i].content+ "</pre>";
						s += "<span class='send-time right-time'>"+ data[i].sendTime
						if (data[i].read_check == 0) {
							s += "<span class ='unRead-message'>  미확인</span>"
						}
						s += "</span>";
						s += "</div>";
						s += "</li>";
					} else {
						s += "<li class='chat-info'>";
						//상대방이 보낸 메세지 관련정보
						s += "<div class='left-container'>";
						//프로필 이미지 출력
						if (data[i].profileEmojiNum != null) {
							s += "<img class='profile-img' src='../profile_image/"+data[i].profileEmojiNum+"' alt='프로필이미지'>";
						} else {
							s += "<img class='profile-img' src='../profile_image/basic.jpg' alt='프로필이미지'>";
						}
						s += "<span class='reciver-id'>"+ data[i].sendId + "</span>";
						s += "<pre class='reciver-content'>" + data[i].content + "</pre>";
						s += "<span class='send-time left-time'>" + data[i].sendTime + "</span>";
						s += "</div>";
						s += "</li>";
					}
					
					//상대가 채팅방을 나갔을 경우 출력
					if (data[i].exitCount > 0) {
						s += "<pre class='exit-message '><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</pre>"
						$(".text").attr({
							readonly : 'readonly',
							placeholder : '메세지 전송이 불가능합니다.'
						})
						$(".send-btn").hide();
					}
				}
				s += "</ul>";
				//채팅내역 출력
				$(".print").html(s);
				//스크롤을 제일 아래로 내려주는 기능
				$(".show-message").scrollTop($(".show-message")[0].scrollHeight);
			}
		});
	});
	//메세지 글자 수 체크 1000자 제한
	$(".text").keyup(function() {
		let content = $(this).val()
		let contentSize = (content.length + content.split('\n').length - 1);
		if (contentSize > 1000) {
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
	
	
	//엔터키로 메세지 전송
	$(".text").keydown(function(key) {
		  //(13번은 엔터키)
		if (key.keyCode == 13) {
			 //shitf키를 누르지 않았을 경우에만 전송
			if (!key.shiftKey) {
				$('.send-btn').trigger('click');
			}
		}
	});
	
	
    //매세지 내역 불러오기
	function getMessageList() {
		$.ajax({
			url : "../chat/chatList",
			method : "post",
			dataType : "json",
			data : {
				"sendId" : senderInfo,
				"room" : roomInfo
			},
			success : function(data) {
				let s = "<ul class='show-message'>";
				for (i = 0; i < data.length; i++) {
					if (senderInfo == data[i].sendId) {
						s += "<li class='chat-info'>";
						//본인이 보낸 메세지 관련 정보
						s += "<div class='right-container'>";
						s += "<pre class='sender-content'>"+ data[i].content + "</pre>";
						s += "<span class='send-time right-time'>"+ data[i].sendTime
						if (data[i].read_check == 0) {
							s += "<span class ='unRead-message'>  미확인</span>"
						}
						s += "</span>";
						s += "</div>";
						s += "</li>";
					} else {
						s += "<li class='chat-info'>";
						//상대방이 보낸 메세지 관련 정보
						s += "<div class='left-container'>";
/* 						//상대방의 프로필
						if (data[i].profileEmojiNum != null) {
							s += "<img class='profile-img' src='../profile_image/"+data[i].profileEmojiNum+"' alt='프로필이미지'>";
						} else {
							s += "<img class='profile-img' src='../profile_image/basic.jpg' alt='프로필이미지'>";
						} */
						s += "<span class='reciver-id'>"+ data[i].sendId + "</span>";
						s += "<pre class='reciver-content'>"+ data[i].content + "</pre>";
						s += "<span class='send-time left-time'>"+ data[i].sendTime + "</span>";
						s += "</div>";
						s += "</li>";
					}
					//상대방이 채팅방을 나갔을 경우 보여질 부분
					if (data[i].exitCount > 0) {
						s += "<pre class='exit-message '><span class='glyphicon glyphicon-log-out'></span> 상대방이 채팅방을 나가셨습니다.</pre>"
						$(".text").attr({
							readonly : 'readonly',
							placeholder : '메세지 전송이 불가능합니다.'
						})
						$(".send-btn").hide();
					}
				}
				s += "</ul>";
				$(".print").html(s);
				//스크롤을 제일 아래로 내리기
				$(".show-message").scrollTop($(".show-message")[0].scrollHeight);
			}
		});
	}
    
	//메세지 읽음처리하기
	$(".read-btn").click(function() {
		if ($(this).next("#unReadCheck").val() == 0) {
			alert("미확인 메세지가 없습니다.")
			return;
		}
		let selectedRoom = $(this).parent().parent().siblings().find("#room").val()
		let loginUserInfo = $("#loginUser").val()
		$.ajax({
			url : "../chat/read",
			method : "post",
			data : {
				"sendId" : loginUserInfo,
				"room" : selectedRoom
			},
			success : function(data) {
				location.href = "list";
			}
		});
	});
	
	//채팅방 나가기(대화상대 목록에서)
	$(".exit-list").click(function() {
		let check = confirm("채팅방을 나가시 겠습니까?");
		if (check == true) {
			let exitRoom = $(this).parent().parent().siblings().find("#room").val()
			let exitId = $(this).parent().parent().siblings().find("#loginUser").val()
			$.ajax({
				url : "../chat/exit",
				method : "post",
				data : {
					"exitId" : exitId,
					"room" : exitRoom
				},
				success : function() {
					location.href = "list";
				}
			});
		}
	});
	
	//채팅방 나가기(채팅방에서)
	$(".exit-btn").click(function() {
		let check = confirm("채팅방을 나가시 겠습니까?");
		if (check == true) {
			$.ajax({
				url : "../chat/exit",
				method : "post",
				data : {
					"exitId" : senderInfo,
					"room" : roomInfo
				},
				success : function() {
					location.href = "list";
				}
			});
		}
	});
         


</script>
</html>



