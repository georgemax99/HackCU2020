package sql;

import beans.Code;
import beans.Commit;
import org.apache.commons.dbutils.BeanProcessor;
import util.SQLUtil;

import java.sql.*;

public class CommitSql {

	public Long create(Commit commit) {
		Long id = -1L;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "insert into commit ( " +
					"userId, eventId" +
					") values (?, ?) ";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setLong(1, commit.getUserId());
			stmt.setLong(2, commit.getEventId());
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

	public void deleteByEventId(Long eventId) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "delete from commit where eventId = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, eventId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}

	public void deleteByEventIdAndUserId(Commit commit) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "delete from commit where eventId = ? and userId = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, commit.getEventId());
			stmt.setLong(2, commit.getUserId());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}

	public void decrementCommitted(Long eventId) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "update event set numberCommitted = numberCommitted - 1 where id = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, eventId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}

	public Commit readByEventIdAndUserId(Commit commit) {
		Commit commit1 = null;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from commit where userId = ? and eventId = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, commit.getUserId());
			stmt.setLong(2, commit.getEventId());
			rs = stmt.executeQuery();
			if (rs.next()) {
				BeanProcessor bp = new BeanProcessor();
				commit1 = bp.toBean(rs, Commit.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return commit1;
	}


}
