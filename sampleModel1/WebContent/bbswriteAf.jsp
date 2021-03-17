<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
request.setCharacterEncoding("utf-8");
Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin;
%>



<%


String id = mem.getId();
String title = request.getParameter("title");
String content = request.getParameter("content");


BbsDao dao = BbsDao.getInstance();
BbsDto dto = new BbsDto(id, title, content);


boolean addS = dao.addBbs(dto);

if(addS) {
%>
	
	<script type="text/javascript">
	alert("성공적으로 작성되었습니다.");
	location.href = "bbslist.jsp";
	</script>


<% } else { %>	

	<script type="text/javascript">
	alert("글 작성에 실패했습니다.");
	location.href = "bbswrite.jsp";
	</script>

<% } %>
%>


</body>
</html>