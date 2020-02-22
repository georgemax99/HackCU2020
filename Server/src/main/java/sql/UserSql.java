package sql;

import beans.User;
import org.apache.commons.dbutils.BeanProcessor;
import util.SQLUtil;

import java.sql.*;

public class UserSql {

	public Long create(User user) {
		Long id = -1L;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "insert into user ( " +
					"name, phoneNumber" +
					") values (?, ?) ";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getPhoneNumber());
			stmt.executeUpdate();
			rs = stmt.getGeneratedKeys();
			if (rs.next())
				id = rs.getLong(1);
		} catch (SQLException e) {
			System.out.println("Database failed to update");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return id;
	}

	public User readByPhoneNumber(String phoneNumber) {
		User user = null;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from user where phoneNumber = ?  ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, phoneNumber);
			rs = stmt.executeQuery();
			if (rs.next()) {
				BeanProcessor bp = new BeanProcessor();
				user = bp.toBean(rs, User.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return user;
	}
}
