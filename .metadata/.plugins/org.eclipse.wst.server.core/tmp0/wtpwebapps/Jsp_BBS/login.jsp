<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="sist.com.MemberDao"%>
<%@page import="sist.com.MemberDto"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>

<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"55291",secure:"55296"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-14" data-genuitec-path="/Jsp_BBS/WebContent/login.jsp">
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
	<script type="text/javascript" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-14" data-genuitec-path="/Jsp_BBS/WebContent/login.jsp">
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