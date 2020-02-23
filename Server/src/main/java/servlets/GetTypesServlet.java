package servlets;

import beans.Type;
import com.google.gson.Gson;
import sql.TypeSql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/getTypes")
public class GetTypesServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long userId = Long.parseLong(req.getParameter("userId"));

		TypeSql typeSql = new TypeSql();

		List<Type> types = typeSql.getTypesByUserId(userId);

		Gson gson = new Gson();

		PrintWriter printWriter = resp.getWriter();
		printWriter.print(gson.toJson(types));

	}
}
