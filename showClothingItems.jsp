<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Clothing List</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM shirts s, clothing c, auction a WHERE s.clothing_id = c.clothing_id AND s.clothing_id = a.clothing_id" ;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border = "1" cellpadding = "5">
	
	<br>
	Shirts:
	<br>
		<tr>    
			<td>Clothing_ID</td>
			<td>Shirt_Size</td>
			<td>Sleeve_Length</td>
			<td>Neckline</td>
			<td>Style</td>
			<td>Brand</td>
			<td>Clothing_Type</td>
			<td>Color</td>
			<td>Manufacture_Date</td>
			<td>End_Date</td>
			<td>End_Time</td>
			<td>Min_Price</td>
			<td>Init_Price</td>
			<td>Increment</td>
			
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("clothing_id") %></td>
					<td><%= result.getString("shirt_size") %></td>
					<td><%= result.getString("sleeve_length") %></td>
					<td><%= result.getString("neckline") %></td>
					<td><%= result.getString("style") %></td>
					<td><%= result.getString("brand") %></td>
					<td><%= result.getString("clothing_type") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("manufacture_date") %></td>
					<td><%= result.getString("end_date") %></td>
					<td><%= result.getString("end_time") %></td>
					<td><%= result.getString("min_price") %></td>
					<td><%= result.getString("init_price") %></td>
					<td><%= result.getString("increment") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM pants p, clothing c, auction a WHERE p.clothing_id = c.clothing_id AND p.clothing_id = a.clothing_id";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border = "1" cellpadding = "5">
	<br>
	Pants:
	<br>
		<tr>    
			<td>Clothing_ID</td>
			<td>Pants_Size</td>
			<td>Pants_Fit</td>
			<td>Style</td>
			<td>Brand</td>
			<td>Clothing_Type</td>
			<td>Color</td>
			<td>Manufacture_Date</td>
			<td>End_Date</td>
			<td>End_Time</td>
			<td>Min_Price</td>
			<td>Init_Price</td>
			<td>Increment</td>
			
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("clothing_id") %></td>
					<td><%= result.getString("pants_size") %></td>
					<td><%= result.getString("pants_fit") %></td>
					<td><%= result.getString("style") %></td>
					<td><%= result.getString("brand") %></td>
					<td><%= result.getString("clothing_type") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("manufacture_date") %></td>
					<td><%= result.getString("end_date") %></td>
					<td><%= result.getString("end_time") %></td>
					<td><%= result.getString("min_price") %></td>
					<td><%= result.getString("init_price") %></td>
					<td><%= result.getString("increment") %></td>
				</tr>

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM shoes s, clothing c, auction a WHERE s.clothing_id = c.clothing_id AND s.clothing_id = a.clothing_id";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border = "1" cellpadding = "5">
	<br>
	Shoes:
	<br>
		<tr>    
			<td>Clothing_ID</td>
			<td>Shoe_Size</td>
			<td>Material</td>
			<td>Width</td>
			<td>Style</td>
			<td>Brand</td>
			<td>Clothing_Type</td>
			<td>Color</td>
			<td>Manufacture_Date</td>
			<td>End_Date</td>
			<td>End_Time</td>
			<td>Min_Price</td>
			<td>Init_Price</td>
			<td>Increment</td>
			
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("clothing_id") %></td>
					<td><%= result.getString("shoe_size") %></td>
					<td><%= result.getString("material") %></td>
					<td><%= result.getString("width") %></td>
					<td><%= result.getString("style") %></td>
					<td><%= result.getString("brand") %></td>
					<td><%= result.getString("clothing_type") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("manufacture_date") %></td>
					<td><%= result.getString("end_date") %></td>
					<td><%= result.getString("end_time") %></td>
					<td><%= result.getString("min_price") %></td>
					<td><%= result.getString("init_price") %></td>
					<td><%= result.getString("increment") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
	
	</body>
</html>