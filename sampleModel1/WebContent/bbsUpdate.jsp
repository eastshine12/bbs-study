<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("utf-8");



Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin;

int seq = Integer.parseInt(request.getParameter("seq"));
System.out.println("글번호 : " +seq);

BbsDao dao = BbsDao.getInstance();

List<BbsDto> list = dao.getDetail(seq);

BbsDto bbs = list.get(0);

%>

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
<body>

<h1>글 작성</h1>

<form action="bbsUpdateAf.jsp?seq=<%=bbs.getSeq() %>" method="post">
<div align="center">
	<table class="table" border ="1" >
		<tr>
			<th>아이디</th>
			<td style="padding-left: 10px"><%=bbs.getId() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
			<input type="text" size="50" name="title"
			value="<%=bbs.getTitle() %>" >
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
			<textarea rows="20" cols="100" name="content">
			<%=bbs.getContent() %>
			</textarea>
			</td>
		</tr>
	
	</table>
	<br><br>
<input type="submit" class="btn btn-primary" value="글수정">
<input type="button" value="취소" class="btn btn-secondary" onclick="backPage()">
</div>
</form>

<script type="text/javascript">

function backPage() {
	location.href = "bbsdetail.jsp?seq=<%=seq %>";
}


</script>

</body>
</html>