package com.team.cwl.chat;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private final String NAMESPACE="com.team.cwl.chat.ChatDAO.";
	
	
	//채팅방 가져오기 
	public List<ChatDTO> getChatList(ChatDTO chatDTO) throws Exception{
		System.out.println("DAO");
		return sqlSession.selectList(NAMESPACE + "getChatList", chatDTO);
	}

	//채팅 보내기  
	public int setChatAdd(ChatDTO chatDTO) {
		return sqlSession.insert(NAMESPACE + "setChatAdd", chatDTO);
	}


}
