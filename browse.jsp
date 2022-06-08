<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Browsing Page</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
			java.sql.Time time = new java.sql.Time(Calendar.getInstance().getTime().getTime());
	        String s="SELECT * FROM Auction WHERE DATE(end_date)<='"+date+"' and TIME(end_time)<= '"+time+"'";

			String str = "";
			//Get the combobox from the index.jsp
			if (request.getParameter("sortBy") != null) {
				String entity = request.getParameter("sortBy");
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				if (entity.equals("bidding_price")) {
					str = "SELECT * FROM clothing c, auction a WHERE c.clothing_id = a.clothing_id ORDER BY " + entity;
				}
				else {
					str = "SELECT * FROM clothing c, auction a WHERE c.clothing_id = a.clothing_id ORDER BY " + entity;
				}
				
			}
			else if (request.getParameter("searchBy") != null) {
				String entity = request.getParameter("searchBy");
				String type = request.getParameter("search");
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				if (entity.equals("style") || entity.equals("brand")|| entity.equals("clothing_type")|| entity.equals("color")|| entity.equals("manufacture_date")) {
					str = "SELECT * FROM clothing c WHERE c.";
				}
				else if (entity.equals("shirt_size")|| entity.equals("sleeve_length")|| entity.equals("neckline")) {
					str = "SELECT * FROM shirts s WHERE s.";
				}
				else if (entity.equals("pants_size")|| entity.equals("pants_fit")) {
					str = "SELECT * FROM pants p WHERE p.";
				}
				else {
					str = "SELECT * FROM shoes h WHERE h.";
				}
				str = str + entity + " = " + "'" + type + "'";
			}
			else if (request.getParameter("param") != null) {
				str = "SELECT * FROM clothing c WHERE c.clothing_type in (SELECT clothing_type FROM clothing WHERE clothing_id = '" + request.getParameter("param") + "') AND c.color in (SELECT color FROM clothing WHERE clothing_id = '" + request.getParameter("param") + "') AND c.style in (SELECT style FROM clothing WHERE clothing_id = '" + request.getParameter("param") + "')";
			}
			else {
				/* String str = "SELECT * FROM clothing c, auction a WHERE c.clothing_id = a.clothing_id AND a.end_date"; */
				str = "SELECT * FROM clothing c, auction a WHERE c.clothing_id = a.clothing_id";
			}
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
		%>	
		<!--  Make an HTML table to show the results in: -->
		Sort By: 
		<form method="get" action="browse.jsp">
			<select name="sortBy" size=1>
				<option value="style">style</option>
				<option value="brand">brand</option>
				<option value="clothing_type">clothing type</option>
				<option value="color">color</option>
				<option value="manufacture_date">manufacture date</option>
				<option value="bidding_price">bidding price</option>
			</select>&nbsp;<br> <input type="submit" value="submit">
		</form>
		<br>
		Search By: 
		<form method="get" action="browse.jsp">
			<select name="searchBy" size=1>
				<option value="style">style</option>
				<option value="brand">brand</option>
				<option value="clothing_type">clothing type</option>
				<option value="color">color</option>
				<option value="manufacture_date">manufacture date</option>
				<option value="shirt_size">shirt size</option>
				<option value="sleeve_length">shirt sleeve length</option>
				<option value="neckline">shirt neckline</option>
				<option value="pants_size">pants size</option>
				<option value="pants_fit">pants fit</option>
				<option value="shoe_size">shoe size</option>
				<option value="material">shoe material</option>
				<option value="width">shirt width</option>
			</select>&nbsp;<br> Search<input type="text" name="search"><input type="submit" value="go">
		</form>
		Can't find what you're looking for? Set an <a href="${pageContext.request.contextPath}/itemInterestedType.jsp" >alert</a> for when the item becomes available.
		<br>
		<br>
		<table>
			<%
	        out.print("<tr>");
	        out.print("<td>");
	        out.print("Clothing ID");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("Brand");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("Color");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("StyleD");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("Clothing Type");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("Manufacture Date");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("End Date");
	        out.print("</td>");
	        out.print("<td>");
	        out.print("End Time");
	        out.print("</td>");
	        out.print("</tr>");
	        
	        
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><a href="${pageContext.request.contextPath}/auction.jsp?param=<%= result.getString("clothing_id") %>" ><%= result.getString("clothing_id") %></a></td>
					<td><%= result.getString("brand") %></td>
					<td><%= result.getString("color") %></td>
					<td><%= result.getString("style") %></td>
					<td><%= result.getString("clothing_type") %></td>
					<td><%= result.getString("manufacture_date") %></td>
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
