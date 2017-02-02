<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.1.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
.center{
   margin:auto;
   width: 60%;
   border: 3px solid #8Ac007;
   padding: 10px;
}
</style>


</head>
<body>

<!-- 넘기기 전에 아이디나 이름이 올바른 지 판단해야 함. 자바가 아니라 자바스크립트로 작성 -->

<h1>회원등록</h1>
<p>환영합니다</p>

<div class = "center">
<form action="regiAf.jsp" method="post">

<table border="1">
<tr>
<td>아이디</td>
<td>
	<input type="text" name="id" size="20" id="id">
	<input type="button" id="btn" size="20" value="아이디확인">
</td>

</tr>

<tr>
<td>이름</td>
<td><input type="text" name="name" size="20"></td>
</tr>

<tr>
<td>패스워드</td>
<td><input type="text" name="pwd" size="20"></td>
</tr>

<tr>
<td>이메일</td>
<td><input type="text" name="email" size="20"></td>
</tr>

<tr>
<td colspan="2">
	<input type="submit" value="회원가입">
</td>
</tr>
</table>
</form>
</div>

<a href='index.jsp'>home</a>
<!-- ajax 서버와 클라이언트 공존
url 서버 success 클라이언트 -->

<script type="text/javascript">
$(function(){
	$("#btn").click(function(){
		$.ajax({
			type:"post",
			url:"idcheck.jsp",		//서버
			data:{
				"id":$('#id').val() //텍스트 필드 val. "idcheck.jsp" 에 id 값을 보낸다.
			},
			success:function(data){		//서버에서 클라이언트로 날라온 데이터
				/* alert("success");
				alert("data= " + data); */
				
				 if($.trim(data) == "YES"){
					alert($('#id').val() + '사용 가능 아이디입니다.');
				}else{
					alert($('#id').val() + '사용 불가 아이디입니다.');
				} 
				
			}
		});
		
	});	
});

</script>



</body>
</html>











