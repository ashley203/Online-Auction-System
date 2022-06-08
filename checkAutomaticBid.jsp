<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Manual Bid</title>
</head>
<body>
	<%
		String clothing_id = request.getParameter("clothing_id");
		String bidding_price = request.getParameter("bidding_price");
		String upper_limit = request.getParameter("upper_limit");
		String bid_increment = request.getParameter("bid_increment");
		String error = "";
	 try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String insert1 = "INSERT INTO bid(bidding_price, is_automatic,upper_limit,bid_increment)" + "VALUES (?, ?,?,?)";
		String insert2 = "INSERT INTO buyer_makes_bid(username,bid_id)" + "VALUES (?, ?)";
		String insert3 = "INSERT INTO bid_on_auction(bid_id, clothing_id)" + "VALUES (?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert1);
		PreparedStatement ps2 = con.prepareStatement(insert2);
		PreparedStatement ps3 = con.prepareStatement(insert3);
		
		String s="SELECT increment FROM auction WHERE clothing_id='"+clothing_id+"'";
		ResultSet r = stmt.executeQuery(s);
		r.next();
		Double increment = Double.parseDouble(r.getString("increment"));
		double bidPriceInt=Double.parseDouble(bidding_price);
		double bidMinInt=Double.parseDouble(request.getParameter("bidMin"));
		if (bidding_price.equals("")|| bidPriceInt<=bidMinInt||increment>bidPriceInt-bidMinInt){
			error = "Input a valid bid amount";
			ps.setString(1, null);
		}
		else if(upper_limit.equals("")||Double.parseDouble(upper_limit)<=bidMinInt||Double.parseDouble(upper_limit)<=bidPriceInt){
			error = "Input a valid upper limit";
			ps.setString(3, null);
		}
		else if(bid_increment.equals("")||Double.parseDouble(bid_increment)<=0){
			error = "Input a valid bid increment";
			ps.setString(4, null);
		}
		else{		
			ps.setString(1, bidding_price);
			ps.setString(3, upper_limit);
			ps.setString(4, bid_increment);
		}
		ps.setString(2, "true");
		ps.executeUpdate();
		
		String str = "select max(b.bid_id) as max from bid b";
		ResultSet result = stmt.executeQuery(str);
		result.next();
		String bidId = result.getString("max");
		session.setAttribute("bidID", bidId);
		
		ps2.setString(1, session.getAttribute("username").toString());
		ps2.setString(2, bidId);
		
		ps2.executeUpdate();
		
		ps3.setString(1, bidId);
		ps3.setString(2, clothing_id);
		ps3.executeUpdate();
		con.close();
		
		session.setAttribute("clothing_id", clothing_id);
		session.setAttribute("last_bid_amount", bidding_price);
		response.sendRedirect("checkAllBids.jsp");
		
	} catch (Exception e) {
			if(error.equals("")){
				out.print("Something went wrong try again");
			}
			else{
				out.print(error);
			}
	}%>

</body>
</html>