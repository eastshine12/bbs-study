<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<!-- MODEL 1 -->


<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style type="text/css">

.center{
	margin: auto;
	width: 60%;
	border: 3px solid #0000ff;
	padding: 10px;
}

.login-form {
    width: 340px;
    margin: 50px auto;
  	font-size: 15px;
}
.login-form form {
    margin-bottom: 15px;
    background: #f7f7f7;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    padding: 30px;
}
.login-form h2 {
    margin: 0 0 15px;
}
.form-control, .btn {
    min-height: 38px;
    border-radius: 2px;
}
.btn {        
    font-size: 15px;
    font-weight: bold;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
</head>
<body>


<h2>Login Page</h2>

<div class="login-form">
    <form action="myLogin.jsp" method="post">
        <h2 class="text-center">Login</h2>       
        <div class="form-group">
            <input type="text" id="_id" name="id" class="form-control" placeholder="Username" required="required" onkeydown="enterLogin()">
        </div>
        <div class="form-group">
            <input type="password" id="_pwd" name="pwd" class="form-control" placeholder="Password" required="required" onkeydown="enterLogin()">
        </div>
        <div class="form-group">
            <button type="submit" id="btn" class="btn btn-primary btn-block">Login</button>
        </div>
        <div class="clearfix">
            <label class="float-left form-check-label"><input type="checkbox" id="chk_save_id"> Remember me</label>
            <a href="#" class="float-right">Forgot Password?</a>
        </div>        
    </form>
    <p class="text-center"><a href="regi.jsp">Create an Account</a></p>
</div>


<!-- 
<div class="center">
	<form action="myLogin.jsp" method="post">
	<table class="table" border="1">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" id="_id" name="id" size="20" onkeydown="enterLogin()"><br>
				<input type="checkbox" id="chk_save_id">save id
			</td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td>
				<input type="password" id="_pwd" name="pwd" size="20" onkeydown="enterLogin()">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" id="btn" value="로그인">
				<button type="button" onclick="account()">회원가입</button>
			</td>
		</tr>
	</table>
	</form>
</div>

 -->


<script type="text/javascript">

function enterLogin() {
	if(window.event.keyCode == 13) {
		$('button').click();
	}
}


function account() {
	location.href = "regi.jsp";
}

/*
 	session : Java. 서버에 저장. 자료형 : Object
 	
 	cookie	: JavaScript. 클라이언트에서 사용. 자료형 : String
 
 */

let user_id = $.cookie("user_id");
 
if(user_id != null) {	//저장된 아이디가 있다면
	 //alert("쿠키 있음");
 	$('#_id').val(user_id);	// id 텍스트 필드에 id를 넣어주고
 	$('#chk_save_id').attr("checked", "checked"); // 체크박스에 체크표시 해준다.
 
}

  
$('#chk_save_id').click(function() {
 	
	if($("#chk_save_id").is(":checked")) {	//체크가 되어있을 때,
		//alert("체크됨");
	 	if($('#_id').val().trim() == "") {	//trim 공백제거
	 		alert("아이디를 입력해 주십시오");
	 		$('#chk_save_id').prop('checked', false); //체크한거 풀어버린다.
		}
		else {	
		 	//쿠키를 저장
		 	$.cookie("user_id", $('#_id').val().trim(), {expires:7, path:'./'}); //expires : 만료일 (7일동안 해당 쿠키를 유지) 
		 																		//path : 경로 설정 (모든 페이지 해당이면 /만 둔다.)
		}
	}
 	else { //체크가 안되어있을 때,
	 $.removeCookie("user_id", {path:'./'});
 	}
 });

  

</script>


</body>
</html>