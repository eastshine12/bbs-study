<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">

 <link rel="stylesheet" href="./bootstrap/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 
 <style type="text/css">
body {
	padding-top: 40px;
	padding-bottom: 40px;
	background-color: #f5f5f5;
}
	  
.form-signin {
	max-width: 420px;
	padding: 19px 29px 29px;
	margin: 0 auto 20px;
	background-color: #fff;
	border: 1px solid #e5e5e5;
	-webkit-border-radius: 5px;
	   -moz-border-radius: 5px;
	        border-radius: 5px;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	   -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	        box-shadow: 0 1px 2px rgba(0,0,0,.05);
}  

.form-signin h3{
	font-size: 20px;
	color: #5a5a5a;
	font: bold;
	text-align: center;
	padding-bottom: 5px;


}
	  
	  
.form-signin input {
	margin: 0 auto 15px;
	font-size: 18px;
	height: auto;
	padding: 7px 9px;
	width: 350px;
	
}

.form-signin button{
	height: 45px;
	width: 350px;


}

#facebooklogo{
	margin-bottom: 5px;
	margin-right: 5px;
}

#facebook{
	margin : 0 auto;
	height: 45px;
	width: 350px;
	padding : 10px;
	font-size: 17px;
}

#line {
	margin : 20px;
	color: #8E8E8E;
	font-weight: bold;
	font-size: 14.5px;
}
 
 </style>
</head>
<body>


<div class="container">
	<form class="form-signin" action="regiAf.jsp" method="post">
		<h3>친구들의 사진과 동영상을 보려면</h3>
		<h3>가입하세요.</h3>
		<div id="facebook" class="btn btn-large btn-primary">
				<a href="https://www.facebook.com/login.php?skip_api_login=1&api_key=124024574287414&kid_directed_site=0&app_id=124024574287414&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fdialog%2Foauth%3Fclient_id%3D124024574287414%26redirect_uri%3Dhttps%253A%252F%252Fwww.instagram.com%252Faccounts%252Fsignup%252F%26state%3D%257B%2522fbLoginKey%2522%253A%25221rppujpblhntf1n75ujj1crwisd1gx2o121mjaggu1tv66zwbp77gw%2522%252C%2522fbLoginReturnURL%2522%253A%2522%252F%2522%257D%26scope%3Demail%26response_type%3Dcode%252Cgranted_scopes%26locale%3Dko_KR%26ret%3Dlogin%26fbapp_pres%3D0%26logger_id%3D4678afa1-db25-4e38-acee-958d138e660c%26tp%3Dunspecified&cancel_url=https%3A%2F%2Fwww.instagram.com%2Faccounts%2Fsignup%2F%3Ferror%3Daccess_denied%26error_code%3D200%26error_description%3DPermissions%2Berror%26error_reason%3Duser_denied%26state%3D%257B%2522fbLoginKey%2522%253A%25221rppujpblhntf1n75ujj1crwisd1gx2o121mjaggu1tv66zwbp77gw%2522%252C%2522fbLoginReturnURL%2522%253A%2522%252F%2522%257D%23_%3D_&display=page&locale=ko_KR&pl_dbl=0">
				<img id="facebooklogo"alt="" src="facebooklogo.png" width="22" height="22"> 
				</a>Facebook으로 로그인
		</div>
		<div id="line">
				―――――――― &emsp;또는&emsp; ――――――――
		</div>
		<input type="text" class="input-block-level" name="email" placeholder="휴대폰 번호 또는 이메일 주소">
		<input type="text" class="input-block-level" name="name" placeholder="성명">
		<input type="text" class="input-block-level" name="id" id="_id" placeholder="사용자 이름">
		<input type="password" class="input-block-level" name="pwd" id="_pwd" placeholder="비밀번호">
		<br>
		<button class="btn btn-large btn-primary" id="btn" type="submit">가입</button>
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
					$('#idcheck').text("Id 사용가능.");
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