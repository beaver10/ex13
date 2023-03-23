package com.team.cwl.chat;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.cwl.member.MemberDTO;


@Service
public class ChatService {
	
	@Autowired
	ChatDAO chatDAO;
	
	public void setSendMessage(ChatDTO chatDTO) {
		chatDAO.setSendMessage(chatDTO);
	}
	public List<ChatDTO>  getRoomContentList(ChatDTO chatDTO){
		List<ChatDTO> list = chatDAO.getRoomContentList(chatDTO);
		return list;
	}
	public int getMaxRoom() {
		return chatDAO.getMaxRoom();
	}
	public String getRoomNumber(ChatDTO chatDTO) {
		
		String room = chatDAO.getRoomNumber(chatDTO);
		System.out.println("서비스 방"+room);
		
		//new room
		if(room==null) {
			long temp = chatDAO.getMaxRoom()+1;
			room = String.valueOf(temp);
		}
		
		System.out.println("서비스 방2"+room);
		return room;
	}
	
	public List<ChatDTO> getChatList(String memberId){
		List<ChatDTO> list = chatDAO.getChatList(memberId);
		System.out.println("서비스 :"+list);
		return list;
	}
	public int getCountUnreadMessage(ChatDTO chatDTO) {
		int unread = chatDAO.getCountUnreadMessage(chatDTO);
		return unread;
	}
	
	public void setChangeMessageReadCheck(ChatDTO chatDTO) {
		chatDAO.setChangeMessageReadCheck(chatDTO);
	}
	
	public void setChangeMessageReadTime(ChatDTO chatDTO) {
		chatDAO.setChangeMessageReadTime(chatDTO);
	}
	
	public String getOtherProfile(ChatDTO chatDTO) {
		return chatDAO.getOtherProfile(chatDTO);
	}
	
	public int getCountExitId(Long room) {
		return chatDAO.getCountExitId(room);
	}
	
	public String getExitId(Long room) {
		return chatDAO.getExitId(room);
	}
	
	public void setUpdateExitId(Long room, String exitId) {
		chatDAO.setUpdateExitId(room, exitId);
	}
	
	public void setDeleteRoom(Long room) {
		chatDAO.setDeleteRoom(room);
	}
}

	

