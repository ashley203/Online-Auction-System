<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Alerts</title>
	</head>
	<body>
		Alerts
		<br>
		<%
	    if ((session.getAttribute("username") == null)) {
		%>
			You are not logged in
			<br/>
			<a href="HelloWorld.jsp">Login here</a>
		<%} else {%>
			<%String username = session.getAttribute("username").toString(); %>
			<br>
			<% try {     
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
			java.sql.Time time = new java.sql.Time(Calendar.getInstance().getTime().getTime());
	        String s="SELECT * FROM Auction WHERE DATE(end_date)<='"+date+"' and TIME(end_time)<= '"+time+"'";
	        ResultSet rs=stmt.executeQuery(s);
	        
			
			String str = "SELECT * FROM set_alerts_for a, clothing c where '"+username+"' = username and a.clothing_id=c.clothing_id" ;
			ResultSet result = stmt.executeQuery(str);
			%>
			
			<table>
				<tr>    
					<td>Clothing ID</td>
					<td>Item</td>
					<td>Notifications</td>
					<td>Viewed<td>
				</tr>
			<%
			//parse out the results
			while (result.next()) { %>
			<% if ((result.getString("seen")).equals("false")){%>
				<tr>    
					<td><%= result.getString("clothing_id") %></td>
					<td><%= result.getString("color") %> <%= result.getString("brand") %> <%= result.getString("clothing_type") %></td>
					<%if (result.getString("notification").equals("higher_bid")){
						%><td>A higher bid was placed for this item. </td><%
					}
					else if(result.getString("notification").equals("upper_limit")){
						%><td>Your upper limit was reached for this item. </td><%
					}
					else if(result.getString("notification").equals("won_auction")){
						%><td>You won this auction! </td><%
					}
					else{
						%><td>This item is available. </td><%
					}%>
					
					<td><%= result.getString("seen") %></td>
				</tr>
			<%
				}
			}
			result = stmt.executeQuery(str);
			//parse out the results
			while (result.next()) { %>
			<% if ((result.getString("seen")).equals("true")){%>
				<tr>    
					<td><%= result.getString("clothing_id") %></td>
					<td><%= result.getString("color") %> <%= result.getString("brand") %> <%= result.getString("clothing_type") %></td>
					<%if (result.getString("notification").equals("higher_bid")){
						%><td>A higher bid was placed for this item. </td><%
					}
					else if(result.getString("notification").equals("upper_limit")){
						%><td>Your upper limit was reached for this item. </td><%
					}
					else if(result.getString("notification").equals("won_auction")){
						%><td>You won this auction! </td><%
					}
					else{
						%><td>This item is available. </td><%
					}%>
					<td><%= result.getString("seen") %></td>
				</tr>
				
			<%	}
			}
			result = stmt.executeQuery(str);
			while (result.next()) { %>
			<% if ((result.getString("seen")).equals("false")){
			 	PreparedStatement updateSeen=con.prepareStatement("UPDATE set_alerts_for SET seen='true' WHERE username LIKE? and clothing_id=?");
				updateSeen.setString(1,username); 
				updateSeen.setString(2,result.getString("clothing_id")); 
				updateSeen.executeUpdate(); 
				}
			}
			
			//close the connection.
			db.closeConnection(con);
			%>
			</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>			
			<br/>
			<a href="homePage.jsp">Back</a>
			
		<% } %>

	</body>
</html>