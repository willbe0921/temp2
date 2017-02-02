<%@page import="sist.com.BbsDto"%>
<%@page import="sist.com.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

request.setCharacterEncoding("utf-8");
/* 한글 깨짐 방지 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>answerAf.jsp</title>
</head>
<body>



<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();
boolean isS = dao.answer(seq, new BbsDto(id, title, content));
if(isS){

%>
	<script type="text/javascript">
	alert("답글 입력 성공");
	location.href="bbslist.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("답글 입력 실패");
	location.href="bbslist.jsp";
	</script>

<%
}
%>






</body>

</html>