package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "hr";
			String dbPassword = "hr";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER1 WHERE userID =?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치 
			}
			return -1;	// 아이디가 없음
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}

	public String nickName(String userID) throws SQLException {
		String SQL = "SELECT usernickname FROM USER1 WHERE userID =?";
	
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString("usernickname");
				}
			return null;
			
			
		
				
	}
	

public int join(User user) {
	String SQL = "INSERT INTO USER1 VALUES(?,?,?,?,?,?)";
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, user.getUserID());
		pstmt.setString(2, user.getUserPassword());
		pstmt.setString(3, user.getUserName());
		pstmt.setString(4, user.getUserNickName());
		pstmt.setString(5, user.getUserGender());
		pstmt.setString(6, user.getUserEmail());
		return pstmt.executeUpdate();
	}catch(Exception e) {
		e.printStackTrace();
		
	}
	return -1;
 
}


public int findID(String userName, String userEmail) {
	String SQL = "select username from user1 where userName = ? and USEREMAIL= ? ";
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userName);
		pstmt.setString(2, userEmail);
		rs = pstmt.executeQuery();
		
			if (rs.next()) {
				if(rs.getString(1).equals(userName)) {
					return 1; //  성공
				}
				else
					return 0; // 이메일이 x
			}
			return -1;	// 정보가 x
			
			} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	
		}

public String findread(String userName, String userEmail) {
	String userID = null;
	String SQL = "select userID from user1 where userName = ? and USEREMAIL= ? ";
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userName);
		pstmt.setString(2, userEmail);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			userID = rs.getString("userID");
		}
			
	} catch (Exception e) {
		e.printStackTrace();
	}
	return userID;
	
		}





public int findPW(String userName,String userID ,String userEmail) {
	String SQL = "select userName from user1 where userName = ? and USERID= ? and userEmail =?";
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userName);
		pstmt.setString(2, userID);
		pstmt.setString(3, userEmail);
		rs = pstmt.executeQuery();
		
			if (rs.next()) {
				if(rs.getString(1).equals(userName)) {
					return 1; //  성공
				}
				else
					return 0; // 이메일이 x
			}
			return -1;	// 정보가 x
			
			} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	
		}

public String findPWread(String userName, String userEmail,String userID) {
	String userPassword = null;
	String SQL = "select userPassword from user1 where userName = ? and USEREMAIL= ? and UserID=? ";
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, userName);
		pstmt.setString(2, userEmail);
		pstmt.setString(3, userID);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			userPassword = rs.getString("userPassword");
		}
			
	} catch (Exception e) {
		e.printStackTrace();
	}
	return userPassword;
	
}
}
//public int findID(String userName, String userEmail) {
//	String SQL = "select username from user1 where userName = ? and USEREMAIL= ? ";
//	try {
//		pstmt = conn.prepareStatement(SQL);
//		pstmt.setString(1, userName);
//		pstmt.setString(2, userEmail);
//		rs = pstmt.executeQuery();
//			if (rs.next()) {
//				if(rs.getString(1).equals(userName)) {
//					return 1; // 로그인 성공
//				}
//				else
//					return 0; // 비밀번호 불일치 
//			}
//			return -1;	// 아이디가 없음
//			
//			} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -2; // 데이터베이스 오류
//	
//		}
	


	













