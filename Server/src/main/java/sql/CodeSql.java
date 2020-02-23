package sql;

import beans.Code;
import beans.Event;
import org.apache.commons.dbutils.BeanProcessor;
import util.SQLUtil;

import java.sql.*;
import java.util.List;

public class CodeSql {
	public Long create(Code code) {
		Long id = -1L;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "insert into code ( " +
					"phoneNumber, code" +
					") values (?, ?) ";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, code.getPhoneNumber());
			stmt.setString(2, code.getCode());
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

	public Code readByPhoneNumber(String phonenumber) {
		Code code = null;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from code where phoneNumber = ?  ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, phonenumber);
			rs = stmt.executeQuery();
			if (rs.next()) {
				BeanProcessor bp = new BeanProcessor();
				code = bp.toBean(rs, Code.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return code;
	}

	public void deleteByPhoneNumber(String phonenumber) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "delete from code where phoneNumber = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, phonenumber);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}
}
