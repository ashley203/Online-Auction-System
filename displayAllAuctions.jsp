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
	
	<br>
	Shirts:
	<br>
	<br>
			<%
			//parse out the results
			while (result.next()) {%>
				
				<div style = "border: 1px solid black">
				<% out.println("Type: ");%>
				<%= result.getString("clothing_type")%>
				<br>
				<% out.println("Item: ");%>
				<%= result.getString("color") %>
				<%= result.getString("brand") %>
				<%= result.getString("style") %>
				<br>
				<% out.println("Size: ");%>
				<%= result.getString("shirt_size") %>
				<br>
				<% out.println("ID: ");%>
				<%= result.getString("clothing_id") %>
				<br>
				<% out.println("Initial price: ");%>
				<%= result.getString("init_price") %>
				<br>
				<% out.println("Auction ends date: ");%>
				<%= result.getString("end_date")%>
				<br>
				<% out.println("Auction end time: ");%>
				<%= result.getString("end_time") %>
					
				<form action="manualBid.jsp" method="post" >
					<input type = "hidden" name = "clothing_id" value = <%= result.getString("clothing_id") %>>
					<input type="submit" value= "Manual Bid">
			    </form>
			    
			    <form action="automaticBid.jsp" method="post" >
					<input type = "hidden" name = "clothing_id" value = <%= result.getString("clothing_id") %>>
					<input type="submit" value= "Automatic Bid">
			    </form>
			    
			    </div>
			    <br>
			<%
			}
			//close the connection.
			db.closeConnection(con);
			%>

			
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
	<br>
			<%
			//parse out the results
			while (result.next()) {%>
				
				<div style = "border: 1px solid black">
				<% out.println("Type: ");%>
				<%= result.getString("clothing_type")%>
				<br>
				<% out.println("Item: ");%>
				<%= result.getString("color") %>
				<%= result.getString("brand") %>
				<%= result.getString("style") %>
				<br>
				<% out.println("Size: ");%>
				<%= result.getString("pants_size") %>
				<br>
				<% out.println("ID: ");%>
				<%= result.getString("clothing_id") %>
				<br>
				<% out.println("Initial price: ");%>
				<%= result.getString("init_price") %>
				<br>
				<% out.println("Auction ends date: ");%>
				<%= result.getString("end_date")%>
				<br>
				<% out.println("Auction end time: ");%>
				<%= result.getString("end_time") %>
					
				<form action="manualBid.jsp" method="post" >
					<input type = "hidden" name = "clothing_id" value = <%= result.getString("clothing_id") %>>
					<input type="submit" value= "Manual Bid">
			    </form>
			    
			    <form action="automaticBid.jsp" method="post" >
					<input type = "hidden" name = "clothing_id" value = <%= result.getString("clothing_id") %>>
					<input type="submit" value= "Automatic Bid">
			    </form>
			    
			    </div>
			    <br>
			<%
			}
			//close the connection.
			db.closeConnection(con);
			%>

			
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
	<br>
		<%
			//parse out the results
			while (result.next()) {%>
				
				<div style = "border: 1px solid black">
				<% out.println("Type: ");%>
				<%= result.getString("clothing_type")%>
				<br>
				<% out.println("Item: ");%>
				<%= result.getString("color") %>
				<%= result.getString("brand") %>
				<%= result.getString("style") %>
				<br>
				<% out.println("Size: ");%>
				<%= result.getString("shoe_size") %>
				<br>
				<% out.println("ID: ");%>
				<%= result.getString("clothing_id") %>
				<br>
				<% out.println("Initial price: ");%>
				<%= result.getString("init_price") %>
				<br>
				<% out.println("Auction ends date: ");%>
				<%= result.getString("end_date")%>
				<br>
				<% out.println("Auction end time: ");%>
				<%= result.getString("end_time") %>
					
				<form action="manualBid.jsp" method="post" >
					<input type = "hidden" name = "clothing_id" value = <%= result.getString("clothing_id") %>>
					<input type="submit" value= "Manual Bid">
			    </form>
			    
			    <form action="automaticBid.jsp" method="post" >
					<input type = "hidden" name = "clothing_id" value = <%= result.getString("clothing_id") %>>
					<input type="submit" value= "Automatic Bid">
			    </form>
			    
			    </div>
			    <br>
			<%
			}
			//close the connection.
			db.closeConnection(con);
			%>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
	
	</body>
</html>