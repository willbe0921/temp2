<%@page import="sist.com.PdsDto"%>
<%@page import="java.util.List"%>
<%@page import="sist.com.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
PdsDao dao = PdsDao.getInstance();

List<PdsDto> list = dao.getPdss();

%>   
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdslist</title>
</head>
<body>

<table border="1">
<col width="50"/><col width="100"/><col width="400"/>
<col width="50"/><col width="50"/><col width="50"/><col width="100"/>

<tr bgcolor="#09bbaa" align="center">
	<td>번호</td><td>작성자</td><td>제목</td><td>다운로드</td><td>조회수</td><td>다운수</td><td>작성일</td>	
</tr>

<%


	for(int i = 0; i< list.size(); i++){
		String bgcolor = "";
		PdsDto dto = list.get(i);
		if(i%2 == 0){
			bgcolor = "#ddeebb";
		} else{
			bgcolor = "#ddddcc";
		}

%>

<tr bgcolor="<%=bgcolor%>" align="center" height="5">
	<td><%=i+1 %></td>
	<td><%=dto.getId() %></td>
	<td align="left">
		<a href='pdsdetail.jsp?pdsid=<%=dto.getId() %>'>
			<%=dto.getTitle() %>
		</a>
	</td>
	
	<td>
		<input type="button" name="btnDown" value="파일" 
		onclick="javascript:document.location.href='../filedown?filename=<%=dto.getFilename()%>&pdsid=<%=dto.getSeq()%>'">
		<!-- 자바스크립트에서 함수 생성 안 하고 직접적으로 만듬/  ..밖으로 빠져나감 위로/ 클래스명. 서블릿으로 날아감/ filedown web.xml에 작성  / javascript:document.location.href 다운로드 창이 열림 -->
	</td>
	
	<td><%=dto.getReadcount() %></td>
	<td><%=dto.getDowncount() %></td>
	<td><%=dto.getRegdate() %></td>

<%
	}
%>



</table>

<a href="pdswrite.jsp">올리기</a>

<a href="bbslist.jsp">home</a>




</body>
</html>














