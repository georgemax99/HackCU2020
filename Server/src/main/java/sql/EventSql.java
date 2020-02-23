package sql;

import beans.Code;
import beans.Event;
import org.apache.commons.dbutils.BeanProcessor;
import util.SQLUtil;

import java.sql.*;
import java.util.List;

public class EventSql {
	public Long create(Event event) {
		Long id = -1L;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "insert into event ( " +
					"userId, numberNeeded, numberCommitted, title, city, state, lon, lat " +
					") values (?, ?, ?, ?, ?, ?, ?, ?) ";
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setLong(1, event.getUserId());
			stmt.setInt(2, event.getNumberNeeded());
			stmt.setInt(3, event.getNumberCommitted());
			stmt.setString(4, event.getTitle());
			stmt.setString(5, event.getCity());
			stmt.setString(6, event.getState());
			stmt.setString(7, event.getLon());
			stmt.setString(8, event.getLat());
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

	public List<Event> getReportsByCityAndStateAndDate(String city, String state) {
		List<Event> events = null;
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from event where city = ? and state = ?  ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, city);
			stmt.setString(2, state);
			rs = stmt.executeQuery();
			if (rs.next()) {
				BeanProcessor bp = new BeanProcessor();
				events = bp.toBeanList(rs, Event.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt, rs);
		}
		return events;
	}

	public void deleteByUserId(Long userId) {
		Connection conn = SQLUtil.getConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "delete from event where userId = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, userId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Database failed to query.");
		} finally {
			SQLUtil.close(conn, stmt);
		}
	}
}
