<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@page import="com.employee.DbUtil"%>
<%@page import="java.util.ArrayList"%> 
<%@page import="com.employee.Employee"%>
<%@page import="com.employee.DbUtil"%>
<%@page import="java.util.Iterator"%> 
<%@page import="java.lang.*"%> 
<%@page import="com.employee.Employee"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>Sort Employees</title>
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
      <center>
         <h4 style="padding-top: 15px;">SORT EMPLOYEES</h4>
         <div class="sort" style="padding-top: 20px;">
            <form action="EmployeeController" method="GET">
               <div>
                  <input type="hidden" name="command" value="SORT" />
                  <input type="radio" id="id" name="attributes" value="id">
                  <label for="id">Employee ID</label>
                  <input type="radio" id="name" name="attributes" value="name">
                  <label for="name">Name</label>
                  <input type="radio" id="age" name="attributes" value="age">
                  <label for="age">Age</label>
                  <input type="radio" id="address" name="attributes" value="address">
                  <label for="address">Address</label>
                  <input type="radio" id="gender" name="attributes" value="gender">
                  <label for="gender">Gender</label>
                  <input type="radio" id="mail" name="attributes" value="mail">
                  <label for="mail">Mail</label>
                  <input type="radio" id="mobilenumber" name="attributes" value="mobilenumber">
                  <label for="mobilenumber">Mobile Number</label>
                  <input type="radio" id="department" name="attributes" value="department">
                  <label for="department">Department</label><br>
               </div>
               <div style="padding-bottom: 30px;padding-top: 20px;">
                  <input type="radio" id="ascending" name="type" value="asc">
                  <label for="ascending">Ascending</label>
                  <input type="radio" id="descending" name="type" value="desc">
                  <label for="descending">Descending</label><br>
                  <input  type="submit" value="Sort">
               </div>
            </form>
         </div>
      </center>
   </body>
   <% ArrayList<Employee> employeeList = (ArrayList) request.getAttribute("EMPLOYEE_LIST");
      %>
   <table id="list">
      <%
         if(request.getAttribute("EMPLOYEE_LIST") != null)
         {%>
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
      </tr>
      <%	Iterator<Employee> iterator = employeeList.iterator();  
         while(iterator.hasNext())  
         {
         	Employee empDetails = iterator.next();
         	int id=empDetails.getId();
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
      </tr>
      <%
         }}}
         %>
   </table>
   <%} %>
   <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>