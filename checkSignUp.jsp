<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String error = "";
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the index.jsp
		String newFirstName = request.getParameter("firstName");
		String newLastName = request.getParameter("lastName");
		String newEmail = request.getParameter("email");
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");	
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO users(firstName, lastName, email, username, password, accType)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		
		if (newFirstName.equals("")){
			error = "Input a first name";
			ps.setString(1, null);
		}
		else if (newLastName.equals("")){
			error = "Input a last name";
			ps.setString(2, null);
		}
		else if (newEmail.equals("")){
			error = "Input an email";
			ps.setString(3, null);
		}
		else if (newUsername.equals("")){
			error = "Input a username";
			ps.setString(4, null);
		}
		else if(newPassword.equals("")){
			error = "Input a password";
			ps.setString(5, null);
		}
		else{
			ps.setString(1, newFirstName);
			ps.setString(2, newLastName);
			ps.setString(3, newEmail);
			ps.setString(4, newUsername);
			ps.setString(5, newPassword);
		}
		
		ps.setString(6, "endUser");
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		session.setAttribute("username", newUsername);
		session.setAttribute("firstName", newFirstName);
		session.setAttribute("lastName", newLastName);
		session.setAttribute("email", newEmail);
		session.setAttribute("accType", "endUser");
		
		String redirectURL = "homePage.jsp";
        response.sendRedirect(redirectURL);
		
	} catch (Exception ex) {
		//out.print(ex);
		if(error.equals("")){
			error="Username Taken";
		}
		out.print(error);
	}
%>
</body>
</html>