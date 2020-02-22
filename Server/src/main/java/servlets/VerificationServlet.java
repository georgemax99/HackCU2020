package servlets;

import beans.Code;
import beans.User;
import com.google.gson.Gson;
import sql.CodeSql;
import sql.UserSql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/verification")
public class VerificationServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String phoneNumber = req.getParameter("phoneNumber");
		String code = req.getParameter("code");

		CodeSql codeSql = new CodeSql();

		Code codeObj = codeSql.readByPhoneNumber(phoneNumber);

		PrintWriter printWriter = resp.getWriter();

		if (codeObj != null) {
			if (codeObj.getCode().equals(code)) {
				codeSql.deleteByPhoneNumber(phoneNumber);

				UserSql userSql = new UserSql();
				User user = userSql.readByPhoneNumber(phoneNumber);

				Gson gson = new Gson();

				printWriter.print(gson.toJson(user));

			} else {
				printWriter.print(1);
			}
		} else {
			printWriter.print(2);
		}
	}
}
