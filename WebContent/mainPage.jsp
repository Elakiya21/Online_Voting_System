<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@page import="com.employee.DbUtil"%>
<%@page import="com.employee.Employee"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>Welcome Page</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <link rel="stylesheet" type="text/css" href="style.css">
   </head>
   <%
      response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
      %>
   <body style="background: #649173;
   background: -webkit-linear-gradient(to right, #DBD5A4, #649173); 
   background: linear-gradient(to right, #DBD5A4, #649173); ">
      <%
         if(session.getAttribute("username")==null)
         {
         	RequestDispatcher rd=request.getRequestDispatcher("Login.jsp");
         	rd.forward(request, response);
         }else{
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
               		String name=String.valueOf(session.getAttribute("username"));
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
         <div style="padding-top:250px">
            <h3>
               <%if(request.getAttribute("success")!=null)
                  out.println(request.getAttribute("success"));else{ %>
               Welcome to Employee Management System<%} %>
            </h3>
         </div>
      </center>
      <%} %>
   </body>
   <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</html>