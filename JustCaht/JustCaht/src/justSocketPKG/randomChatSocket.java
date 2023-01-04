package justSocketPKG;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/randomChat")
public class randomChatSocket {

	private static Queue<Session> queue = new LinkedList<>();
	private static Map<Session,Session> randomPair = new ConcurrentHashMap<>();
	@OnOpen 
	public void onOpen(Session ses1) throws IOException {

		queue.add(ses1);
		if(queue.size()>=2) {
			Session random1 = queue.poll();
			Session random2 = queue.poll();
			randomPair.put(random1, random2);
			randomPair.put(random2, random1);
			random1.getBasicRemote().sendText("채팅 상대를 찾았습니다\n채팅이 가능합니다");
			random2.getBasicRemote().sendText("채팅 상대를 찾았습니다\n채팅이 가능합니다");
		}else {
			ses1.getBasicRemote().sendText("상대방을 기다리는 중입니다");
		}
	}
	
	@OnMessage 
	public void onMessage(Session ses1,String chat2) throws IOException {
		for (Entry<Session, Session> entrySet : randomPair.entrySet()) {
			
			if(ses1==entrySet.getKey()) {
            	
				ses1.getBasicRemote().sendText(chat2);
            	entrySet.getValue().getBasicRemote().sendText(chat2);
            	break;
            }
        }
	}
	
	@OnError
	public void onError(Throwable e1) {
		e1.printStackTrace();
	}

	@OnClose
	public void onClose(Session ses1) throws IOException {
		if(queue.size()==1&&randomPair.size()==0){
			queue.remove();
		}else {
			Session randomOut = null;
			Session randomWait = null;
			for (Entry<Session, Session> entrySet : randomPair.entrySet()) {
						
						if(ses1==entrySet.getKey()) {
			            	randomOut = ses1;
			            	randomWait = entrySet.getValue();
			            	break;
			            }
			        }
			if(randomOut!=null) {
				randomPair.remove(randomOut);
			}
				
			if(randomWait!=null) {
				randomPair.remove(randomWait);
				randomWait.getBasicRemote().sendText("상대방이 퇴장하였습니다");
				queue.add(randomWait);
			}
			
			if(queue.size()>=2) {
				Session random1 = queue.poll();
				Session random2 = queue.poll();
				randomPair.put(random1, random2);
				randomPair.put(random2, random1);
				random1.getBasicRemote().sendText("채팅 상대를 찾았습니다\n채팅이 가능합니다");
				random2.getBasicRemote().sendText("채팅 상대를 찾았습니다\n채팅이 가능합니다");
			}else {
			
				randomWait.getBasicRemote().sendText("새로운 상대방을 기다리는 중입니다");
			}
		}
	}
}