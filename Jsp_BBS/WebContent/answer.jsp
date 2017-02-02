<%@page import="sist.com.MemberDto"%>
<%@page import="sist.com.BbsDto"%>
<%@page import="sist.com.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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

</head>
<body>

<h1>부모글</h1>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

BbsDao dao = BbsDao.getInstance();

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
	<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %> </td>
</tr>


<tr>
	<td>내용</td>
	<%-- <td><input type="text" value=<%=dto.getContent() %>></td> --%>
	<td>
		<textarea rows="10" cols="50" name='content'>
			<%=dto.getContent() %>
		</textarea>
	</td>
</tr>
<tr>
	<td>조회수</td>
	<td><%=dto.getReadcount() %></td>
</tr>

</table>

<hr/>

<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
mem = (MemberDto)ologin;

%>

<h1>답글달기</h1>

<form action="answerAf.jsp" method="post">
<input type="hidden" name="seq" value='<%=dto.getSeq() %>'>

<table border="1">
<col width="200"/><col width="500"/>

<tr>
	<td>아이디</td>
	<td>
		<input type="text" name="id" size="50" value="<%=mem.getId() %>" readonly>
	</td>
</tr>
<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title" size="50">
	</td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols="50" name="content"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2">
		<input type="submit" value="답글">
	</td>
</tr>

</table>
</form>
</div>

<a href='bbslist.jsp'>글목록</a>
</body>
</html>












