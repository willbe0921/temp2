<%@page import="sist.com.MemberDao"%>
<%@page import="sist.com.BbsDto"%>
<%@page import="sist.com.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
.center{
   margin:auto;
   width: 60%;
   border: 3px solid #8Ac007;
   padding: 10px;
   
   
   /* internal 방식 */
}

input{
	size:50;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbsdetail.jsp</title>


<%-- <%

int id = (Integer.parseInt(request.getParameter("seq")));

/* int id1 = (Integer.parseInt(id)); */

System.out.println(id);

BbsDao dao = BbsDao.getInstance();

BbsDto dto = dao.getBbs(id);

%> --%>

<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"55291",secure:"55296"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>




<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-3" data-genuitec-path="/Jsp_BBS/WebContent/bbsdetail.jsp">
<a href='logout.jsp' data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-3" data-genuitec-path="/Jsp_BBS/WebContent/bbsdetail.jsp">로그아웃</a>
<h1>상세글 보기</h1>
<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

BbsDao dao = BbsDao.getInstance();
dao.readCount(seq); //조회수 증가

BbsDto dto = dao.getBbs(seq);


%>


<div class="center">
<table border="1">
<col width="200"/><col width="500"/>

<tr>
	<td>작성자</td>
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<td>제목</td>
	<td><%=dto.getTitle() %> </td>
</tr>
<tr>
	<td>작성일</td>
	<td><%=dto.getWdate() %> </td>
</tr>
<tr>
	<td>정보</td>
	<%-- <td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth()%> </td> --%>
	<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %> </td>
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
	<td>조회수</td>
	<td><%=dto.getReadcount() %></td>
</tr>

</table>


<form action="answer.jsp" method="post">
<input type="hidden" name='seq' value="<%=dto.getSeq() %>">
<input type="submit" value="답글">

</form>



</div>
<a href='bbslist.jsp'>이전 화면</a>

</body>
</html>





