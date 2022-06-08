<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create Shoes Auction</title>
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
		String shoeSize = request.getParameter("shoeSize");
		String width = request.getParameter("width");
		String material = request.getParameter("material");
		String brand = request.getParameter("brand");
		String color = request.getParameter("color");
		String style = request.getParameter("style");
		String manufactureDate = request.getParameter("manufactureDate");
		String username = session.getAttribute("username").toString();
		
		//Make insert statements for tables:
		String insert = "INSERT INTO interested_item(username, style, brand, clothing_type, color, manufacture_date, shoe_size, material, width, pants_size, pants_fit, shirt_size, sleeve_length, neckline)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

				
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);


		ps.setString(1, username);
		if (style.equals("")) {
			style = null;
		}
		ps.setString(2, style);
		if (brand.equals("")) {
			brand = null;
		}
		ps.setString(3, brand);
		ps.setString(4, "shoes");
		if (color.equals("")) {
			color = null;
		}
		ps.setString(5, color);
		if (manufactureDate.equals("")) {
			manufactureDate = null;
		}
		ps.setString(6, manufactureDate);
		if (shoeSize.equals("")) {
			shoeSize = null;
		}
		ps.setString(7, shoeSize);
		if (material.equals("")) {
			material = null;
		}
		ps.setString(8, material);
		if (width.equals("")) {
			width = null;
		}
		ps.setString(9, width);
		ps.setString(10, null);
		ps.setString(11, null);
		ps.setString(12, null);
		ps.setString(13, null);
		ps.setString(14, null);
				
	
		
		ps.executeUpdate();

		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		
		String redirectURL = "itemInterestedSuccess.jsp";
        response.sendRedirect(redirectURL);
		
	} catch (Exception ex) {
		out.print(ex);
		/* if(error.equals("")){
			error="Something went wrong, make sure you've typed everything correctly";
		}
		out.print(error); */
		%> <br> <a href="chooseAuctionType.jsp">Back</a><%
	}
%>	<br>

	</body>
</html>