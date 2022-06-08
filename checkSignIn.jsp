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
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the index.jsp
		String uname = request.getParameter("username");
		String pword = request.getParameter("password");
		
		//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		String str = "SELECT * FROM users WHERE username = '" + uname + "' and password = '" + pword + "'";
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		result.next();
		String fname=result.getString("firstName");
		
		//HttpSession session = request.getSession();
		session.setAttribute("username", uname);
		session.setAttribute("firstName", fname);
		session.setAttribute("lastName", result.getString("lastName"));
		session.setAttribute("email", result.getString("email"));
		session.setAttribute("accType", result.getString("accType"));
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
	
		out.print("Login Successful");
		out.print("<br/>");
		out.print("Welcome, " + fname);
		String redirectURL = "homePage.jsp";
        response.sendRedirect(redirectURL);
		
		
		
	} catch (Exception ex) {
		//out.print(ex);
		out.print("Login failed");
	}
%>
</body>
</html>