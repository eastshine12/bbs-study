<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	padding: 10px;
}

</style>
</head>
<body>

<h2>회원가입</h2>
<p>환영합니다. 홍길동 홈페이지 입니다.</p>

<div class="center">
<form action="regiAf.jsp" method="post">
<table class="table table-bordered" border="1">
	<tr>
		<td>아이디</td>
		<td>
			<input type="text" name="id" id="_id" size="20">
			<p id="idcheck" style="font-size : 12px"></p>
			<button type="button" class="btn btn-secondary" id="btn">중복확인</button>
			<!-- id 확인 (Ajax로) p, button -->
			
		</td>
	</tr>
	<tr>
		<td>패스워드</td>
		<td>
			<input type="text" name="pwd" id="_pwd" size="20">
		</td>
	</tr>
	<tr>
		<td>이름</td>
		<td>
			<input type="text" name="name" size="20">
		</td>
	</tr>
	<tr>
		<td>이메일</td>
		<td>
		<input type="text" name="email" size="20">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" class="btn btn-primary" value="회원가입">
		</td>
	</tr>

</table>
</form>
</div>


<script type="text/javascript">


$(function () {
	$('#btn').click(function() {
		
		$.ajax({
			url:"idcheck.jsp",
			type:"post",
			data:{
					"id":$('#_id').val()
				},
			
			success:function(data){
				if(data.trim() == "YES") {
					$('#idcheck').css("color", "#0000ff");
					$('#idcheck').text("사용가능 합니다.");
				}
				else {
					$('#idcheck').css("color", "#ff0000");
					$('#idcheck').text("존재하는 ID가 있습니다.");
					$('#_id').val("");
				}
				
			},
			error:function(){
				alert("error");
			},
			complete:function(){
			}
			
		});
		
	});
	
});


</script>






</body>
</html>