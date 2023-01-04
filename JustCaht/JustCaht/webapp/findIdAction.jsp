<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
 
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="user" class="user.User" scope="page" />

 <jsp:setProperty name="user" property="userName" />
 <jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
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
	
	
}else{
	

UserDAO userDAO = new UserDAO();




int result = userDAO.findID(user.getUserName(), user.getUserEmail());
if(result ==1){
	
	 session.setAttribute("userName", user.getUserName());
	 session.setAttribute("userEmail", user.getUserEmail());
	 session.setAttribute("userID",user.getUserID());
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'find.jsp'");
	script.println("</script>");

	
}
else if(result ==0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이메일이 일치하지 않습니다.')");
	script.println("history.back()");
	script.println("</script>");
	
}
else if(result ==-1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('존재하지않는 이름입니다.')");
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

}
%>


 
 




</body>
</html>