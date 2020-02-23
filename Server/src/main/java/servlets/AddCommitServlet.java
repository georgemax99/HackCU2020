package servlets;

import beans.Commit;
import sql.CommitSql;
import sql.EventSql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/addCommit")
public class AddCommitServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long userId = Long.parseLong(req.getParameter("userId"));
		Long eventId = Long.parseLong(req.getParameter("eventId"));


		Commit commit = new Commit();
		commit.setEventId(eventId);
		commit.setUserId(userId);

		CommitSql commitSql = new CommitSql();

		PrintWriter printWriter = resp.getWriter();

		if (commitSql.readByEventIdAndUserId(commit) == null) {
			commitSql.create(commit);

			EventSql eventSql = new EventSql();
			eventSql.incrementCommitted(eventId);

			printWriter.print(0);
		} else {
			commitSql.deleteByEventIdAndUserId(commit);
			EventSql eventSql = new EventSql();
			eventSql.decrementCommitted(eventId);
			printWriter.print(1);
		}

	}
}
