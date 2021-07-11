package com.employee;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EmployeeController")
public class EmployeeController extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String theCommand = request.getParameter("command");
		if (theCommand == null) {
			theCommand = "LIST";
		}
		PrintWriter p = response.getWriter();
		switch (theCommand) {

		case "ADD":
			String msg;
			try {
				addEmployeee(request, response);
				msg = "successfully added!!";
			} catch (Exception e) {
				msg = "Enter unique values!";
				e.printStackTrace();
			}

			request.setAttribute("success", msg);
			break;

		case "LIST":
			try {
				listEmployee(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "DELETE":
			try {
				deleteEmployeee(request, response);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "UPDATE":
			try {
				updateEmployeee(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "SORT":
			try {
				sortEmployee(request, response);
			} catch (Exception e) {
				RequestDispatcher rd = request.getRequestDispatcher("sort.jsp");
				rd.include(request, response);
			}
			break;

		case "SEARCH":
			try {
				searchEmployee(request, response);
			} catch (Exception e) {
				RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
				rd.include(request, response);
			}
			break;
		case "UPDATEPROFILE":
			try {
				updateProfile(request, response);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			String msg1 = "Updated successfully!!";
			request.setAttribute("success", msg1);
			RequestDispatcher rd = request.getRequestDispatcher("mainPage.jsp");
			rd.include(request, response);
			break;
		}

	}

	private void updateProfile(HttpServletRequest request, HttpServletResponse response)
			throws ClassNotFoundException, SQLException, ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String address = request.getParameter("address");
		String mobile = request.getParameter("mobileNum");
		String password = request.getParameter("password");
		Employee employee = new Employee(id, name, age, address, mobile, password);
		DbUtil.UpdateEmployeeProfile(employee);

	}

	private void searchEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		String attr = request.getParameter("attributes");
		String type = request.getParameter("type");
		String ch = request.getParameter("ch");
		String query = null;

		if (type.equals("contains")) {
			if (!attr.equals("id") || !attr.equals("age"))
				query = " like '%" + ch + "%'";

		} else if (type.equals("StartsWith")) {
			if (!attr.equals("id") || !attr.equals("age"))
				query = " like '" + ch + "%'";

		} else if (type.equals("EndsWith")) {
			if (!attr.equals("id") || !attr.equals("age"))
				query = " like '%" + ch + "'";

		} else if (type.equals("Equal")) {
			if (!attr.equals("id") || !attr.equals("age"))
				query = "='" + ch + "'";
			else
				query = "=" + ch + "";
		} else if (type.equals("NotEqual")) {
			if (!attr.equals("id") || !attr.equals("age"))
				query = "<>'" + ch + "'";
			else
				query = "<>" + ch + "";
		}

		ArrayList<Employee> employee = DbUtil.searchEmployee(attr, query);
		request.setAttribute("EMPLOYEE_LIST", employee);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/list-employee.jsp");
		dispatcher.forward(request, response);

	}

	private void sortEmployee(HttpServletRequest request, HttpServletResponse response)
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		String attr = request.getParameter("attributes");
		String type = request.getParameter("type");
		ArrayList<Employee> employee = DbUtil.sortEmployee(attr, type);
		request.setAttribute("EMPLOYEE_LIST", employee);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/list-employee.jsp");
		dispatcher.forward(request, response);

	}

	private void updateEmployeee(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		String mail = request.getParameter("mail");
		String mobile = request.getParameter("mobileNum");
		String dep = request.getParameter("dep");
		String category = request.getParameter("category");
		Employee employee = new Employee(id, name, age, address, gender, mail, mobile, dep, category);
		DbUtil.UpdateEmployee(employee);
		listEmployee(request, response);
	}

	private void deleteEmployeee(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int Id = Integer.parseInt(request.getParameter("id"));
		DbUtil.deleteStudent(Id);
		listEmployee(request, response);

	}

	private void listEmployee(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ArrayList<Employee> employee = DbUtil.listEmployee();
		String type1 = "list";
		request.setAttribute("EMPLOYEE_LIST", employee);
		request.setAttribute("Type", type1);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/list-employee.jsp");
		dispatcher.forward(request, response);

	}

	private void addEmployeee(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		String mail = request.getParameter("mail");
		String mobile = request.getParameter("mobileNum");
		String dep = request.getParameter("dep");
		String category = request.getParameter("category");
		Employee employee = new Employee(name, age, address, gender, mail, mobile, dep, category);
		try {
		DbUtil.addEmployee(employee);
		}catch(Exception e) {
			request.setAttribute("msg", "exist");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/add.jsp");
			dispatcher.forward(request, response);

		}
	}

}
