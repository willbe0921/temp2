<%@page import="sist.com.MemberDto"%>
<%@page import="sist.com.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>regiAf</title>
</head>
<body>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String pwd = request.getParameter("pwd");
String email = request.getParameter("email");

MemberDao dao = MemberDao.getInstance();

boolean isS = dao.addMember(new MemberDto(id,name,pwd,email,0));
if(isS){
%>

	<script type="text/javascript">
		alert("성공적 가입");
		location.href ="index.jsp";
	</script>


<%
}else{
%>	
	

	<script type="text/javascript">
	alert("다시  기입");
	location.href ="regi.jsp";
	</script>

<%
}
%>




</body>
</html>