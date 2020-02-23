package servlets;

import beans.Type;
import sql.TypeSql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/addTypes")
public class AddTypesServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long userId = Long.parseLong(req.getParameter("userId"));
		String types = req.getParameter("types");
		types = types.substring(1, types.length()-1);
		System.out.println(types);

		String[] elems = types.split(", ");
		List<String> typesList = Arrays.asList(elems);


		TypeSql typeSql = new TypeSql();
		Type type = new Type();
		type.setUserId(userId);
		typeSql.deleteBydUserId(type);

		for (int i = 0; i < typesList.size(); i++) {
			type.setType(Integer.parseInt(typesList.get(i)));
			typeSql.create(type);
		}

		PrintWriter printWriter = resp.getWriter();
		printWriter.print(0);
	}
}
