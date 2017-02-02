<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Login</title>
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

<h1>Login Project</h1>
<p>환영합니다</p>
<div class="center">
<form action="login.jsp"method="post">
<table border="1">
<tr>
<td>아이디</td>
<td><input type="text" name="id"size="20"></td>
</tr>

<tr>
<td>패스워드</td>
<td><input type="text"name="pwd"size="20"/></td>
</tr>

<tr>
<td colspan="2">
   <input type="submit"value="로그인"/>
   </td>
</tr>






</table>


</form>

<a href='regi.jsp'>회원가입</a>



</div>

</body>
</html>