<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ page import="bbs.BbsDAO" %>
 <%@ page import="java.io.PrintWriter" %>
 <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
 <jsp:setProperty name="bbs" property="bbsTitle" />
 <jsp:setProperty name="bbs" property="bbsContent" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String userNickName = request.getParameter("userNickName");
String userID = request.getParameter("userID");

// String userNickName = null;
// if(session.getAttribute("userNickName") != null){
// 	userNickName = (String)session.getAttribute("userNickName");
// }
// String userID = null;
// if(session.getAttribute("userID") != null){
// 	userID = (String)session.getAttribute("userID");
// }
if(userID ==null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");
	
} else {
	
		if(bbs.getBbsTitle() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안되었습니다')");
			script.println("history.back()");
			script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, userNickName, bbs.getBbsContent());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
				
	}
	
}
}


	
%>
	<form name='info' action='bbs.jsp' method='post'>
	<input type='hidden' name='userNickName' value='<%=userNickName%>'>
	<input type='hidden' name='userID' value='<%=userID%>'>
	</form>
	<script>
	document.info.submit();
	</script>
</body>
</html>