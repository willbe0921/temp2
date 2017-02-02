<!--caldetail.jsp  -->
<%@page import="sist.com.CalDto"%>
<%@page import="sist.com.CalDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%

String sseq = request.getParameter("seq");
//웹서버는 항상 문자열로 넘어간다.
int seq = Integer.parseInt(sseq.trim());

System.out.println("seq: " + seq);

CalDao dao = CalDao.getInstance();

CalDto dto = dao.getdetail(seq);

System.out.println("dto.getId(): " + dto.getId());
System.out.println("dto.toString(): " + dto.toString());


%>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>caldetail</title>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"55291",secure:"55296"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-7" data-genuitec-path="/Jsp_BBS/WebContent/caldetail.jsp">

<div align="center" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-7" data-genuitec-path="/Jsp_BBS/WebContent/caldetail.jsp">
<table border="1">
<col width="200"/><col width="500"/>

<tr>
	<td>번호</td>
	<td><%=dto.getSeq() %></td>
</tr>
<tr>
	<td>아이디</td>
	<td><%=dto.getId() %> </td>
</tr>
<tr>
	<td>제목</td>
	<td><%=dto.getTitle() %> </td>
</tr>

<tr>
<td>내용</td>
<td>
<textarea rows="10" cols="50" 
name='content'><%=dto.getContent() %>
</textarea>
</td>
</tr>

<tr>
	<td>rdate</td>
	<td><%=dto.getRdate() %></td>
</tr>

<tr>
	<td>wdate</td>
	<td><%=dto.getWdate() %></td>
</tr>

<tr>
	<td colspan="2">
		<input type="button" onclick="modifydate('<%=dto.getSeq() %>')" value="수정">
	</td>

</tr>

<tr>
<td colspan="2">
   <input type="button" value="삭제" onclick="delete('<%=dto.getSeq()%>')" >
</tr>

</table>
</div>


<script type="text/javascript">
function modifydate(seq){
	location.href = 'calupdate.jsp?seq=' + seq;
}
function delete(seq){
	<%
	%>
}
</script>
</body>
</html>





