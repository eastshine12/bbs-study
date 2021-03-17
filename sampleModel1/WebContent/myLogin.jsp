<%@page import="com.sun.xml.internal.bind.v2.runtime.Location"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
System.out.println(id);
System.out.println(pwd);

MemberDao dao = MemberDao.getInstance();
MemberDto dto = new MemberDto(id, pwd, null, null, 0);
// 세션에 로그인 값을 남기기 위해 dto 생성한 후

boolean b = dao.myLogin(id, pwd);

session.setAttribute("login", dto);	// 로그인 속성을 부여
// session.setMaxInactiveInterval(30 * 60 * 60);


/* 
MemberDao dao = MemberDao.getInstance();
boolean b = dao.myLogin(id, pwd); */
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>

<%
if(b) { // 로그인 통과
%>


	<script type="text/javascript">

	location.href = "bbslist.jsp";
	</script>
	
	<%
}else{ // 로그인 실패
	%>
	<script type="text/javascript">
	alert("아이디, 패스워드를 확인해 주세요.");
	location.href = "login2.jsp";
	</script>
<%
}
%>
</body>
</html>
