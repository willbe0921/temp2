<%@page import="sist.com.BbsDto"%>
<%@page import="sist.com.BbsDao"%>
<%@page import="sist.com.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

request.setCharacterEncoding("utf-8");
/* 한글 깨짐 방지 */
%>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbswriteAf.jsp</title>
<!-- 작성한 글을 dao를 불러서 db에 넣는 부분 
-->
</head>
<body>

<%
String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();

boolean isS = dao.writeBbs(new BbsDto(id, title, content));

if(isS){
%>

	<script type="text/javascript">
		alert("글 입력 성공");
		location.href = 'bbslist.jsp';
	</script>
	
	<%
} else{
%>
	<script type="text/javascript">
		alert("다시 입력 하시오");
		location.href = 'bbswrite.jsp';
	</script>
<%
}
%>
</body>
</html>


