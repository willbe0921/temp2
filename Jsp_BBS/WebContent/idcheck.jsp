<%@page import="sist.com.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String user_id = request.getParameter("id");

System.out.println("user_id = " + user_id);

MemberDao dao = MemberDao.getInstance();

boolean flag = dao.selectId(user_id);

if(flag){
	out.print("NO");	//이미 아이디 존재 함.
}else{
	out.print("YES");
}

%>
