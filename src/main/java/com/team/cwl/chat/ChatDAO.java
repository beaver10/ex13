package com.team.cwl.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team.cwl.member.MemberDTO;


@Repository
public class ChatDAO {

    @Autowired
    private SqlSession sqlSession;

	private final String NAMESPACE="com.team.cwl.chat.ChatDAO.";

    public List<ChatDTO> getChatList(String memberId) {
        return sqlSession.selectList(NAMESPACE + "getChatList", memberId);
    }

    public List<ChatDTO> getRoomContentList(ChatDTO chatDTO) {
        return sqlSession.selectList(NAMESPACE + "getRoomContentList", chatDTO);
    }

    public void setSendMessage(ChatDTO chatDTO) {
        sqlSession.insert(NAMESPACE + "setSendMessage", chatDTO);
    }

    public String getRoomNumber(ChatDTO chatDTO) {
        return sqlSession.selectOne(NAMESPACE + "getRoomNumber", chatDTO);
    }

    public int getMaxRoom() {
        return sqlSession.selectOne(NAMESPACE + "getMaxRoom");
    }

    public int getCountUnreadMessage(ChatDTO chatDTO) {
        return sqlSession.selectOne(NAMESPACE + "getCountUnreadMessage", chatDTO);
    }

    public void setChangeMessageReadCheck(ChatDTO chatDTO) {
        sqlSession.update(NAMESPACE + "setChangeMessageReadCheck", chatDTO);
    }

    public void setChangeMessageReadTime(ChatDTO chatDTO) {
        sqlSession.update(NAMESPACE + "setChangeMessageReadTime", chatDTO);
    }


    public String getOtherProfile(ChatDTO chatDTO) {
        return sqlSession.selectOne(NAMESPACE + "getOtherProfile", chatDTO);
    }


    public int getCountExitId(Long room) {
        return sqlSession.selectOne(NAMESPACE + "getCountExitId", room);
    }


    public void setUpdateExitId(Long room, String exitId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("room", room);
        map.put("exitId", exitId);
        sqlSession.update(NAMESPACE + "setUpdateExitId", map);
    }
    

    public void setDeleteRoom(Long room) {
        sqlSession.delete(NAMESPACE + "setDeleteRoom", room);
    }

    public String getExitId(Long room) {
        return sqlSession.selectOne(NAMESPACE + "getExitId", room);
    }
}


