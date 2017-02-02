package sist.com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*import com.sun.org.apache.regexp.internal.RE;*/

public class MemberDao implements IMemDao {
	
	private boolean isS = true;
	private static MemberDao memberDao;
	
	private MemberDao () {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1/6");
		} catch (ClassNotFoundException e) {
			log("1/6 Fali", e);
			e.printStackTrace();
		}
	
	}
	
	public static MemberDao getInstance() {
		if(memberDao == null){
			memberDao = new MemberDao();
		}
		return memberDao;
	}
	
	public Connection getConnection() throws SQLException {
		Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		conn = DriverManager.getConnection(url, "hr", "hr");
		return conn;
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
	public boolean addMember(MemberDto dto) {
		String sql = " INSERT INTO MEMBER "
				+ "(ID,NAME,PWD,EMAIL,AUTH) "
				+ "VALUES(?,?,?,?,3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			conn = getConnection();
			log("2/6 Success addMember");
			psmt = conn.prepareStatement(sql);
			
			int i = 1;
			psmt.setString(i++, dto.getId());
			psmt.setString(i++, dto.getName());
			psmt.setString(i++, dto.getPwd());
			psmt.setString(i++, dto.getEmail());
			log("3/6 Success addMember");
			
			count = psmt.executeUpdate();	//db 업데이트
			log("4/6 Success addMember");
			
		} catch (SQLException e) {
			log("Fail addmember" , e);
		}finally {
			this.close(conn, psmt, rs);
			log("5/6 Success addMember");
		}

		return count>0?true:false;
	}

	
	
	@Override
	public MemberDto login(MemberDto dto) {
		
		String sql = " SELECT ID, NAME, EMAIL, AUTH "
				+ "FROM MEMBER "
				+ "WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;	//리턴되서 넘어가는 데이터

		try {
			conn = getConnection();
			log("2/6 Success login");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,dto.getId());
			psmt.setString(2,dto.getPwd());
			log("3/6 Success login");
			
			rs=psmt.executeQuery();
			log("4/6 Success login");	
			while(rs.next()){
				String id = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				int auth = rs.getInt(4);
				
				mem = new MemberDto(id, name, null, email, auth);
				
			}
			log("5/6 Success login");	
			
		} catch (SQLException e) {
			log("Fali login", e);
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 Success login");	
		}
		
		return mem;
	/*	return null;*/
	}
	
	@Override
	public boolean selectId(String id) {
		
		String sql = " SELECT ID FROM MEMBER "
				+ "WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String findId = null;
		
		try {
			conn = this.getConnection();
			log("2/6 Success selectId");
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, id);  //파라메터를 통해서 들어온 id를 sql문에 ?에 들어감
			log("3/6 Success selectId");
			
			rs=psmt.executeQuery();
			log("4/6 Success selectId");
			
			while(rs.next()){
				findId = rs.getString(1);
			}
			log("5/6 Success selectId");
			
		} catch (SQLException e) {
			log("Fail selectId", e);
		}finally {
			close(conn, psmt, rs);
			log("6/6 Success selectId");
		}
		
		if(findId == null || findId.equals("")){
			return false;	//아이디 없다
			
		}
		return true;	//아이디 있다
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









