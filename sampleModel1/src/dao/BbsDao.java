package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;

public class BbsDao {

	private static BbsDao dao = new BbsDao();
	
	private BbsDao() {
		//MemberDao에서  db 커넥션을 했으니 여기선 실행 안해도 된다.
	}
	
	public static BbsDao getInstance() {
		return dao; // 싱글톤
	}
	
	public List<BbsDto> getBbsList() {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+    " TITLE, CONTENT, WDATE, "
				+    " DEL, READCOUNT "
				+    " FROM BBS "
				+    " WHERE DEL = 0 "
				+    " ORDER BY REF DESC, STEP ASC ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), 
										rs.getInt(5), rs.getString(6), rs.getString(7), 
										rs.getString(8), rs.getInt(9), rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/4 getBbsList success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println(list.get(i).toString());
//		}
		
				
		return list;		
	}
	
	
	public boolean addBbs(BbsDto dto) {
		String sql = " INSERT INTO BBS(SEQ, ID, REF, STEP, DEPTH,"
				+    " TITLE, CONTENT, WDATE, DEL, READCOUNT ) "
				+    " VALUES (SEQ_BBS.NEXTVAL,?, "
				+    " (SELECT NVL(MAX(REF),0)+1 FROM BBS),0,0, "
				+ 	 " ?,?,SYSDATE, "
				+ 	 " 0,0) ";
		
				//SEQ와 REF는 같이 1씩 증가된다.
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addBbs success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addBbs success");

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());


			
			count = psmt.executeUpdate();
			System.out.println("3/3 addBbs success");
			
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("addBbs fail");
			} finally {
				DBClose.close(conn, psmt, null);
			}
			
			
			return count > 0 ? true:false;
			
				
	}
	
	
	public List<BbsDto> getDetail(int seq) {
		
		String sql = " SELECT * "
				+    " FROM BBS "
				+    " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getDetail success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getDetail success");
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), 
										rs.getInt(5), rs.getString(6), rs.getString(7), 
										rs.getString(8), rs.getInt(9), rs.getInt(10));
				list.add(dto);
			}
			System.out.println("3/3 getDetail success");
			
			
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("getDetail fail");
			} finally {
				DBClose.close(conn, psmt, rs);
			}
			
			return list;
	}
	
	
	public boolean bbsUpdate(BbsDto dto, int seq) {
		String sql = " UPDATE BBS "
				+    " SET TITLE = ?, " + 
				     " CONTENT = ? "
				+    " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addBbs success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addBbs success");

			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, seq);

			
			count = psmt.executeUpdate();
			System.out.println("3/3 addBbs success");
			
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("addBbs fail");
			} finally {
				DBClose.close(conn, psmt, null);
			}
			
			
			return count > 0 ? true:false;
			
				
	}
	
	public boolean bbsDelete(int seq) {
		String sql = " UPDATE BBS "
				+    " SET DEL = 1 "
				+    " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addBbs success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addBbs success");

			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addBbs success");
			
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("addBbs fail");
			} finally {
				DBClose.close(conn, psmt, null);
			}
			
			
			return count > 0 ? true:false;
			
				
	}
	
	
	
	public void readcount(int seq) {	//조회수 +1 
		String sql = " UPDATE BBS "
				+ 	 " SET READCOUNT = READCOUNT + 1 "
				+ 	 " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 readcount success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 readcount success");
			psmt.executeUpdate();
			System.out.println("3/3 readcount success");
			
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("readcount fail");
			} finally {
				DBClose.close(conn, psmt, null);
			}
	}
	

	public List<BbsDto> getBbsListSelect(String b, String s) {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+    " TITLE, CONTENT, WDATE, "
				+    " DEL, READCOUNT "
				+    " FROM BBS ";
		
		// 쿼리문에 바로 문자열을 넣으면 ''가 생기므로 컬럼값 넣는 것에 유의한다.
		// 그럴 경우 조건문으로 쿼리문 작성
		if(b.equals("TITLE")) {	
			sql += " WHERE DEL = 0 AND TITLE LIKE ? ";
		}
		else if(b.equals("CONTENT")) {
			sql += " WHERE DEL = 0 AND CONTENT LIKE ? ";
		}
		else if(b.equals("ID")) {
			sql += " WHERE DEL = 0 AND ID LIKE ? ";
		}
		
		sql += " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			psmt.setString(1, "%"+s+"%");
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			
			while(rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), 
										rs.getInt(5), rs.getString(6), rs.getString(7), 
										rs.getString(8), rs.getInt(9), rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/4 getBbsList success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).toString());
		}
		
		return list;		
	}
//						     부모글 번호,  새로운 답글
	public boolean answer(int seq, BbsDto bbs) {
		//update
		String sql1 = " UPDATE BBS "
				+ 	  " SET STEP=STEP+1 "
				+ 	  " WHERE REF=(SELECT REF FROM BBS WHERE SEQ=? ) "
				+ 	  " AND STEP>(SELECT STEP FROM BBS WHERE SEQ=? ) ";
		
		//insert
		String sql2 = " INSERT INTO BBS "
				+ 	  " (SEQ, ID, REF, STEP, DEPTH, "
				+ 	  " TITLE, CONTENT, WDATE, DEL, READCOUNT) "
				+ 	  " VALUES(SEQ_BBS.NEXTVAL, ?, "
				+ 	  " (SELECT REF FROM BBS WHERE SEQ=?), "	//부모글 찾는 서브쿼리
				+  	  " (SELECT STEP FROM BBS WHERE SEQ=?)+1, "	//STEP 하나 늘어남
				+ 	  " (SELECT DEPTH FROM BBS WHERE SEQ=?)+1, "	//DEPTH 하나 늘어남
				+ 	  " ?, ?, SYSDATE, 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;	
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);	// 자동커밋 해제
			System.out.println("1/6 answer success");
			//update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			count = psmt.executeUpdate();
			System.out.println("2/6 answer success");
			
			//psmt 초기화
			psmt.clearParameters();
			System.out.println("3/6 answer success");
			
			
			//insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, bbs.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			System.out.println("4/6 answer success");
			
			count = psmt.executeUpdate();
			System.out.println("5/6 answer success");
			conn.commit();
			System.out.println("6/6 answer success");
			
		} catch (SQLException e) {
			System.out.println("answer fail");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			DBClose.close(conn, psmt, null);
		}
		
		return count>0 ? true:false;
		
		
		
	}
	
	
	
	
	
}
