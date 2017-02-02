package sist.com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PdsDao implements IPdsDao {
	
	private boolean isS = true;
	private static PdsDao pdsDao;
	
	public PdsDao() {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1/6");
		} catch (ClassNotFoundException e) {
			log("1/6 Fali", e);
			e.printStackTrace();
		}
		
	}
	
	public static PdsDao getInstance() {
		if(pdsDao == null){
			pdsDao = new PdsDao();
		}
		return pdsDao;
	}
	
	
	
	@Override
	public boolean writePds(PdsDto pds) {
		Connection conn = null;
		PreparedStatement psmt = null;
		
		String sql = " INSERT INTO PDS( "
				+ " SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE) "
				+ " VALUES(SEQ_PDS.NEXTVAL, "
				+ " ?, ?, ?, ?, 0, 0, SYSDATE) ";
		
		
		int count = 0; //rs가 없기때문에 확인하기 위한 변수
		
		try {
			conn = getConnection();
			log("2/6 success writePds");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContent());
			psmt.setString(4, pds.getFilename());
			
			log("3/6 success writePds");
			count = psmt.executeUpdate();
			log("4/6 success writePds");
			
			
		} catch (SQLException e) {
			log("fail writePds",e);
			
		}finally {
			close(conn, psmt, null);
			log("5/6 success writePds");
		}
		
		return count>0?true:false;
	}
	
	@Override
	public List<PdsDto> getPdss() {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM PDS "
				+ " ORDER BY SEQ ASC ";
		
		List<PdsDto> list = new ArrayList<PdsDto>();
		
		try {
			conn = getConnection();
			log("2/6 Success getPdss");
			
			psmt = conn.prepareStatement(sql);
			
			log("3/6 Success getPdss");
			
			rs=psmt.executeQuery();
			log("4/6 Success getPdss");
			
			while(rs.next()){
				
				PdsDto dto = new PdsDto(
						
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getInt(6),
						rs.getInt(7),
						rs.getString(8)
						);
				list.add(dto);
	
			}
			log("5/6 Success getPdss");
			
		} catch (Exception e) {
			log("fail getPdss",e);
		}finally {
			this.close(conn, psmt, rs);
			log("6/6 Success getPdss");
		}
	
		return list;
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
