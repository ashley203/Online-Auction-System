<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Show Bids</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM bid_on_auction" ;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
			<tr>    
				<td>Bid id</td>
				<td>Clothing Id</td>
			</tr>
			<%
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("bid_id") %></td>
					<td><%= result.getString("clothing_id") %></td>
				</tr>
				

			<% }%>
		</table>
		<br>
		<br>
			<%String str2 = "SELECT * FROM buyer_makes_bid" ;
			//Run the query against the database.
			ResultSet result2 = stmt.executeQuery(str2);%>
			
			<table>
			<tr>    
				<td>Bid id</td>
				<td>Username</td>
			</tr>
			<%
			while (result2.next()) { %>
				<tr>    
					<td><%= result2.getString("bid_id") %></td>
					<td><%= result2.getString("username") %></td>
				</tr>
			<% }%>
			</table>
			<br>
			<br>
			
			<%String str3 = "SELECT * FROM bid" ;
			//Run the query against the database.
			ResultSet result3 = stmt.executeQuery(str3);%>
			
			<table>
			<tr>    
				<td>Bid id</td>
				<td>Bid Amount</td>
				<td>Automatic</td>
				<td>Upper lim</td>
				<td>Bid Increment</td>
			</tr>
			<%
			while (result3.next()) { %>
				<tr>    
					<td><%= result3.getString("bid_id") %></td>
					<td><%= result3.getString("bidding_price") %></td>				
					<td><%= result3.getString("is_automatic") %></td>					
					<td><%= result3.getString("upper_limit") %></td>
					<td><%= result3.getString("bid_increment") %></td>	
				</tr>
			<% }%>
			</table>
			
			<br>
			<br>
			
			
			<%db.closeConnection(con);%>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>