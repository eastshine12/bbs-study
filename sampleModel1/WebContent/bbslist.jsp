<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>


<!-- MODEL 1 -->


    
<%
request.setCharacterEncoding("utf-8");
Object ologin = session.getAttribute("login");	//로그인 되어있는 유저 dto
MemberDto mem = null;
if(ologin == null) { 	//로그인이 안되어있으면
	%>
	<script>
	
	alert("로그인 해 주십시오");
	location.href = "login2.jsp";	// 로그인 페이지로 이동
	
	</script>
	
<%	
}
mem = (MemberDto)ologin;	//로그인이 되면 MemberDto에 유저dto 담기
%>
 
<%!
// 댓글의 depth와 image를 추가하는 함수
// depth = 1	' '->
// death = 2	'  '->	//띄어쓰기 칸수 늘려서 깊이 표현

public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' heiht='20px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	// 여백
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0 ? "":ts + rs;	
}


 %>
 
 <%

 String selectBBS = request.getParameter("selectBBS");
 String searchText = request.getParameter("searchText");
 System.out.println("검색할 대상 : " + selectBBS);
 System.out.println("검색내용 : " + searchText);
 
 BbsDao dao = BbsDao.getInstance();
 List<BbsDto> list = null;
 
 if( searchText != null ) {
	list = dao.getBbsListSelect(selectBBS, searchText);
 }
 else {
	list = dao.getBbsList();
 }
 
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
<title>bbslist(Bulletin Board System) = 전자게시판</title>
<style type="text/css">

#menu { 
	float:right; 
	list-style-type:none; 
	margin:0 0 1em; 
	padding:8px 0 0 10px; 
	white-space:nowrap; 
	width:100%; 
}


</style>

</head>


<body>

<nav id="menu" class="navbar navbar-expand-sm bg-dark navbar-dark">
  <ul class="navbar-nav ml-auto">
    <li class="nav-item active">
     <p style="color: white; font-size: 20px;">환영합니다!&emsp;<%=mem.getId() %> 님 &emsp;</p>
    </li>
    <li class="nav-item">
      <input type="button" class="btn btn-secondary" onclick="logout()" value="로그아웃">&emsp;&emsp;
    </li>
    <li class="nav-item">
    	<p> </p>
    </li>

  </ul>
</nav>

<br>
<h2 class="display-4" align="center">게시판</h2>
<br>

<div class="container" align="center">

<table class="table table-bordered table-sm" border="1">
<col width="70"><col width="500"><col width="150">
<thead class="thead-dark">
<tr>
	<th scope="col">번호</th>
	<th scope="col">제목</th>
	<th scope="col">작성자</th>
</tr>
</thead>
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	
	for(int i = 0;i < list.size(); i++){
		BbsDto bbs = list.get(i);
		%>
		<tr>
			<th><%=i + 1 %></th>
			<td>
				<%=arrow(bbs.getDepth()) %>		<!-- 여백 + 이미지 -->
				<a class="text-dark" href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
					<%=bbs.getTitle() %>
				</a>
				<span class="badge badge-danger">new</span>
			</td>
			<td><%=bbs.getId() %></td>
		</tr>
		<%
	}
}
 %>


</table>


<ul class="pagination"  >
  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
  <li class="page-item"><a class="page-link" href="#">1</a></li>
  <li class="page-item"><a class="page-link" href="#">2</a></li>
  <li class="page-item"><a class="page-link" href="#">3</a></li>
  <li class="page-item"><a class="page-link" href="#">Next</a></li>
</ul>
<br>


<form action="bbslist.jsp" method="get">

<select name="selectBBS" id="selectBBS" class="custom-select" style="width: 100px">
	<option value="TITLE">제목</option>
	<option value="CONTENT">내용</option>
	<option value="ID">작성자</option>
</select>



<input type="search" name="searchText" id="searchText">


<input type="submit" value="검색" class="btn btn-primary" id="searchBtn">

</form>

<br><br>
<input type="button" class="btn btn-secondary" value="글쓰기" onclick="goWrite()">
<input type="button" class="btn btn-secondary" value="전체목록" onclick="goMain()">

</div>






<script type="text/javascript">

function logout() {
	location.href = "logout.jsp";
};

function goWrite() {
	location.href = "bbswrite.jsp";
};

function goMain() {
	location.href = "bbslist.jsp";
};



</script>



</body>
</html>