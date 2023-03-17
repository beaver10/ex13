package com.team.cwl.chat;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ChatDTO extends MemberDTO{
	private Long chatNum;
	private String sender;
	private String message;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date chatDate;

	
	


	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Long getChatNum() {
		return chatNum;
	}

	public void setChatNum(Long chatNum) {
		this.chatNum = chatNum;
	}

	public Date getChatDate() {
		return chatDate;
	}

	public void setChatDate(Date chatDate) {
		this.chatDate = chatDate;
	}


}
