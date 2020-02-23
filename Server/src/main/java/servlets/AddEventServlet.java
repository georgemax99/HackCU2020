package servlets;

import beans.Event;
import sql.EventSql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet("/addEvent")
public class AddEventServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title");
		String city = req.getParameter("city");
		String state = req.getParameter("state");
		String lon = req.getParameter("lon");
		String lat = req.getParameter("lat");
		int numNeeded = Integer.parseInt(req.getParameter("numNeeded"));
		Long userId = Long.parseLong(req.getParameter("userId"));
		String description = req.getParameter("description");
		String time = req.getParameter("time");
		int type = Integer.parseInt(req.getParameter("type"));

		EventSql eventSql = new EventSql();
		eventSql.deleteByUserId(userId);

		Event event = new Event();
		event.setTitle(title);
		event.setCity(city);
		event.setState(state);
		event.setLat(lat);
		event.setLon(lon);
		event.setUserId(userId);
		event.setNumberCommitted(0);
		event.setNumberNeeded(numNeeded);
		event.setDescrip(description);
		event.setUserCommited(0);
		event.setTime(time);
		event.setNow(new Date());
		event.setType(type);

		eventSql.create(event);

		PrintWriter printWriter = resp.getWriter();
		printWriter.print(0);

	}
}
