package justSocketPKG;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import bbs.BbsDAO;


@ServerEndpoint("/roomChat")
public class roomChatSocket {

	
	
//	private static List<Session> Listclient 
//									= Collections.synchronizedList(new ArrayList<>());
		
	
	private static Map<Session,String> clientRoom = new ConcurrentHashMap<>();
	private static Map<Session,String> clientName = new ConcurrentHashMap<>();
	BbsDAO bbsDAO = new BbsDAO();
	
	
	@OnOpen 
	public void onOpen(Session ses1) {
//		Listclient.add(ses1);
		
	}
	
			
	@OnMessage 
	public void onMessage(Session ses1,String chat2) throws IOException {
						
		if(chat2.matches("^clientInfo.*")){
			
			String room = chat2.split("/",3)[1];
			String name = chat2.split("/",3)[2];
			int n=0;
			List<Session> list 
			= Collections.synchronizedList(new ArrayList<>());
			clientRoom.put(ses1, room);
			clientName.put(ses1, name);
			
			for (Entry<Session, String> entrySet : clientRoom.entrySet()) {
				
				if(room.equals(entrySet.getValue())) {
					Session ses = entrySet.getKey();
					n++;
					list.add(ses);
					ses.getBasicRemote().sendText(name+" 님이 채팅에 참가하였습니다");
	            	
	            }
	        }
			list.remove(ses1);
			ses1.getBasicRemote().sendText("add/"+n+"/"+name);
			synchronized(list) {
				for(Session ses : list) {
					
					ses.getBasicRemote().sendText("add/"+n+"/"+name);
					ses1.getBasicRemote().sendText("add/"+n+"/"+clientName.get(ses));
				}
			}
			
			bbsDAO.updateNumber(Integer.parseInt(room),Integer.toString(n));
			
		}else if(chat2.matches("^whisper.*")){
			String sender = chat2.split("/",4)[1];
			String receiver = chat2.split("/",4)[2];
			String chat3 = chat2.split("/",4)[3];
			int count=0;
			for (Entry<Session, String> entrySet : clientName.entrySet()) {
				
				if(receiver.equals(entrySet.getValue())) {
	            	count=1;
	            	ses1.getBasicRemote().sendText("["+receiver+" 님에게 귓속말]"+chat3);
	            	entrySet.getKey().getBasicRemote().sendText("["+sender+" 님으로부터 귓속말]"+chat3);	            	
	            	break;
	            }
	        }
			if(count==0) {
				ses1.getBasicRemote().sendText("귓속말 상대를 찾을 수 없습니다");
			}
			
		}else{//메세지 전송
			
			String room=clientRoom.get(ses1);
			
			for (Entry<Session, String> entrySet : clientRoom.entrySet()) {
				
				if(room.equals(entrySet.getValue())) {
	            	
	            	entrySet.getKey().getBasicRemote().sendText(chat2);
	            	
	            }
	        }
			
	
	
		}
	}
	
	@OnError
	public void onError(Throwable e1) {
		e1.printStackTrace();
	}
	
	
	
	
	@OnClose
	public void onClose(Session ses1) throws IOException{
		int n=0;
		List<Session> list 
		= Collections.synchronizedList(new ArrayList<>());
		String room=clientRoom.get(ses1);
		String name=clientName.get(ses1);
		clientRoom.remove(ses1);
		clientName.remove(ses1);
		for (Entry<Session, String> entrySet : clientRoom.entrySet()) {
			
			if(room.equals(entrySet.getValue())) {
				Session ses = entrySet.getKey();
				n++;
				list.add(ses);
            	ses.getBasicRemote().sendText(name+" 님이 퇴장하셨습니다");
            	
            }
        }
		synchronized(list) {
			for(Session ses : list) {
				ses.getBasicRemote().sendText("remove/"+n+"/"+name);
			}
		}
		bbsDAO.updateNumber(Integer.parseInt(room),Integer.toString(n));
//		Listclient.remove(ses1); 

	}

}