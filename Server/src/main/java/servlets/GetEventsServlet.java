package servlets;

import beans.Commit;
import beans.Event;
import com.google.gson.Gson;
import sql.CommitSql;
import sql.EventSql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/getEvents")
public class GetEventsServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String city = req.getParameter("city");
		String state = req.getParameter("state");
		Long userId = Long.parseLong(req.getParameter("userId"));

		EventSql eventSql = new EventSql();

		List<Event> events = eventSql.getReportsByCityAndStateAndDate(city, state);

		PrintWriter printWriter = resp.getWriter();

		if (events != null) {
			Gson gson = new Gson();

			CommitSql commitSql = new CommitSql();

			for (int i = 0; i < events.size(); i++) {
				Commit commit = new Commit();
				commit.setUserId(userId);
				commit.setEventId(events.get(i).getId());
				if (commitSql.readByEventIdAndUserId(commit) != null) {
					events.get(i).setUserCommited(1);
				}
			}
			printWriter.print(gson.toJson(events));
		} else {
			printWriter.print(1);
		}

	}
}
