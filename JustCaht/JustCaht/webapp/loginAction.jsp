<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 
 <jsp:useBean id="user" class="user.User" scope="page" />
 <jsp:setProperty name="user" property="userID" />
 <jsp:setProperty name="user" property="userPassword" />
 <jsp:setProperty name="user" property="userNickName" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userNickName = null;
	String userID = null;
%>

<%

	
// 	if(session.getAttribute("userNickName") != null){
// 	userNickName = (String)session.getAttribute("userNickName");
// 	}

// 	if(session.getAttribute("userID") != null){
// 		userID = (String)session.getAttribute("userID");
// 	}
// 	if(userID !=null){
// 		PrintWriter script = response.getWriter();
// 		script.println("<script>");
// 		script.println("alert('이미 로그인이 되어있습니다.')");
// 		script.println("location.href='main.jsp'");
// 		script.println("</script>");
// 	}
		

	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	if(result ==1){
// 		session.setAttribute("userID", user.getUserID());
// 		session.setAttribute("userNickName", user.getUserNickName());
		
		userNickName = userDAO.nickName(user.getUserID());
		userID = user.getUserID();
		PrintWriter script = response.getWriter();

	}
	else if(result ==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result ==-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result ==-2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
%>
	<form name='info' action='main.jsp' method='post'>
	<input type='hidden' name='userNickName' value='<%=userNickName%>'>
	<input type='hidden' name='userID' value='<%=userID%>'>
	</form>
	<script>
	document.info.submit();
	</script>

</body>
</html>