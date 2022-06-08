<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Check Alerts</title>
	</head>
	<body>
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
				Statement stmt2 = con.createStatement();
				
				java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
				java.sql.Time time = new java.sql.Time(Calendar.getInstance().getTime().getTime());
				
				
				String s1="SELECT *, MAX(b.bidding_price) as max FROM Auction a, bid_on_auction o, bid b, buyer_makes_bid m WHERE b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id=a.clothing_id and DATE(a.end_date)<='"+date+"' and TIME(a.end_time)<= '"+time+"' GROUP BY a.clothing_id";	
				ResultSet i=stmt.executeQuery(s1);
				while(i.next()){
					if(i.getString("username").equals(username) && Double.parseDouble(i.getString("max"))>=Double.parseDouble(i.getString("min_price"))){
						String s2="SELECT count(*) as c FROM set_alerts_for WHERE username='"+username+"'and clothing_id='"+i.getString("clothing_id")+"' and notification='won_auction'";
						ResultSet rs1=stmt2.executeQuery(s2);
						rs1.next();
						if(!(Integer.parseInt(rs1.getString("c"))>0)){
							PreparedStatement ps1 = con.prepareStatement("INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)");
							ps1.setString(1, username);
							ps1.setString(2, i.getString("clothing_id"));
							ps1.setString(3, "won_auction");
							ps1.setString(4, "false");
							ps1.executeUpdate();
						}
					}
				}
				db.closeConnection(con);
				
	        	response.sendRedirect("alerts.jsp");
        
			} catch (Exception e) {
				out.print(e);
			}%>
			
		<% } %>

	</body>
</html>