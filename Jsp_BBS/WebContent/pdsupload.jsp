<%@page import="sist.com.PdsDto"%>
<%@page import="sist.com.PdsDao"%>
<%@page import="sist.com.MemberDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdsupload.jsp</title>

<!-- 파일 다운은 서블릿, 파일 업로드는 pdsupload.jsp -->
</head>
<body>

<%!
public void processFromField(FileItem item, JspWriter out) throws IOException{
	
	String name = item.getFieldName();
	String value = "";
	try{
		value = item.getString("utf-8");
	}catch(Exception e){
		value = item.getString();
	}
}

public void processUploadedFile(FileItem fileItem, String dir, JspWriter out) throws IOException {
	//JspWriter: 웹브라이저에 출력하기 위한  
	String fieldName = fileItem.getFieldName();
	String fileName = fileItem.getName();	//getName() 업로드된 파일의 파일명을 돌려준다. 파일명은 path명도 포함.
	String contentType = fileItem.getContentType();
	long sizeInBytes = fileItem.getSize();
	
	//파일의 정보를 얻어와서
	
	System.out.println("size: " + sizeInBytes);
	
	if(sizeInBytes > 0){	//업로드한 파일이 존재하는 경우
		int idx = fileName.lastIndexOf("\\");
		//마지막에 \\ 붙이고
	
		if(idx == -1){
			idx = fileName.lastIndexOf("/");
		}
		fileName = fileName.substring(idx+1);
		try{
			File uploadedFile = new File(dir, fileName);
			fileItem.write(uploadedFile);	//업로드된 데이터를 인수로 지정된 파일에 쓴다.
		}catch(Exception e){
			
		}
		
		
	}
}

%>

<%
//개인 pc 폴더 올림?
String fupload = "c:\\upload";

//톰캣 서버에 배포하고 싶으면, 실무 서버는 계속 돌아감. //업로드 다운로드 사이에 꺼지면 안됨.
/* String fupload = application.getRealPath("/upload"); */

System.out.println("fupload: " + fupload);

String yourTempDirectory = fupload;
int yourMaxRequestSize = 100*1024*1024; //10메가
int yourMaxMemorySize = 100*1024;	//파일의 최대 크기

String id= "";
String title = "";
String content = "";
String filename = "";

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//Servlet 프로그램을 경유해서 파일 데이터를 취득하는 클래스 
if(isMultipart){
	//fileitem 오브젝트를 생성하는 클래스. 메모리,HDD에서 데이터처리에 관한 메소드가 있다.
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	//setSizeThreshold 메소드에서 지정한 버퍼의 최대 값을 넘었을 경우 버퍼내에서 데이터를 보전하는 일시 영역을 지정한다. 넘어갔을 경우 대비책
	factory.setSizeThreshold(yourMaxMemorySize);	//한번에 메모리 저장할 크기를 설정
	factory.setRepository(new File(yourTempDirectory));
	
	
	//파일데이터는 fileitem 오브젝트가 저장되었던 list로 돌려준다.
	//Servlet프로그램을 경유하고, 파일데이터를 취득하는 클래스.
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(yourMaxRequestSize);		//파일 업로드 최대 사이즈
	
	List<FileItem> items = upload.parseRequest(request);
	System.out.println("items: " + items);
	
	Iterator<FileItem> iter = items.iterator();
	
	while(iter.hasNext()){
		FileItem item = iter.next();
		
		//파일타입이 아닌 ...
		if(item.isFormField()){
			processFromField(item, out);
			
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");
			}else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
			}else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}
			
		}else{	//파일 타입 폼 필드
			 if(item.getFieldName().equals("fileload")){
				 
				 int idx = item.getName().lastIndexOf("\\");
				 if(idx == -1){
					 idx = item.getName().lastIndexOf("/");
				 }
				 filename = item.getName().substring(idx + 1);
			 }
			processUploadedFile(item, fupload, out);
		}
		
	}
	
}else{
	System.out.println("Multipart가 아님~~~~~");
}

PdsDao dao = PdsDao.getInstance();
boolean isS = dao.writePds(new PdsDto(id, title, content, filename));

if(isS){
%>
	<script type="text/javascript">
	alert("성공");
	location.href = 'pdslist.jsp';
	</script>

<%
}else{
%>
	<script type="text/javascript">
	alert("실패");
	location.href = 'pdslist.jsp';
	</script>



<%
}

%>



</body>
</html>







