<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%> 
<%@page import="com.employee.Employee"%>
<%@page import="com.employee.DbUtil"%>
<%@page import="java.util.Iterator"%> 
<%@page import="java.lang.*"%> 
<!DOCTYPE html>
<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>List of Employees</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <link rel="stylesheet" type="text/css" href="style.css">
   </head>
   <body>
      <%
         response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
         %>
      <%
         if(session.getAttribute("username")==null)
         {
         	RequestDispatcher rd=request.getRequestDispatcher("Login.jsp");
         	rd.forward(request, response);
         }else{
          String name=String.valueOf(session.getAttribute("username"));
         %>
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
               <li class="nav-item">
                  <a href="mainPage.jsp"><button>HOME</button></a>
               </li>
               <li class="nav-item active">
                  <form action="EmployeeController">
                     <input type="submit" name="command" value="LIST" />
                  </form>
               </li>
               <li class="nav-item">
                  <a href="sort.jsp"><button>SORT</button></a>
               </li>
               <li class="nav-item">
                  <a href="search.jsp"><button>SEARCH</button></a>
               </li>
               <%
                  String type = DbUtil.getCategoryName(name);
                  if (!type.equals("User")) {
                  %>
               <li class="nav-item">
                  <a href="add.jsp"><button>ADD</button></a>
               </li>
               <%
                  }
                  %>
               <%
                  String type1 = DbUtil.getCategoryName(name);
                  if (!type1.equals("admin")) {
                  %>
               <li class="nav-item">
                  <form action="updateProfile.jsp">
                     <input type="hidden" name="id"
                        value="<%=DbUtil.getEmployeeId(name)%>"> <input
                        type="submit" value="MY PROFILE">
                  </form>
               </li>
               <%
                  }
                  %>
               <li class="nav-item">
                  <a href="Logout"><button>SIGN OUT</button></a>
               </li>
            </ul>
         </div>
      </nav>
      <% ArrayList<Employee> employeeList = (ArrayList) request.getAttribute("EMPLOYEE_LIST");
         String type3=String.valueOf(request.getAttribute("Type"));
         String Category=DbUtil.getCategoryName(name);
         %>
      <center>
         <h4 style="padding-top: 15px;padding-bottom: 15px;">LIST EMPLOYEES</h4>
      </center>
      <table id="list">
         <tr>
            <th>Employee ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Address</th>
            <th>Gender</th>
            <th>Mail</th>
            <th>Phone Number</th>
            <th>Department</th>
            <th>Category</th>
            <%if(!Category.equals("User")) {%>
            <th colspan="2">Actions</th>
            <%} %>
         </tr>
         <%
            if(request.getAttribute("EMPLOYEE_LIST") != null)
            {
            	Iterator<Employee> iterator = employeeList.iterator();  
            	while(iterator.hasNext())  
            	{
            		Employee empDetails = iterator.next();
            		int id=empDetails.getId();
            		
            	//String empCategory="user";
            		if(id>0){
            			String empCategory=DbUtil.getCategoryName(empDetails.getMail());
            		%>
         <tr>
            <td><%=empDetails.getId()%></td>
            <td><%=empDetails.getName()%></td>
            <td><%=empDetails.getAge()%></td>
            <td><%=empDetails.getAddress()%></td>
            <td><%=empDetails.getGender()%></td>
            <td><%=empDetails.getMail()%></td>
            <td><%=empDetails.getMobileNum()%></td>
            <td><%=empDetails.getDep()%></td>
            <td><%=empCategory%></td>
            <%if(((Category.equals("admin"))||((Category.equals("Technician")))&&empCategory.equals("User"))){
               %>
            <td>
               <form action="update.jsp"><input type="hidden" name="id" value="<%=id%>"/><input type="submit" name="command" value="UPDATE"/></form>
            </td>
            <td>
               <form action="EmployeeController"><input type="hidden" name="id" value="<%=id%>"/><input id="del" type="submit" onclick="if (!(confirm('Are you sure you want to delete this employee?'))) return false" name="command" value="DELETE"/></form>
            </td>
            <%}else if((Category.equals("Technician"))){ %>
            <td colspan="2">Technician can do actions only on user  </td>
         </tr>
         <%
            }}}}
            %>
      </table>
      <%} %>
      <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
   </body>
</html>