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

<title>랜덤 채팅 사이트</title>
</head>
<body>
<%

String userNickName = request.getParameter("userNickName");
String userID = request.getParameter("userID");

// String userNickName = null;
// if(session.getAttribute("userNickName") != null){
// 	userNickName = (String)session.getAttribute("userNickName");
// }

// 	String userID = null;
// if(session.getAttribute("userID") != null){
// 	userID = (String) session.getAttribute("userID");
// }
%>
<form name='info' method='post' action="url">
<input type='hidden' name='userNickName' value='<%=userNickName%>'>
<input type='hidden' name='userID' value='<%=userID%>'>
</form>
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
				<li class="active">
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
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1 align="center">랜덤채팅</h1>
			</div>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>