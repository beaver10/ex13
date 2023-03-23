package com.team.cwl.chat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessionList=new ArrayList<>();
	List <WebSocketSession> my = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> map = new HashMap<String, WebSocketSession>();
	Map<String, List<WebSocketSession>> maps = new HashMap<String, List<WebSocketSession>>();
	
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결됨 : " + session);
		sessionList.add(session);
		System.out.println( sessionList.size());
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println( session.getId());
		sessionList.remove(session);
		super.afterConnectionClosed(session, status);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String strMessage=message.getPayload();
		System.out.println( strMessage);
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(new Date());
		strMessage += "|" + strDate;
		
		for(WebSocketSession webSocketSession:sessionList){
			webSocketSession.sendMessage(new TextMessage(strMessage));
		}
		super.handleTextMessage(session, message);
	}
	
	public void myMethod() {
		
	}
}
