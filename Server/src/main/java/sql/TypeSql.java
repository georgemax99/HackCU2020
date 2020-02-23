package sql;

import beans.Code;
import beans.Event;
import beans.Type;
import org.apache.commons.dbutils.BeanProcessor;
import util.SQLUtil;

import java.sql.*;
import java.util.List;

public class TypeSql {

	public Long create(Type type) {
		Long id = -1L;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "insert into type ( " +
					"UserId, type" +
					") values (?, ?) ";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setLong(1, type.getUserId());
			stmt.setInt(2, type.getType());
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

	public List<Type> getTypesByUserId(Long userId) {
		List<Type> types = null;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from type where userId = ?  ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, userId);
			rs = stmt.executeQuery();
			BeanProcessor bp = new BeanProcessor();
			types = bp.toBeanList(rs, Type.class);

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return types;
	}

	public Type readByTypeAndUserId(Type type) {
		Type type1 = null;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from type where userId = ? and type = ?  ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, type.getUserId());
			stmt.setInt(2, type.getType());
			rs = stmt.executeQuery();
			if (rs.next()) {
				BeanProcessor bp = new BeanProcessor();
				type1 = bp.toBean(rs, Type.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return type1;
	}

	public void deleteByTypeAndUserId(Type type) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "delete from type where userId = ? and type = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, type.getUserId());
			stmt.setInt(2, type.getType());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}

	public void deleteBydUserId(Type type) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "delete from type where userId = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, type.getUserId());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}

}
