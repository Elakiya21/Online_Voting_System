<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<%@page import="com.employee.Employee"%>
<%@page import="com.employee.DbUtil"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>Update My Profile</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
      <link rel="stylesheet" type="text/css" href="style.css">
      <style type="text/css">
         i {
         margin-left: -30px;
         cursor: pointer;
         }
      </style>
   </head>
   <%
      response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
      %>
   <%int id=Integer.parseInt(request.getParameter("id"));%>
   <%Employee e=DbUtil.getDetails(id);%>
   <body>
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
         <div class="add">
            <h4>UPDATE MY PROFILE</h4>
            <form action="EmployeeController" method="GET">
               <input type="hidden" name="command" value="UPDATEPROFILE" />
               <input type="hidden" name="id" value="<%=id %>" />
               <table>
                  <tbody>
                     <tr>
                        <td><label>Name:</label></td>
                        <td><input type="text" name="name" value="<%=e.getName()%>" minlength="2" required /></td>
                     </tr>
                     <tr>
                        <td><label>Age:</label></td>
                        <td><input type="number" name="age" value="<%=e.getAge()%>" required /></td>
                     </tr>
                     <tr>
                        <td><label>Address:</label></td>
                        <td><textarea  name="address" required><%=e.getAddress()%></textarea></td>
                     </tr>
                     <tr>
                        <td><label>Gender:</label></td>
                        <td><%=e.getGender()%>
                        </td>
                     </tr>
                     <tr>
                        <td><label>Mail:</label></td>
                        <td><%=e.getMail()%></td>
                     </tr>
                     <tr>
                        <td><label>Mobile Number:</label></td>
                        <td><input type="text" name="mobileNum" value="<%=e.getMobileNum()%>" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" /></td>
                     </tr>
                     <tr>
                        <td><label>Department:</label></td>
                        <td><%=e.getDep()%></td>
                     </tr>
                     <tr>
                        <td><label>Category:</label></td>
                        <td><%=DbUtil.getCategoryName(e.getMail())%>
                        </td>
                     </tr>
                     <tr>
                        <td><label>Password:</label></td>
                        <td><input type="password" name="password" id="password" value="<%=DbUtil.getCurrentPassword(id)%>" required/><i class="far fa-eye-slash" id="togglePassword"></i> 
                        </td>
                     </tr>
                     <tr>
                        <td><label></label></td>
                        <td><input type="submit" value="Save" class="save" /></td>
                     </tr>
                  </tbody>
               </table>
            </form>
         </div>
      </center>
      <%} %>
      <script>	
         const togglePassword = document.querySelector('#togglePassword');
         const password = document.querySelector('#password');
         togglePassword.addEventListener('click', function (e) {
          const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
           password.setAttribute('type', type);
          console.log(document.getElementById("togglePassword").className);
         if(document.getElementById("togglePassword").className == 'far fa-eye-slash'){
            this.classList.remove('fa-eye-slash');          
            this.classList.add('fa-eye');         
          }else{
            this.classList.remove('fa-eye');         
            this.classList.add('fa-eye-slash');  
          }
         });
      </script>
      <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
   </body>
</html>