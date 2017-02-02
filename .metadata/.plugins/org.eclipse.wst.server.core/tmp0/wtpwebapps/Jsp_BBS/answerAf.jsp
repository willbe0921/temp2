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
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"55291",secure:"55296"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-2" data-genuitec-path="/Jsp_BBS/WebContent/answerAf.jsp">



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
	<script type="text/javascript" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-2" data-genuitec-path="/Jsp_BBS/WebContent/answerAf.jsp">
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