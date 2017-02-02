<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sist.com.MemberDao"%>
<%@page import="sist.com.MemberDto"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>

</head>
<body>
<!-- dkdkkdkdk -->
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDao dao = MemberDao.getInstance();

MemberDto mem = dao.login(new MemberDto(id, null, pwd, null, 0));

/* MemberDto mem = dao.login(new MemberDto(id,null,pwd,null,0)); */

if(mem != null && !mem.getId().equals("")){
	session.setAttribute("login", mem);
	session.setMaxInactiveInterval(30*60);

%>
	<script type="text/javascript">
		alert("안녕하세요<%=mem.getId() %>!");
		location.href = 'bbslist.jsp';
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("아이디나 패스워드를 확인 하십시오")
		location.href = 'index.jsp';
	</script>
<%
}
%>


</body>
</html>