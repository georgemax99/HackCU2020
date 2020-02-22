package servlets;

import beans.User;
import sql.UserSql;
import util.TextUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String phoneNumber = req.getParameter("phoneNumber");

		UserSql userSql = new UserSql();

		PrintWriter printWriter = resp.getWriter();

		if (userSql.readByPhoneNumber(phoneNumber) == null) {
			User user = new User();
			user.setName(name);
			user.setPhoneNumber(phoneNumber);

			userSql.create(user);

			TextUtil textUtil = new TextUtil();
			textUtil.sendVerificationText(phoneNumber);


			printWriter.print(0);
		} else {
			printWriter.print(1);
		}
	}
}
