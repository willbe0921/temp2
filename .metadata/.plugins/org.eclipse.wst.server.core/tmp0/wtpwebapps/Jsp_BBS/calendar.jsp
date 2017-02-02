<!--calendar.jsp  -->
<%@page import="sist.com.MemberDto"%>
<%@page import="sist.com.CalDao"%>
<%@page import="java.util.List"%>
<%@page import="sist.com.CalDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calendar</title>
<!-- 
<style type="text/css">
table{
	border-collapse:collapse;
	width: 700px;
	border: 1;
}
table, td, th{
	border: 1px solid black;
}
tr{
	height: 100px;
}
tr.date{
	font-size: 30px;
	text-align: center; 
}
.t1{
	margin: auto;
	width: 706px;
	border: 3px solid #8AC007;
	padding: 10px;
}
tr.date{
	font-size: 30px;
	text-align: center;
}
</style>
 -->
<%!
public boolean nvl(String msg){
	return msg == null || 
			msg.trim().equals("")?true:false;
}
 
// 1, 2, 3, 4 ~ 31
//당일 일정 보기
public String callist(int year, int month, int day)
{
	String s="";
	s += String.format("<a href='%s?year=%d&month=%d&day=%d'>", 
						"callist.jsp", year, month, day);
	s += String.format("%2d", day);
	s += "</a>";
	return s;
}
//당일 일정 쓰기 calwrite.jsp
public String showpen(int year, int month, int day){
	String s = "";
	String url = "calwrite.jsp";
	String image = "<img src='image/pen.gif'/>";
	s = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>",
						url, year, month, day, image);
	return s;
}

public String two(String msg){	// 한자리를 두자리로 만들어 주는 함수
	return msg.trim().length()<2?"0"+msg:msg.trim();
}
 
// 제목이 15자이상이면 ...표시한다
public String dot3(String msg){
	String s = "";
	if(msg.length() >= 15){
		s = msg.substring(0, 15);
		s += "...";
	}else{
		s = msg.trim();
	}
	return s;
}
//달력에 테이블로 일정 출력
public String makeTable(int year, int month, int day, List<CalDto> lcdtos){
	String s = "";
	String dates = (year+"") + two(month+"") + two(day+"");
	s = "<table>";
	s += "<col width='98'/>";
	
	for(CalDto lcd:lcdtos){
		if(lcd.getRdate().substring(0, 8).equals(dates)){
			s += "<tr bgcolor='pink'>";
			s += "<td>";
			s += "<a href='caldetail.jsp?seq=" + lcd.getSeq() + "'>";
			s += "<font style='font-size:8px; color:red'>";
			s += dot3(lcd.getTitle());
			s += "</font>";
			s += "</a>";
			s += "</td>";
			s += "</tr>";
		}		
	}
	s += "</table>";
	return s;	
}
 

%>

<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"55291",secure:"55296"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-8" data-genuitec-path="/Jsp_BBS/WebContent/calendar.jsp">

<h1 data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-8" data-genuitec-path="/Jsp_BBS/WebContent/calendar.jsp">달력</h1>

<%
Calendar cal = Calendar.getInstance();
cal.set(Calendar.DATE, 1);

String syear = request.getParameter("year");
String smonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
if(!nvl(syear)){
	year = Integer.parseInt(syear);
}
int month = cal.get(Calendar.MONTH) + 1;
if(!nvl(smonth)){
	month = Integer.parseInt(smonth);
}

if(month < 1){month = 12; year--; }
if(month > 12){month = 1; year++; }

cal.set(year, month-1, 1);

//요일 1 ~ 7
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

CalDao dao = CalDao.getInstance();

MemberDto user = (MemberDto)session.getAttribute("login");

List<CalDto> cdtos = dao.CalList(user.getId(), year+two(month+""));
/* 
String sf = String.format("%d년 %d월", year, month);
String sleft = String.format("calendar.jsp?year=%d&month=%d", 
						year, month-1);
String sright = String.format("calendar.jsp?year=%d&month=%d", 
						year, month+1); */
						
String pp = String.format("<a href='%s?year=%d&month=%d'><img src='image/left.gif'/></a>", 
				"calendar.jsp", year-1, month);						
String p = String.format("<a href='%s?year=%d&month=%d'><img src='image/prec.gif'/></a>", 
				"calendar.jsp", year, month-1);						
String nn = String.format("<a href='%s?year=%d&month=%d'><img src='image/last.gif'/></a>", 
				"calendar.jsp", year+1, month);
String n = String.format("<a href='%s?year=%d&month=%d'><img src='image/next.gif'/></a>", 
				"calendar.jsp", year, month+1);
%>

<div class="t1">
<table border="1">
<col width="100"/><col width="100"/><col width="100"/>
<col width="100"/><col width="100"/><col width="100"/>
<col width="100"/>

<%-- <tr class="date">
	<td colspan="7">
		<a href='<%=sleft %>'>
			<img src="./image/left.png"/>			
		</a>
		<%=sf %>
		<a href='<%=sright %>'>
			<img src="./image/right.png"/>
		</a>		
	</td>
</tr> --%>	


<tr height="100">
	<td colspan="7" align="center">
		<%=pp %>
		<%=p %>
			<font color="red" style="font-size: 50">
				<%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
			</font>
		<%=n %>
		<%=nn %>
	</td>
</tr>

<tr class='date'>
<td>일</td>
<td>월</td>
<td>화</td>
<td>수</td>
<td>목</td>
<td>금</td>
<td>토</td>
</tr>

<tr height="100" align="left" valign="top">
<%
for(int i = 1;i < dayOfWeek; i++){
%>
	<td>&nbsp;</td>
<%
}	
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

for(int i = 1;i <= lastDay; i++){
%>
	<%-- <td height="100" align="left" valign="top">
	<%=i %>
		<a href='calwrite.jsp?year=<%=year %>&month=<%=month %>&day=<%=i %>'>
			<img src='image/pen.gif'/>
		</a>	
	</td> --%>
	<td>
		<%=callist(year, month, i) %>&nbsp;<%=showpen(year, month, i) %>
		<%=makeTable(year, month, i, cdtos) %>	
	</td>
<%
	if((i + dayOfWeek - 1)%7==0){
		%>
		</tr><tr height="100" align="left" valign="top">
		<%
	}
}

for(int i=0;i < (7-(dayOfWeek+lastDay-1)%7)%7; i++){
%>
	<td>&nbsp;</td>
	<%
}	
%>

</tr>
</table>
</div>
</body>
</html>




<%-- <%@page import="sist.com.MemberDto"%>
<%@page import="sist.com.CalDao"%>
<%@page import="java.util.List"%>
<%@page import="sist.com.CalDto"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- <style type="text/css">
table{
	border-collapse:collapse;
	width: 700px;
	border:1;
}
table, td, th{
	border:1px solid black;
}
tr{
	height: 100px;
}
tr.date{
	font-size: 30px;
	text-align: center;
}
.t1{
	margin: auto;
	width: 706px;
	border: 3px solid #8AC007;	
	padding: 10px;
}
tr.date{
	font-size: 30px;
	text-align: center;
}
</style> -->

<%!
public boolean nvl(String msg){
	return msg == null || msg.trim().equals("")?true:false;
}

public String callist(int year , int month, int day){
	//날짜 클릭하면 그날 일정을 가져옴. 1,2,3,4,~31
	String s ="";
	s+= String.format("<a href='%s?year=%d&month=%d&day=%d'>", 
					"callist.jsp", year, month, day);
	
	s += String.format("%2d", day);
	s += "</a>";
	return s;
}

public String showpen(int year, int month, int day){
	String s = "";
	String url = "calwrite.jsp";
	String image = "<img src='image/pen.gif'/>";
	s =  String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", url, year, month, day, image);
	return s;
	
}

public String two(String msg){	//한자리를 두자리로 만들어 주는 함수
	return msg.trim().length()<2?"0"+msg:msg.trim();
}

//제목이 15자 이상이면....표시한다
public String dot3(String msg){
	String s = "";
	if(msg.length() >= 15){
		s = msg.substring(0, 15);
		s += "...";
		
	}else{
		s = msg.trim();
	}
	return s;
}

public String makeTable(int year, int month, int day, List<CalDto> lcdtos){
	
	String s = "";
	String dates = (year + "") + two(month+"") + two(day+"");
	s = "<table>";
	s += "<col width='98'/>";
	
	for(CalDto lcd:lcdtos){
		if(lcd.getRdate().substring(0,8).equals(dates)){
			s += "<tr bgcolor='pink'>";
			s += "<td>";
			s += "<a href='caldetail.jsp?seq='" + lcd.getSeq() + "'>";
			s += "<font style='font-size:8px; color:red'>";
			s += dot3(lcd.getTitle());
			s += "</font>";
			s += "</a>";
			s += "</td>";
			s += "</tr>";
		}
	}
	s += "</tabel>";
	return s;
}

%>




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calendar.jsp</title>
</head>
<body>
<h1>달력</h1>

<%
Calendar cal = Calendar.getInstance();
cal.set(Calendar.DATE, 1);

String syear = request.getParameter("year");	/* 현재면에 대해서 데이터 받아옴.연도랑 달만 있으면 됨. */
String smonth = request.getParameter("month");	//현재 면에서 

int year = cal.get(Calendar.YEAR);		//버튼을 안눌렀을땐 현재 날짜 출력
if(!nvl(syear)){				//syear이 null문자가 아니고 빈 문자가 아닐경우 , 즉 값이 넘어왔을 때 넘어온 값으로 바꿔줌.
	
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH) + 1;
if(!nvl(smonth)){
	month = Integer.parseInt(smonth);
}

if(month < 1){ month = 12; year--;}
if(month > 12){ month = 1; year++;}

cal.set(year, month-1, 1);

int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);	//요일 1~7

CalDao dao = CalDao.getInstance();

MemberDto user = (MemberDto)session.getAttribute("login");

List<CalDto> cdtos = dao.CalList(user.getId(), year+two(month+""));


System.out.println("dayOfWeek = " + dayOfWeek);

/* String sf = String.format("%d년 %d월", year, month);

String sleft = String.format("calendar.jsp?year=%d&month=%d", year, month-1);	//year=%d 부분에 year 값이
String sright = String.format("calendar.jsp?year=%d&month=%d", year, month+1);

 */

String pp = String.format("<a href='%s?year=%d&month=%d'><img src='image/left.gif'/></a>", "calendar.jsp", year-1, month);
 
String p = String.format("<a href='%s?year=%d&month=%d'><img src='image/prec.gif'/></a>", "calendar.jsp", year, month-1);

String nn = String.format("<a href='%s?year=%d&month=%d'><img src='image/last.gif'/></a>", "calendar.jsp", year+1, month);

String n = String.format("<a href='%s?year=%d&month=%d'><img src='image/next.gif'/></a>", "calendar.jsp", year, month+1);
 
 
//에이젝스는 부분적으로 바꿔주기떄문에 전체적으로 갱신하는것보다 가볍다. 버튼에 자기자신이 링크되있다. 
%>



<table>
<tr class="date">
	<td colspan="7">
		<a href='<%=sleft %>'>
			<img src="./image/left.png"/>
		</a>
		<%=sf %>
		<a href='<%=sright %>'>
			<img src="./image/right.png"/>
		</a>
	</td>
</tr>

<div class="t1">
<table border="1">
<col width="100"/><col width="100"/><col width="100"/>
<col width="100"/><col width="100"/><col width="100"/>
<col width="100"/>

<tr height="100">
	<td colspan="7" align="center">
		<%=pp %>
		<%=p %>
			<font color ="red" style="font-size: 50">
				<%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
			</font>
		<%=n %>
		<%=nn %>
	</td>
</tr>	

<tr class='date'>
<td>일</td>
<td>월</td>
<td>화</td>
<td>수</td>
<td>목</td>
<td>금</td>
<td>토</td>
</tr>

<tr height="100" align="left" valign="top">
<%
for(int i = 1; i< dayOfWeek; i++){
%>
	<td>&nbsp;</td>
<%
}


int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

for(int i = 1; i<=lastDay; i++){
%>	
	<td height="100" align="left" valign="top">
	<%=i %>
		<a href='calwrite.jsp?year=<%=year %>&month=<%=month %>&day=<%=i %>'>
		<img src='image/pen.gif'/>
	</a>
	</td>
	
	
	<td>
		<%=callist(year,month,i) %>&nbsp;<%=showpen(year, month, i) %>
		<%=makeTable(year,month,i,cdtos) %>
	</td>
	
<%
	if((i + dayOfWeek - 1)%7==0){
		%>
		</tr><tr height="100" align="left" valign="top">
		<%		
	}
}
for(int i=0; i < (7-(dayOfWeek+lastDay-1)%7)%7; i ++ ){
%>	
	<td>&nbsp;</td>
<%
}
%> 
</tr>
</table>
</div>
</body>
</html>
 --%>














