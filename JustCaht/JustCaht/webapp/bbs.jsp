<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.io.PrintWriter" %>
  <%@ page import="bbs.BbsDAO" %>
  <%@ page import="bbs.Bbs" %>
  <%@ page import="java.util.ArrayList" %>
  <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>랜덤채팅</title>
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

int pageNumber = 1;
if(request.getParameter("pageNumber")!= null){
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}


%>
<form name='info' method='post'>
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
				<li >
					<a href="main.jsp?userNickName=<%=userNickName%>&userID=<%=userID%>"
					>메인
					</a>
				</li>
				<li class="active">
					<a href="bbs.jsp?userNickName=<%=userNickName%>&userID=<%=userID%>"
					>대기방
					</a>
				</li>				
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
	
	
	<div class ="container">
		<div class="row">
			<table class ="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align: center;">입장하기</th>
						<th style="background-color:#eeeeee; text-align: center;">방 이름</th>
						<th style="background-color:#eeeeee; text-align: center;">참여인원</th>
						<th style="background-color:#eeeeee; text-align: center;">방 생성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i = 0; i<list.size(); i++){
				%>
				
						
					<tr>
						<td>
							<form method='post' action='roomChat.jsp'>
								<input type='hidden' name='userNickName' value='<%=userNickName%>'>
								<input type='hidden' name='userID' value='<%=userID%>'>
								<input type='hidden' name='roomTitle' value='<%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replace("<","&lt;").replace(">","&gt;").replaceAll("\n", "<br>;")  %>'>
								<input type='hidden' name='memberNumber' value='<%=list.get(i).getBbsContent()%>'>
								<button name='roomID' value='<%=list.get(i).getBbsID()%>'>입장</button>
							</form>
						</td>
						<td><%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replace("<","&lt;").replace(">","&gt;").replaceAll("\n", "<br>;")  %></td>
						<td><%= list.get(i).getBbsContent() %></td>
					<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
						
					</tr>
				<% 		
					}
				%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
					
				
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arraw-left">이전</a>
			
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)){
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
			<% 	
				}
			%>
			
			<a class="btn btn-primary pull-right" href="write.jsp?userNickName=<%=userNickName%>&userID=<%=userID%>"
				>방 생성
			</a>
		</div>
	
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>