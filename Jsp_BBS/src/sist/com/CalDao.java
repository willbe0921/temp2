
//CalDao dddd
package sist.com;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*import java.util.Calendar;*/
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import sist.com.CalDto;

public class CalDao implements ICalDao {
	
	private boolean isS = true;
	private static CalDao calDao;
	
	public CalDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1/6");
		} catch (ClassNotFoundException e) {
			log("1/6 Fali", e);
			e.printStackTrace();
		}
	
	}
	public static CalDao getInstance() {
		if(calDao == null){
			calDao = new CalDao();
		}
		return calDao;
	}
	
	@Override
	public boolean addCalendar(CalDto cal) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		String sql = " INSERT INTO CALENDAR( "
				+ " SEQ, ID, TITLE, CONTENT, RDATE, WDATE) "
				+ " VALUES(SEQ_CALENDAR.NEXTVAL, "
				+ " ?, ?, ?, ?, SYSDATE) ";
		
		int count = 0;
		
		try {
			conn = getConnection();
			log("2/6 success addCalendar");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, cal.getId());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			log("3/6 success addCalendar");
			
			count = psmt.executeUpdate();
			log("4/6 success addCalendar");
			
		} catch (SQLException e) {
			log("fail success addCalendar",e);
		}finally {
			close(conn, psmt, null);
			log("5/6 success addCalendar");
		}
		
		
		return count>0?true:false;
	}
	
	
	public void close(Connection conn, Statement psmt, ResultSet rs) {
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
		
			}
		}
		if(psmt != null){
			try {
				psmt.close();
			} catch (SQLException e) {
			}
		}
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
			}
		}	
	}
	
	@Override
	public List<CalDto> CalList(String id, String yyyyMM) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ " FROM ("
				+ " SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8) "
				+ " ORDER BY RDATE ASC) RN, SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ " FROM CALENDAR "
				+ " WHERE ID=? AND SUBSTR(RDATE, 1, 6)=? "	//일정이 있는 달 201701 6자리만 자름.
				+ " )WHERE RN BETWEEN 1 AND 5 ";		//보여질 데이터의 row 개수.
		
		
		//ROW_NUMBER() 특정 column의 값을 기준으로 정렬하여 순서를 매긴다.
		//SUBSTR(STRING , 시작 , 길이) 시작점에서 길이만큼 잘라서 사용.
		
		List<CalDto> cdtos = new ArrayList<CalDto>();
		
		try {
			conn = getConnection();
			log("2/6 success CalList");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM.trim());
			log("3/6 success CalList");
			
			rs = psmt.executeQuery();
			log("4/6 success CalList");
			
			while(rs.next()){
				CalDto dto = new CalDto();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));
				cdtos.add(dto);
				
			}
			log("5/6 success CalList");
		
		} catch (SQLException e) {
			log("fail CalList", e);
		}finally {
			close(conn, psmt, rs);
			log("5/6 success CalList");
		}
		
		
		
		
		return cdtos;
	}
	


	@Override
	public boolean deletelist(int seq) {
		
		
		return false;
	}
	
	
	
	@Override
	public CalDto getdetail(int seq) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ " FROM CALENDAR "
				+ " WHERE SEQ=?";
		
		CalDto dto = null;
		
		
		try {
			conn = getConnection();
			log("2/6 Success getdetail");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			log("3/6 Success getdetail");
			
			rs=psmt.executeQuery();
			log("4/6 Success getdetail");
			
			while(rs.next()){
			
			dto = new CalDto(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6)
					);
		}
			
		} catch (Exception e) {
			log("fail getdetail",e);
		}finally {
			this.close(conn, psmt, rs);
			log("5/6 Success getdetail");
		}
		
		return dto;
	}
	
	@Override
	public List<CalDto> getDayList(String id, String yyyymmdd) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ "FROM CALENDAR "
				+ " WHERE ID=? AND SUBSTR(RDATE, 1, 8)=? "
				+ " ORDER BY RDATE ";
		//뒤에 시간까지 있을 수 있으니까 8자리까지만 뻬온다.
		
		List<CalDto> callist = new ArrayList<CalDto>();
		
		try {
			conn = getConnection();
			log("2/6 Success getDayList");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyymmdd);
			log("3/6 Success getDayList");
			
			rs = psmt.executeQuery();
			log("4/6 Success getDayList");
			
			while(rs.next()){
				CalDto dto = new CalDto(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6)
						);
				callist.add(dto);
			}
			log("5/6 Success getDayList");
			
		} catch (SQLException e) {
			log("Fail getDayList",e);
		}finally {
			close(conn, psmt, rs);
			log("6/6 Success getDayList");
		}
		


		return callist;
	}
	
	public Connection getConnection() throws SQLException {
		Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		conn = DriverManager.getConnection(url, "hr", "hr");
		return conn;
	}
	
	public void log(String msg , Exception e) {
		if(isS){
			System.out.println(e + ":" + getClass() + ":" + msg); //getClass 현재 클래스가 무엇인지 알려줌.
		}	
	}
	
	public void log(String msg) {
		if(isS){
			System.out.println(getClass() + ":" + msg); //getClass 현재 클래스가 무엇인지 알려줌.
		}
	}

}
