package sist.com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BbsDao implements IBbsDao {
	private boolean isS = true;
	private static BbsDao bbsDao;
	
	private  BbsDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1/6");
		} catch (ClassNotFoundException e) {
			log("1/6 Fali", e);
			e.printStackTrace();
		}
	}
	
	public static BbsDao getInstance() {
		if(bbsDao == null){
			bbsDao = new BbsDao();
		}
		return bbsDao;
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
	public List<BbsDto> getBbsList() {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, "
				+ " CONTENT, WDATE, PARENT, DEL, READCOUNT "
				+ " FROM BBS";
				/*+ " ORDER BY REF DESC, STEP ASC ";*/
		
		/*REF DESC 최신글을 맨 위로 올리기 위해*/
		
		List<BbsDto> list = new ArrayList<BbsDto>();	//리턴돼서 넘어 가는 리스트
		
		try {
			conn = this.getConnection();
			log("2/6 success getBbsList");
			
			psmt = conn.prepareStatement(sql);
			log("3/6 success getBbsList");
			
			rs = psmt.executeQuery();
			log("4/6 success getBbsList");
			
			while(rs.next()){
				int i = 1;
				BbsDto dto = new BbsDto(
						rs.getInt(i++), //seq
						rs.getString(i++), //id
						rs.getInt(i++) , //ref
						rs.getInt(i++) , //step
						rs.getInt(i++), //depth
						rs.getString(i++), //제목
						rs.getString(i++), //내뇽
						rs.getString(i++), //기념일
						rs.getInt(i++), //부모글번호
						rs.getInt(i++),	//삭제
						rs.getInt(i++)// 읽은횟수
						);
				
				list.add(dto);				
			}
			log("5/6 success getBbsList");
		} catch (SQLException e) {
			log("Fail" , e);
		}finally {
			this.close(conn, psmt, rs);
			log("6/6 success getBbsList");
		}
		
		return list;
	}
	
	@Override
	public boolean writeBbs(BbsDto dto) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
	/*      String sql = " INSERT INTO BBS "
            + " (SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) "
            + " VALUES(SEQ_BBS.NEXTVAL, ?, (SELECT NVL(MAX(REF),0)+1 FROM BBS), 0, 0 , ?, ?, SYSDATE, 0, 0, 0) "; */   
		
		
		String sql = " INSERT INTO BBS"
				+ "(SEQ, ID, REF, STEP, DEPTH,"
				+ " TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) "
				+ " VALUES(SEQ_BBS.NEXTVAL, ?, "
				+ " (SELECT NVL(MAX(REF),0 )+1 FROM BBS ),"			/*덧글 용  그룹중 최고 번호에 +1 값을 넣어준다.*/
				+ " 0, 0, ?, ?, SYSDATE, 0, 0, 0) ";
		
		int count = 0;
		
		try {
			conn = getConnection();
			log("2/6 success writeBbs");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			log("3/6 success writeBbs");
			
			count = psmt.executeUpdate();
			log("4/6 success writeBbs");
			
		} catch (SQLException e) {
			log("File writeBbs", e);
			
		}finally {
			close(conn, psmt, rs);
			log("5/6 success writeBbs");
		}
		
		return count>0?true:false;
	}

	@Override
	public BbsDto getBbs(int seq) {
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, "
				+ " CONTENT, WDATE, PARENT, DEL, READCOUNT "
				+ " FROM BBS "
				+ " WHERE SEQ=? ";
		
		
		/*String sql = " SELECT ID, TITLE, CONTENT "
				+ "FROM bbs "
				+ "WHERE SEQ=? ";*/
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BbsDto dto = null;	//리턴되서 넘어가는 데이터

		try {
			conn = getConnection();
			log("2/6 Success getBbs");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
		
			
			log("3/6 Success getBbs");
			
			rs=psmt.executeQuery();
			log("4/6 Success getBbs");	
			
			while(rs.next()){
				
				 dto = new BbsDto(
						rs.getInt(1), //seq
						rs.getString(2), //id
						rs.getInt(3) , //ref
						rs.getInt(4) , //step
						rs.getInt(5), //depth
						rs.getString(6), //제목
						rs.getString(7), //내뇽
						rs.getString(8), //기념일
						rs.getInt(9), //부모글번호
						rs.getInt(10),	//삭제
						rs.getInt(11)// 읽은횟수
						);
										
			}
			
			/*
			while(rs.next()){
				String id = rs.getString(1);
				String title = rs.getString(2);
				String content = rs.getString(3);
				
				
				dto = new BbsDto(id,title,content);
				
			}*/
			
			log("5/6 Success getBbs");	
			
		} catch (SQLException e) {
			log("Fali getBbs", e);
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 Success getBbs");	
		}
		
		return dto;
	}
	
	@Override
	public void readCount(int seq) {
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " UPDATE BBS SET "
				+ " READCOUNT=READCOUNT+1 "
				+ "WHERE SEQ=? ";
		
		
		try {
			conn = getConnection();
			log("2/6 Success readCount");	
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
		
			
			log("3/6 Success readCount");
			
			psmt.executeUpdate();
			log("4/6 Success readCount");
			
		} catch (SQLException e) {
			log("Fali readCount", e);
		}finally {
			close(conn, psmt, rs);
			log("5/6 Success readCount");
		}
		
	}
	
	@Override
	public boolean answer(int seq, BbsDto dto) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		
		// 덧글 입력. 한칸씩 밀기 위한 쿼리.
		String sql1 = " UPDATE BBS SET "
				+ " STEP=STEP+1 "
				+ " WHERE REF=(SELECT REF FROM BBS WHERE SEQ=? )"	//1 같은 그룹 번호일때. 
				+ " AND STEP>(SELECT STEP FROM BBS WHERE SEQ=? )";	//2. 현재 스탭보다 큰 스탭의 경우
		
		String sql2 = " INSERT INTO BBS"
				+ " (SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) "
				+ " VALUES(SEQ_BBS.NEXTVAL, ?, "
				+ " (SELECT REF FROM BBS WHERE SEQ=? ), "
				+ " (SELECT STEP FROM BBS WHERE SEQ=? )+1, "	//스텝 하나 증가
				+ " (SELECT DEPTH FROM BBS WHERE SEQ=? )+1, "
				+ "?, ?, SYSDATE, ?, 0, 0) ";
		
		
		int count = 0;
		
		try {
		/*	이중커리 사용시에는 오토커밋 잡야줘야함.*/
			conn = getConnection();
			conn.setAutoCommit(false);
			log("2/6 Success answer");	
			
			psmt=conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
		
			log("3/6 Success answer");
			
			log("sql1 = " + sql1);
			
			count = psmt.executeUpdate();
			psmt.clearParameters();   //쿼리문이 2개라서 클리어 해줌.
			log("4/6 Success answer");
			
			psmt=conn.prepareStatement(sql2);
			psmt.setString(1, dto.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, dto.getTitle());
			psmt.setString(6, dto.getContent());
			psmt.setInt(7, seq);
			
			log("sql2 = " + sql2);
			
			count = psmt.executeUpdate();
			
			
			log("5/6 Success answer");
			conn.commit();
			
			log("6/6 Success answer");
		} catch (SQLException e) {
			log("Fali answer", e);
			try {
				conn.rollback();
			} catch (SQLException ex) {
				
			}
			
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				log("end susscess answer", e);	
			}
		}
		
		
		return count>0?true:false;
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
