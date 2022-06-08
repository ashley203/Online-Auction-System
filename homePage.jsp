<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home</title>
	</head>
	<body>
		Home
		<br>
		<%
	    if ((session.getAttribute("username") == null)) {
		%>
			You are not logged in
			<br/>
			<a href="HelloWorld.jsp">Login here</a>
		<%} else {%>
			<%String username = session.getAttribute("username").toString(); %>
			<%String firstName = session.getAttribute("firstName").toString(); %>
			<%String lastName = session.getAttribute("lastName").toString(); %>
			Hello, <%=firstName%> <%=lastName%>
			<br>
			<br>
			<%
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM buyer_makes_bid b, bid_on_auction a WHERE b.username = '" + username + "' AND b.bid_id = a.bid_id";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			out.print("You bid on auctions: ");
			//Make an HTML table to show the results in:
			out.print("<table>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("clothing_id"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");
			out.print("Your Created Auctions:");
			//Create a SQL statement
			Statement stmt2 = con.createStatement();
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str2 = "SELECT * FROM seller_sets_auction WHERE username = '" + username + "'";
			//Run the query against the database.
			ResultSet result2 = stmt2.executeQuery(str2);
			out.print("<table>");

			//parse out the results
			while (result2.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result2.getString("clothing_id"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");
			%>
			<br>
			<br>
			<%
			out.print("You set alerts for: ");
			//Create a SQL statement
			Statement stmt3 = con.createStatement();
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str3 = "SELECT * FROM interested_item i WHERE username = '" + username + "'";
			//Run the query against the database.
			ResultSet result3 = stmt3.executeQuery(str3);
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("item id");
			out.print("</td>");
			out.print("<td>");
			out.print("style");
			out.print("</td>");
			out.print("<td>");
			out.print("brand");
			out.print("</td>");
			out.print("<td>");
			out.print("clothing type");
			out.print("</td>");
			out.print("<td>");
			out.print("color");
			out.print("</td>");
			out.print("<td>");
			out.print("manufacture date");
			out.print("</td>");
			out.print("<td>");
			out.print("shoe size");
			out.print("</td>");
			out.print("<td>");
			out.print("material");
			out.print("</td>");
			out.print("<td>");
			out.print("width");
			out.print("</td>");
			out.print("<td>");
			out.print("pants size");
			out.print("</td>");
			out.print("<td>");
			out.print("pants fit");
			out.print("</td>");
			out.print("<td>");
			out.print("shirt size");
			out.print("</td>");
			out.print("<td>");
			out.print("sleeve length");
			out.print("</td>");
			out.print("<td>");
			out.print("neckline");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result3.next()) {
				
				//make a row
				out.print("<tr>");
				out.print("<td>");
				out.print(result3.getString("item_id"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("style"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("brand"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("clothing_type"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("color"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("manufacture_date"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("shoe_size"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("material"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("width"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("pants_size"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("pants_fit"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("shirt_size"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("sleeve_length"));
				out.print("</td>");
				out.print("<td>");
				out.print(result3.getString("neckline"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");
			
			//close the connection.
			con.close();
			%>		
			<br>
			<br>
			<form action="checkAlerts.jsp" method="post" >
					<input type="submit" value="Alerts">
			</form>
			<br>
			<br>
			<form action="chooseAuctionType.jsp" method="post" >
					<input type="submit" value="Create Auction">
			</form>
			
			<br>
			<br>
			
			<form action="displayAllAuctions.jsp" method="post" >
					<input type="submit" value="View Current Auctions">
			</form>
			
			<br>
			<br>
			<form action="browse.jsp" method="post" >
					<input type="submit" value="Browse Clothes">
			</form>
			<br>
			<br>
			<form action="logout.jsp" method="post" >
					<input type="submit" value="Logout">
			</form>
			
			
		<% } %>

	</body>
</html>
