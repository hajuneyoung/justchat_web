<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.io.PrintWriter" %>
  <% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/mycss.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<title>Random chatting</title>

<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "js/bootstrap.js"></script>
<%
String roomID = request.getParameter("roomID");
String roomTitle = request.getParameter("roomTitle");
String userID = request.getParameter("userID");
String userNickName = request.getParameter("userNickName");
String clientInfo = roomID+"/"+userNickName;

%>
</head>
<body>

<div class="container">

    <!-- Page header start -->
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			
			<a class="navbar-brand" href="random.jsp?userNickName=<%=userNickName%>&userID=<%=userID%>"
					>랜덤채팅
			</a>
		</div>
		<div class ="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li>
				<a href="main.jsp?userNickName=<%=userNickName%>&userID=<%=userID%>"
					>메인
				</a>
				</li>
				<li><a href="bbs.jsp?userNickName=<%=userNickName%>&userID=<%=userID%>">대기방</a></li>				
			</ul>
			
			<%
				if(userID == null){
			%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>	
			</ul>
			<%	
				}else{
					
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
			
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>	
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>    
    <div class="page-title">
        <div class="row gutters">
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
                <h5 class="title">1대1 랜덤채팅</h5>
                자동스크롤 <input type="checkbox" id="autoScroll" checked="checked">
            </div>
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12"> </div>
        </div>
    </div>
    <!-- Page header end -->

    <!-- Content wrapper start -->
    <div class="content-wrapper">

        <!-- Row start -->
        <div class="row gutters">

            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">

                <div class="card m-0">

                    <!-- Row start -->
                    <div class="row no-gutters">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-3 col-3">
                            <div class="users-container">
                                <div></div>
                                
                                <ul class="users" id="users" style="overflow:auto; max-height:30vh;">
                                    
                                    
                                </ul>
                                <ul class="users" id="notice" style="overflow:auto; max-height:30vh;">
                                </ul>
                            </div>
                        </div>
                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-9 col-9">
                            <div class="chat-container" id="whisperContainer" style="overflow:auto;max-height:15vh;">
                            	<ul class="chat-box chatContainerScroll" id="whisperBox">
                            	</ul>
                                <span><span class="name"></span></span>
                            </div>
                            <div class="chat-container" id="chatContainer" style="overflow:auto;max-height:60vh;min-height:30vh;">
                                <ul class="chat-box chatContainerScroll" id="chatBox">
                                    
                                    
                                </ul>
                              
                            </div>
                            <div class="chat-container">
                            	<div class="form-group mt-3 mb-0">
                                    <input type="text" class="form-control" placeholder="메세지를 입력해주세요..."
                                    id="chat1" onkeyup="enterkey()">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Row end -->
                </div>

            </div>

        </div>
        <!-- Row end -->

    </div>
    <!-- Content wrapper end -->

</div>
<script>
var ws1 
= new WebSocket("ws://localhost:8080"+"<%=request.getContextPath()%>/randomChat"); 
 		          

												
												
												
var chat1 = document.getElementById("chat1");
var userNickName = '<%=userNickName%>';
var scrollButton = 1;							

ws1.onerror = function(aa){
	alert("error");
};

ws1.onopen = function(aa){
	
	
	
};

ws1.onclose = function(aa){
	
}

ws1.onmessage = function(aa){
	if(/^\[.*\].*/.test(aa.data)){//일반메세지
		if(aa.data.split('[',2)[1].split(']',2)[0]=='<%=userNickName%>'){
			//내가 보낸 메세지
			
		    
		    var liChat = document.createElement( "li" );
		    liChat.setAttribute('class','chat-right');		    
		    var divChat = document.createElement( "div" );
		    divChat.setAttribute('class','chat-text');
		    divChat.innerHTML = aa.data.split(']',2)[1];
		    var divAvatar = document.createElement( "div" );		    
		    divAvatar.setAttribute('class','chat-avatar');
		    var divName = document.createElement( "div" );		    
		    divName.setAttribute('class','chat-name');
		    divName.innerHTML = '<%=userNickName%>';
		    var divHour = document.createElement( "div" );		 
		    liChat.appendChild(divHour);
		    liChat.appendChild(divChat);
		    liChat.appendChild(divAvatar);
		    liChat.appendChild(divName);
		   
		    document.getElementById("chatBox").appendChild(liChat);
		    if(document.getElementById("autoScroll").checked){
		    	document.getElementById("chatContainer").scrollTop = 
		    		document.getElementById("chatContainer").scrollHeight;
		    }		
	    }else{//다른 사람이 보낸 메세지
			var li = document.createElement( "li" );
		    li.setAttribute('class','chat-left');
		    var divAvatar = document.createElement( "div" );		    
		    divAvatar.setAttribute('class','chat-avatar');
		    var divName = document.createElement( "div" );
		    divName.setAttribute('class','chat-name');
		    divName.innerHTML = aa.data.split('[',2)[1].split(']',2)[0];
		    var divChat = document.createElement( "div" );
		    divChat.setAttribute('class','chat-text');
		    divChat.innerHTML = aa.data.split(']',2)[1];
		    var divHour = document.createElement( "div" );
		    
		    li.appendChild(divName);
		    li.appendChild(divAvatar);
		    li.appendChild(divChat);
		    li.appendChild(divHour);
		    document.getElementById("chatBox").appendChild(li);
		    if(document.getElementById("autoScroll").checked){
		    	document.getElementById("chatContainer").scrollTop = 
		    		document.getElementById("chatContainer").scrollHeight;
		    }

		}
	}else{
		var li = document.createElement( "li" );
		li.setAttribute('class','person');
		var p = document.createElement( "p" );
		p.setAttribute('class','name-time');
		var span = document.createElement( "span" );
		span.setAttribute('class','time');
		span.innerHTML = aa.data;
		p.appendChild(span);
		li.appendChild(p);
		document.getElementById("notice").appendChild(li);
		if(document.getElementById("autoScroll").checked){
	    	document.getElementById("notice").scrollTop = 
	    		document.getElementById("notice").scrollHeight;
	    }
	}
    
};


function enterkey(){
	if(window.event.keyCode == 13){
		kajaChool();
	}
}

function kajaChool(){
	
										
	
	
		ws1.send("[<%=userNickName%>]"+chat1.value);
		chat1.value = ""; 
		chat1.focus(); 
	
	 
}
</script>

</body>
</html>