<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.io.PrintWriter"
  %>
 <jsp:useBean id="user" class="user.User" scope="page" />
  <jsp:setProperty name="user" property="userID" />
 <jsp:setProperty name="user" property="userPassword" />
 <jsp:setProperty name="user" property="userName" />
 <jsp:setProperty name="user" property="userGender" />
 <jsp:setProperty name="user" property="userEmail" />
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/mycss.css">
<title>랜덤채팅</title>
</head>
<body>

	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main">랜덤채팅</a>
		</div>
		<div class ="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>				
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>	
			</ul>
		</div>
	</nav>
	
 <% 
 String userName = (String)session.getAttribute("userName");

 String userEmail = (String)session.getAttribute("userEmail");
 UserDAO userDAO = new UserDAO();
 String userID = userDAO.findread(userName, userEmail);
 
 
%>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
			
				<form method="post" action="login.jsp">
				
					<h2 style="text-align: center;">아이디 찾기</h2>
					<h5 style="text-align: center;">회원가입 아이디는 '<%=userID %>' 입니다</h5>
					<input type="submit" class="btn btn-primary form-control" value="로그인 화면으로 돌아가기">
				</form>	
				</div>
			</div>
        </div>
      
       
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>