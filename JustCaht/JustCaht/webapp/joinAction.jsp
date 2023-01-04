<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
 
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="user" class="user.User" scope="page" />
 <jsp:setProperty name="user" property="userID" />
 <jsp:setProperty name="user" property="userPassword" />
 <jsp:setProperty name="user" property="userName" />
 <jsp:setProperty name="user" property="userGender" />
 <jsp:setProperty name="user" property="userEmail" />
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
if(session.getAttribute("userNickName") != null){
	userNickName = (String)session.getAttribute("userNickName");
}
	
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
if(userID !=null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인이 되어있습니다.')");
	script.println("location.href='main.jsp'");
	script.println("</script>");
}

/* 	if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
	user.getUserGender()==null || user.getUserEmail()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안됨.')");
		script.println("history.back()");
		script.println("</script>");

	} else { */
		
		if( user.getUserName() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이름을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			
			

		} else  if(user.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이메일을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			
	
			
		}else if(user.getUserPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			
		}else if(user.getUserNickName() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('닉네임을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			
			
			
		}else if(user.getUserGender()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('성별을 선택해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			
			
	
			
		}else if(user.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이메일을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");

			
			
		}else{
		
		
		
		
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(user);
	
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디또는 닉네임이 존재합니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else {
		session.setAttribute("userID", user.getUserID());
		session.setAttribute("userNickName", user.getUserNickName());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'login.jsp'");
	
		script.println("</script>");
	}
	}
%>

</body>
</html>