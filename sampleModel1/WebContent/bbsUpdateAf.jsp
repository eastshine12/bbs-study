<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin; //로그인한 사람의 정보

int seq = Integer.parseInt(request.getParameter("seq"));
System.out.println("글번호 : " +seq);

%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%




String id = mem.getId();	//로그인한 사람 id
System.out.println("수정하는 사람 ID : " +mem.getId());
String title = request.getParameter("title");	//수정된 제목
System.out.println("수정된 제목 : " +title);
String content = request.getParameter("content"); //수정된 내용
System.out.println("수정된 내용 : " +content);


BbsDao dao = BbsDao.getInstance();

BbsDto dto = new BbsDto(id, title, content);

boolean addS = dao.bbsUpdate(dto, seq);

System.out.println("수정되냐 참/거짓 : " +addS);

if(addS) {
%>
	
	<script type="text/javascript">
	alert("성공적으로 수정되었습니다.");
	location.href = "bbslist.jsp";
	</script>


<% } else { %>	

	<script type="text/javascript">
	alert("글 수정에 실패했습니다.");
	location.href = "bbsUpdate.jsp?seq=<%=seq %>";
	</script>

<% } %>


</body>
</html>
