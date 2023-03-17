package com.team.cwl.chat;

import java.io.FileInputStream;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping("/chat.json")
	public List<ChatDTO> getChatList(ChatDTO chatDTO) throws Exception{
		return chatService.getChatList(chatDTO);
		
	}
	
	@RequestMapping(value="/chat/add", method=RequestMethod.POST)
	public void setChatAdd(ChatDTO chatDTO) throws Exception{
		chatService.setChatAdd(chatDTO);
	}
	


}
