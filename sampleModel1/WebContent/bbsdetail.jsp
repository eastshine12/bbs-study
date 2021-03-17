<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
Object ologin = session.getAttribute("login");
MemberDto mem = (MemberDto)ologin;

int seq = Integer.parseInt(request.getParameter("seq"));
System.out.println("글번호 : " +seq);

BbsDao dao = BbsDao.getInstance();

List<BbsDto> list = dao.getDetail(seq);
dao.readcount(seq);

BbsDto bbs = list.get(0);

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
<body>

<!-- 
	작성된 글 내용 보여주는 페이지
	시퀀스 번호 받아서
	ID, 작성일, 제목, 조회수(0), (정보), 내용
	제목 내용만 text, textarea
	
	글삭제, 글목록, 글수정 버튼

 -->


<br>
<h2 align="center">글 내용</h2>
<br>

<div align="center">
	<table class="table table-bordered" border ="1" >
		<col width="100px"><col width="500px">
		<tr>
			<th>ID</th>
			<td style="padding-left: 10px"><%=bbs.getId() %></td>
		</tr>
		<tr>
			<th>작성날짜</th>
			<td style="padding-left: 10px"><%=bbs.getWdate() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td style="padding-left: 10px"><%=bbs.getTitle() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td style="padding-left: 10px"><%=bbs.getReadcount() %></td>
		</tr>
		<tr>
			<th>정보</th>
			<td style="padding-left: 10px"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
			<textarea rows="20" cols="100" name="content" readonly><%=bbs.getContent() %></textarea>
			</td>
		</tr>
	
	</table>
	<br><br>
<%if (mem.getId().equals(list.get(0).getId())) { %>	
	<input type="button" class="btn btn-secondary" value="글삭제" onclick="deletePage()">
	<input type="button" class="btn btn-secondary" value="글수정" onclick="updatePage()">
	<input type="button" class="btn btn-secondary" value="글목록" onclick="goList()">
<% } else { %>
	<input type="button" class="btn btn-secondary" value="글목록" onclick="goList()">
<% } %>
	
</div>

<button type="button" onclick="answerbbs('<%=bbs.getSeq() %>')">답글</button>




<script type="text/javascript">

function deletePage() {
	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
		 location.href = "bbsDeleteAf.jsp?seq=<%=bbs.getSeq() %>";
	 }else{   //취소
	     return false;
	 }
	
}
function updatePage() {
	location.href = "bbsUpdate.jsp?seq=<%=bbs.getSeq() %>";
}
function goList() {
	location.href = "bbslist.jsp";
}

function answerbbs(seq) {
	location.href = "answer.jsp?seq=" + seq;
}




</script>



</body>
</html>