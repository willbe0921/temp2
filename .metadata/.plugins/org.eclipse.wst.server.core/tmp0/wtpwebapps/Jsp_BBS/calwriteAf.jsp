<!--calwriteAf.jsp --> 
<%@page import="sist.com.CalDto"%>
<%@page import="sist.com.CalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
request.setCharacterEncoding("utf-8");
%>   

<%!

public String two(String msg){	//한자리를 두자리로 만들어 주는 함수
	return msg.trim().length()<2?"0"+msg:msg.trim();
}
%>

<%
String id= request.getParameter("id");
String title= request.getParameter("title");
String content= request.getParameter("content");

String year=request.getParameter("year");
String month=request.getParameter("month");
String day=request.getParameter("day");
String hour=request.getParameter("hour");
String min=request.getParameter("min");




%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calwriteAf</title>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"55291",secure:"55296"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-11" data-genuitec-path="/Jsp_BBS/WebContent/calwriteAf.jsp">
<%
String wdate = year+two(month)+two(day)+two(hour)+two(min);

CalDao dao = CalDao.getInstance();

boolean isS = dao.addCalendar(new CalDto(id, title, content, wdate));

String url = String.format("%s?year=%s&month=%s", "calendar.jsp", year, month);

%>


<%
if(isS){
%>

	<script type="text/javascript" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-11" data-genuitec-path="/Jsp_BBS/WebContent/calwriteAf.jsp">
	alert("입력 성공");
	location.href = "<%=url %>";
	</script>
<%
}else{
%>	
	<script type="text/javascript">
	alert("입력 실패");
	location.href = "<%=url %>";
	</script>

<%
}
%>





</body>
</html>




