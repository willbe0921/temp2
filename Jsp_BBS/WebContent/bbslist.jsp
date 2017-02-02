<%@page import="sist.com.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="sist.com.BbsDao"%>
<%@page import="sist.com.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 지금 로그인 된 회원 정보를 알아야 함. session에 담아놓음.     -->

<%!
public String arrow(int depth){
	String rs = "<img src='image/arrow.png' width='20px' height='20px'>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	//한칸씩 떨어트리는 규격.
	String ts = "";
	for(int i = 0; i < depth; i++){
		ts += nbsp;
	}
	return depth==0? "":ts + rs;	/* depth가 0이면 본문이고, 아니면 덧글이니까 이미지 여백을 반환해줌
									depth의 개수에 따라 여백을 늘려서 마지막에 이미지 추가 */
}
%>

<%
BbsDao dao = BbsDao.getInstance();
List<BbsDto> bbslist = dao.getBbsList();



%>

    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
table{
	border-collapse:collapse;
}
table, th, td{
	boder: 1px solid black;

}
th{
	background-color: green;
	color: black;
}
.tda{
	background-color: #abcdef;
	color:black;
}
.tdb{
	background-color: #febdab;
	color:black;
}

</style>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>bbslist</title>
</head>
<%
Object ologin = session.getAttribute("login");		//로그인 한 멤버의 정보
MemberDto mem = null;
if(ologin == null){
	%>
	<script type="text/javascript">
		alert("로그인 합시다");
		location.href ="index.jsp";
	</script>
	<% 
	return;		//ologin == null 에 걸리면 밑에 있는 작업들은 안하게 됨; 
}
mem = (MemberDto)ologin;
%>    

<body>

<h3>환영합니다<%=mem.getName() %>님 반갑습니다.</h3>

<a href='calendar.jsp'>일정보기</a>

<a href='pdslist.jsp'>자료실</a>

<a href='logout.jsp'>로그아웃</a>

<hr/>

<table border="1">
<col width="50"/><col width="50"/><col width="150"/><col width="500"/><col width="150"/>
<tr>
	<th>순서</th><th>시퀀스</th><th>정보</th><th>제목</th><th>작성자</th>
</tr>

<%
if(bbslist == null || bbslist.size() == 0){
%>
	<tr>
		<td colspan="3">작성된 글이 없다</td>
	</tr>
<%
}
for(int i = 0; i<bbslist.size(); i++){
	BbsDto dto = bbslist.get(i);
	%>

	<tr <%=i%2 == 0?"class='tda'":"class='tdb'" %>>
		<td><%=i+1 %></td>
		<td><%=dto.getSeq() %></td>
		<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
		<td><%=arrow(dto.getDepth()) %> <!-- depth에 따라 여백을 늘릴지 말지 결정. arrow 0이든 1이든  -->
			<a href='bbsdetail.jsp?seq=<%=dto.getSeq() %>'>
			<%=dto.getTitle() %>
			</a>
		</td>
		<td><%=dto.getId() %></td>

<%
}
%>


</table>



<a href='bbswrite.jsp'>글 쓰기</a>




</body>
</html>