package com.employee;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		try {
			if (DbUtil.isMatch(username, password)) {
				HttpSession session = request.getSession();
				session.setAttribute("username", username);
				RequestDispatcher rd = request.getRequestDispatcher("mainPage.jsp");
				rd.forward(request, response);
			} else {
				String msg = "mismatch";
				request.setAttribute("wrong", msg);

				RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
				rd.include(request, response);
			}
		} catch (ClassNotFoundException | SQLException | ServletException | IOException e) {
			e.printStackTrace();
		}

	}

}
