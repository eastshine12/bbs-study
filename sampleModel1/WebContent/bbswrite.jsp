<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  
<%
Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin;
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
<style type="text/css">

</style>
<title>Insert title here</title>
</head>
<body>

<!-- 글을 작성 -->
<br>
<h2 align="center">글 작성</h2>
<br>
<form action="bbswriteAf.jsp" method="post">
<div align="center">
	<table class="table table-bordered" border ="1" >
		<tr>
			<th>아이디</th>
			<td style="padding-left: 10px"><%=mem.getId() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
			<input type="text" size="50" name="title">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
			<textarea rows="20" cols="100" name="content"></textarea>
			</td>
		</tr>
	
	</table>
	<br><br>
<input type="submit" class="btn btn-primary" value="글추가">
<input type="button" class="btn btn-secondary" value="뒤로" onclick="backPage()">
</div>
</form>

<script type="text/javascript">

function backPage() {
	
	location.href = "bbslist.jsp";
	
}




</script>

<!-- bbswriteAf.jsp -->



</body>
</html>