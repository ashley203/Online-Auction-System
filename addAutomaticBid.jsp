<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Automatic Bid</title>
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
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		Statement stmt4 = con.createStatement();
		Statement stmt5 = con.createStatement();
		Statement stmt6 = con.createStatement();
		Statement stmt7 = con.createStatement();
		Statement stmt8 = con.createStatement();
		Statement stmt9 = con.createStatement();
		Statement stmt10 = con.createStatement();
		Statement stmt11 = con.createStatement();
		
		Statement stmt1a = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String clothing_id = request.getParameter("clothing_id");
		String seller_increment = request.getParameter("seller_increment");
		String bid_increment = request.getParameter("bidIncrement");
		String upper_limit = request.getParameter("upperLimit");
		String bidding_price = request.getParameter("biddingPrice");
		String username = session.getAttribute("username").toString();
		
		String str = "SELECT username FROM seller_sets_auction WHERE clothing_id = " + clothing_id;
		ResultSet result = stmt.executeQuery(str);
		result.first();
		String seller_username = result.getString("username");
		if(seller_username.equals(username)){
			error = "You cannot bid on your own auction";
			out.println(error);
			%> 
			<br>
			<a href="automaticBid.jsp">Back</a>
			<%
			return;
		}

		//Make insert statements for tables:
		String insert = "INSERT INTO bid(bidding_price, is_automatic, upper_limit, bid_increment)" + "VALUES (?, ?, ?, ?)";
		String insert2 = "INSERT INTO buyer_makes_bid(username, bid_id)" + "VALUES (?, ?)";
		String insert3 = "INSERT INTO bid_on_auction(bid_id, clothing_id)" + "VALUES (?, ?)";

		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		PreparedStatement ps2 = con.prepareStatement(insert2);
		PreparedStatement ps3 = con.prepareStatement(insert3);
		
		// First, determine the previous bid price value. The tuples of all the previous bids on this auction are in this table.
		String str1 = "SELECT DISTINCT b.bid_id, boa.clothing_id, b.bidding_price, b.is_automatic, b.upper_limit, b.bid_increment FROM bid_on_auction boa, bid b WHERE boa.bid_id = b.bid_id AND boa.clothing_id = " + clothing_id;

		// Run the query against the database.
		ResultSet result1 = stmt1.executeQuery(str1);

		// returns the initial price of this auction
		String str2 = "SELECT init_price FROM auction a WHERE a.clothing_id = " + clothing_id;
		ResultSet result2 = stmt2.executeQuery(str2);
		result2.next();
		String initialAuctionPrice = result2.getString("init_price");
		

		if (!bidding_price.equals("") && !upper_limit.equals("") && !bid_increment.equals("")) {
			
			// if new_bidding_price is higher than the upper_limit, there should be an error
			if (Double.parseDouble(bidding_price) > Double.parseDouble(upper_limit)) {
				error = "Your bid price cannot be greater than your upper limit";
				out.println(error);
				%> 
				<br>
				<a href="automaticBid.jsp">Back</a>
				<%
			}
			else if(Double.parseDouble(bid_increment) < Double.parseDouble(seller_increment)){
				error = "Your increment value cannot be less than the seller's set lowest increment value";
				out.println(error);
				%> 
				<br>
				<a href="automaticBid.jsp">Back</a>
				<%
			}
			else if (result1.next()) {
			// table exists for this clothing_id
			// search the bids and find the previous, aka highest, bid price.
			// if new_bidding_price is lower than this price, there should be an error
					
				String previous_bidding_price;
					
				if(result1.next()){
					
					String str3 = "SELECT max(bidding_price) AS maxBiddingPrice2 FROM " + result1;
					//String str3 = "SELECT bidding_price FROM " + result1 + "WHERE bidding_price = max(bidding_price)";
					ResultSet result3 = stmt3.executeQuery(str3);
					result3.next();
					previous_bidding_price = result3.getString("maxBiddingPrice2");
					//String previous_bidding_price = result3.getString("bidding_price");
					
					result3.close();
					
				}
				else{
					
					String str3 = "SELECT r.bidding_price AS maxBiddingPrice2 FROM " + result1;
					//String str3 = "SELECT bidding_price FROM " + result1 + "WHERE bidding_price = max(bidding_price)";
					ResultSet result3 = stmt3.executeQuery(str3);
					result3.next();
					previous_bidding_price = result3.getString("maxBiddingPrice");
					
				}
				

				if (Double.parseDouble(bidding_price) < Double.parseDouble(previous_bidding_price) + Double.parseDouble(seller_increment)) {
					error = "Your bid price must not be less than the previous bid price, " + previous_bidding_price + " plus the seller's set lowest increment, " + seller_increment;
					out.println(error);
					%> 
					<br>
					<a href="automaticBid.jsp">Back</a>
					<%
				}
				else if(Double.parseDouble(upper_limit) < Double.parseDouble(previous_bidding_price) + Double.parseDouble(seller_increment)){
					error = "Your upper limit must not be less than the previous bid price, " + previous_bidding_price + " plus the seller's set lowest increment, " + seller_increment;
					out.println(error);
					%> 
					<br>
					<a href="automaticBid.jsp">Back</a>
					<%
				}
				else{
					// new_bidding_price is valid
				}
			
			} else {
			// table does not exist for this clothing_id --> in other words, no bids have yet been placed for this auction
			// search and find the init_price for this auction, and the new_bidding_price must be at least init_price + buyer_increment 
					
				if (Double.parseDouble(bidding_price) < (Double.parseDouble(initialAuctionPrice) + Double.parseDouble(seller_increment))) {
					error = "Your bidding price must be greater than or equal to the initial auction price value + the seller's set lowest increment value";
					out.println(error);
					%> 
					<br>
					<a href="automaticBid.jsp">Back</a>
					<%
				}
				else if(Double.parseDouble(upper_limit) < Double.parseDouble(initialAuctionPrice) + Double.parseDouble(seller_increment)){
					error = "Your upper limit must not be less than the initial auction price, " + initialAuctionPrice + " plus the seller's set lowest increment, " + seller_increment;
					out.println(error);
					%> 
					<br>
					<a href="automaticBid.jsp">Back</a>
					<%
				}
				else{
					// new_bidding_price is valid
				}
			}
		}

		if (bid_increment.equals("")) {
			error = "Please enter a bid increment value";
			out.println(error);
			%> 
			<br>
			<a href="automaticBid.jsp">Back</a>
			<%
		} else if (upper_limit.equals("")) {
			error = "Please enter an upper limit value";
			out.println(error);
			%> 
			<br>
			<a href="automaticBid.jsp">Back</a>
			<%
		} else if (bidding_price.equals("")) {
			error = "Please enter a bid price";
			out.println(error);
			%> 
			<br>
			<a href="automaticBid.jsp">Back</a>
			<%
		} else{
			ps.setString(1, bidding_price);
			ps.setString(2, "true");
			ps.setString(3, upper_limit);
			ps.setString(4, bid_increment);

			ps.executeUpdate();
			String str4 = "SELECT max(bid_id) AS maxBidId FROM bid";
			ResultSet result4 = stmt4.executeQuery(str4);
			result4.next();
			String bid_id = result4.getString("maxBidId");

			ps2.setString(1, username);
			ps2.setString(2, bid_id);

			ps2.executeUpdate();

			ps3.setString(1, bid_id);
			ps3.setString(2, clothing_id);
			ps3.executeUpdate();
			
			result.close();
			result2.close();
			result4.close();
			
			
		String redirectURL = "bidSuccessful.jsp";
		response.sendRedirect(redirectURL);
	}
		// Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();


	} catch (Exception ex) {
		out.print(ex);
		if (error.equals("")) {
			error = "Something went wrong, make sure you've typed everything correctly";
		}
		out.print(error);
	%>
	<br>
	<a href="automaticBid.jsp">Back</a>
	<%
		}
	%>
	<br>

</body>
</html>
