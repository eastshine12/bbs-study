package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	
	private static MemberDao dao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnection();
	}

	public static MemberDao getInstance() {
		return dao;	//싱글톤 사용
	}
	
	public boolean addMember(MemberDto dto) {	//멤버가 추가됐는지 true, false 반환 메소드
		
		String sql = " INSERT INTO MEMBER(ID, PWD, NAME, EMAIL, AUTH) "
				+ 	 " VALUES(?, ?, ?, ?, 3) "; // 마지막 Auth -> 사용자 : 3.	관리자 :1	(구별번호)
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
		conn = DBConnection.getConnection();
		System.out.println("1/3 addMember success");
		psmt = conn.prepareStatement(sql);
		System.out.println("2/3 addMember success");
		psmt.setString(1, dto.getId());
		psmt.setString(2, dto.getPwd());
		psmt.setString(3, dto.getName());
		psmt.setString(4, dto.getEmail());
		
		count = psmt.executeUpdate();
		System.out.println("3/3 addMember success");
		
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("addMember fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		
		
		return count > 0 ? true:false;
		
	}
	
	
	public boolean getId(String id) {
		String sql = " SELECT ID "
				+    " FROM MEMBER "
				+    " WHERE ID = ?";
		
		boolean _id = false;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			System.out.println("2/3 getId success");
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");
			
			while(rs.next()) {
				_id = true;	// 하나라도 있으면 true;
				break;
			};
			
		}catch (Exception e) {
			System.out.println("3/3 getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		};
		
		return _id;
		
	}
	
	
	public boolean myLogin(String id, String pwd) {
		String sql = " SELECT ID, PWD "
				+    " FROM MEMBER ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean b = false;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 myLogin success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 myLogin success");
			rs = psmt.executeQuery();
			System.out.println("3/3 myLogin success");
			
			while(rs.next()) {
				if(id.equals(rs.getString("ID")) && pwd.equals(rs.getString("PWD"))) {
					b = true;
					break;
				} else {
					System.out.println("아이디 없다");
				}
			};
			
		}catch (Exception e) {
			System.out.println("3/3 myLogin fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		};
		
		
		return b;
		
	}
	

	
}
