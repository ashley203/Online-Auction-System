<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check All Bids</title>
</head>
<body>
	<%
		String username = session.getAttribute("username").toString();
		String clothing_id = session.getAttribute("clothing_id").toString();
		double last_bid = Double.parseDouble(session.getAttribute("last_bid_amount").toString());
		String lastBidId = session.getAttribute("bidID").toString();
		String error = "";
	 try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		Statement stmt4 = con.createStatement();
		
		String str = "select count(distinct m.username) as c from bid b, buyer_makes_bid m, bid_on_auction o where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"'and b.is_automatic='true'" ;
		ResultSet num = stmt.executeQuery(str);
		num.next();
		
		int numAutoBids = Integer.parseInt(num.getString("c"));
		//out.print(numAutoBids+" ");
		if (numAutoBids==1){
			str="select m.username user, b.bid_increment i, b.upper_limit u from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic='true'";
			ResultSet result = stmt.executeQuery(str);
			result.next();
			String autoBidder=result.getString("user").toString();
			
			if(!(username.equals(autoBidder))){	//if the one autoBidder isnt the last person who bid
				double inc=Double.parseDouble(result.getString("i"));
				double upperlim=Double.parseDouble(result.getString("u"));
				if (last_bid>=upperlim){
					//alert autobidder of upper limit reached
					//alert other manual buyers except the person who made last bid
					String str3="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic<>'true' and m.username<>'"+username+"'";
					ResultSet result2=stmt.executeQuery(str3);
					while(result2.next()){
						String insert2="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
						PreparedStatement ps2 = con.prepareStatement(insert2);
						ps2.setString(1, result.getString("user"));
						ps2.setString(2, clothing_id);
						ps2.setString(3, "higher_bid");
						ps2.setString(4, "false");
						ps2.executeUpdate();
					}
					PreparedStatement ps1 = con.prepareStatement("INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)");
					ps1.setString(1, autoBidder);
					ps1.setString(2, clothing_id);
					ps1.setString(3, "upper_limit");
					ps1.setString(4, "false");
					ps1.executeUpdate();
				}
				else{//automatic bidder wins, alert all manual buyers
					String newHighestBid;
					if(last_bid+inc>upperlim){	
						newHighestBid=Double.toString(upperlim);
					}
					else{
						newHighestBid=Double.toString(last_bid+inc);
					}
					PreparedStatement ps = con.prepareStatement("INSERT INTO bid(bidding_price, is_automatic,upper_limit,bid_increment)" + "VALUES (?, ?, ?, ?)");
					PreparedStatement ps2 = con.prepareStatement("INSERT INTO buyer_makes_bid(username,bid_id)" + "VALUES (?, ?)");
					PreparedStatement ps3 = con.prepareStatement("INSERT INTO bid_on_auction(bid_id, clothing_id)" + "VALUES (?, ?)");
					
					ps.setString(1, newHighestBid);
					ps.setString(2, "true");
					ps.setString(3, Double.toString(upperlim));
					ps.setString(4, Double.toString(inc));
					ps.executeUpdate();
					
					ResultSet result2 = stmt.executeQuery("select max(b.bid_id) as max from bid b");
					result2.next();
					String newHighestBidId = result2.getString("max");
					
					ps2.setString(1, autoBidder);
					ps2.setString(2, newHighestBidId);
					ps2.executeUpdate();
					
					ps3.setString(1, newHighestBidId);
					ps3.setString(2, clothing_id);
					ps3.executeUpdate();
					
					String str4="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic='false'";
					ResultSet result4=stmt.executeQuery(str4);
					while(result4.next()){
						String insert4="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
						PreparedStatement ps4 = con.prepareStatement(insert4);
						ps4.setString(1, result4.getString("user"));
						ps4.setString(2, clothing_id);
						ps4.setString(3, "higher_bid");
						ps4.setString(4, "false");
						ps4.executeUpdate();
					}
				}
			}
			String str4="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic='false'";
			ResultSet result4=stmt.executeQuery(str4);
			while(result4.next()){
				String insert4="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
				PreparedStatement ps4 = con.prepareStatement(insert4);
				ps4.setString(1, result4.getString("user"));
				ps4.setString(2, clothing_id);
				ps4.setString(3, "higher_bid");
				ps4.setString(4, "false");
				ps4.executeUpdate();
			}
			//get incremenet and upper limit of is automatic
			//if last bid is greater than or equal to is automatic upper limit send alert to all buyers except original buyer
			//else
				// if last bid + incremenet > upper limit set to upper limit
				// else set to last bid + incremenet
				//alert original manual buyer and all others
		}
		else if(numAutoBids>1){
			String str2 = "select MAX(b.bid_increment) as max, m.username as username from bid b, buyer_makes_bid m, bid_on_auction o,auction a where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"'and b.is_automatic='true' and a.clothing_id=o.clothing_id and b.upper_limit>='"+last_bid+"'" ;
			ResultSet rs2 = stmt.executeQuery(str2);
			if (rs2.next()){
				if(rs2.getString("username")!=null){
					if(!username.equals(rs2.getString("username"))){
					//alert everyone but highest user
						String highestUser = rs2.getString("username");
						String highestInc= rs2.getString("max");
						String str3="select * from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and m.username='"+highestUser+"'";
						ResultSet rs3 = stmt2.executeQuery(str3);
						rs3.next();
						Double inc=Double.parseDouble(rs3.getString("bid_increment"));
						Double upperlim=Double.parseDouble(rs3.getString("upper_limit"));
						String newHighestBid;
						if(last_bid+inc>upperlim){	
							newHighestBid=Double.toString(upperlim);
						}
						else{
							newHighestBid=Double.toString(last_bid+inc);
						}
						PreparedStatement ps = con.prepareStatement("INSERT INTO bid(bidding_price, is_automatic,upper_limit,bid_increment)" + "VALUES (?, ?, ?, ?)");
						PreparedStatement ps2 = con.prepareStatement("INSERT INTO buyer_makes_bid(username,bid_id)" + "VALUES (?, ?)");
						PreparedStatement ps3 = con.prepareStatement("INSERT INTO bid_on_auction(bid_id, clothing_id)" + "VALUES (?, ?)");
						
						ps.setString(1, newHighestBid);
						ps.setString(2, "true");
						ps.setString(3, Double.toString(upperlim));
						ps.setString(4, Double.toString(inc));
						ps.executeUpdate();
						
						ResultSet rs4 = stmt3.executeQuery("select max(b.bid_id) as max from bid b");
						rs4.next();
						String newHighestBidId = rs4.getString("max");
						
						ps2.setString(1, highestUser);
						ps2.setString(2, newHighestBidId);
						ps2.executeUpdate();
						
						ps3.setString(1, newHighestBidId);
						ps3.setString(2, clothing_id);
						ps3.executeUpdate();
						
						//alert all manual
						String str4="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic='false'";
						ResultSet result4=stmt3.executeQuery(str4);
						while(result4.next()){
							String insert4="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
							PreparedStatement ps4 = con.prepareStatement(insert4);
							ps4.setString(1, result4.getString("user"));
							ps4.setString(2, clothing_id);
							ps4.setString(3, "higher_bid");
							ps4.setString(4, "false");
							ps4.executeUpdate();
						}				
						//alert all automatic
						String str5="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic='true' and m.username <>'"+highestUser+"'";
						ResultSet result5=stmt3.executeQuery(str4);
						while(result5.next()){
							String insert5="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
							PreparedStatement ps5 = con.prepareStatement(insert5);
							ps5.setString(1, result5.getString("user"));
							ps5.setString(2, clothing_id);
							ps5.setString(3, "upper_limit");
							ps5.setString(4, "true");
							ps5.executeUpdate();
						}
					}
				}
				else{
					//upper limit surpassedfor everyone
					//alert everyone with automatic that upperlimit reached and everyone manual that higherbid except original bidder
					//alert manual
					String str6="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic<>'true' and m.username<>'"+username+"'";
					ResultSet result6=stmt.executeQuery(str6);
					while(result6.next()){
						String insert6="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
						PreparedStatement ps6 = con.prepareStatement(insert6);
						ps6.setString(1, result6.getString("user"));
						ps6.setString(2, clothing_id);
						ps6.setString(3, "higher_bid");
						ps6.setString(4, "false");
						ps6.executeUpdate();
					}
					//alert automatic
					String str3="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic<>'false' and m.username<>'"+username+"'";
					ResultSet result2=stmt.executeQuery(str3);
					while(result2.next()){
						String insert2="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
						PreparedStatement ps2 = con.prepareStatement(insert2);
						ps2.setString(1, result2.getString("user"));
						ps2.setString(2, clothing_id);
						ps2.setString(3, "upper_limit");
						ps2.setString(4, "true");
						ps2.executeUpdate();
					}
				}
				
			}
			else{
				//upper limit surpassedfor everyone
				//alert everyone with automatic that upperlimit reached and everyone manual that higherbid except original bidder
				//alert manual
				out.print("3456");
				String str6="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic<>'true' and m.username<>'"+username+"'";
				ResultSet result6=stmt.executeQuery(str6);
				while(result6.next()){
					String insert6="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
					PreparedStatement ps6 = con.prepareStatement(insert6);
					ps6.setString(1, result6.getString("user"));
					ps6.setString(2, clothing_id);
					ps6.setString(3, "higher_bid");
					ps6.setString(4, "false");
					ps6.executeUpdate();
				}
				//alert automatic
				String str3="select distinct m.username as user from bid b, bid_on_auction o, buyer_makes_bid m where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='"+clothing_id+"' and b.is_automatic<>'false' and m.username<>'"+username+"'";
				ResultSet result2=stmt.executeQuery(str3);
				while(result2.next()){
					String insert2="INSERT INTO set_alerts_for(username,clothing_id,notification,seen)" + "VALUES (?, ?,?,?)";
					PreparedStatement ps2 = con.prepareStatement(insert2);
					ps2.setString(1, result2.getString("user"));
					ps2.setString(2, clothing_id);
					ps2.setString(3, "higher_bid");
					ps2.setString(4, "false");
					ps2.executeUpdate();
				}
				
			
			//WHAT IF LAST BID IS AUTOMATIC?
			//get the highest increment result set where upper limit < last bid amount (NOT INCLUDING THE LAST BID IF AUTOMATIC ?)
			//from that result set get the lowest bidId
			//if none alert everyone with automatic that upperlimit reached and everyone manual that higherbid except original bidder
			//else
				//if last bid + incremenet > upper limit set to upper limit
				// else set to last bid + incremenet
				//if none alert everyone with automatic that upperlimit reached and everyone manual that higherbid except original bidder
			}
			out.print("3456");
		}
		con.close();
		session.removeAttribute("clothing_id");
		session.removeAttribute("last_bid");
		session.removeAttribute("bidID");
		out.print("Bid Successful");	
	%>		
		<br>
		<br>
		<form action="homePage.jsp" method="post" >
				<input type="submit" value="Home">
		</form>			
	<%} catch (Exception e) {
			if(error.equals("")){
				out.print("Something went wrong try again "+e);
			}
			else{
				out.print(error);
			}
			
// select b.bidid, count(*) from bid b, make m, bidon o where b.bidid=m.bidid and b.bidid=o.bidid and o.auctionid='100' and b.is_automatic='T' group by m.buyerid

//select m.buyerid, count(distinct m.buyerid) from bid b, make m, bidon o where b.bidid=m.bidid and b.bidid=o.bidid and o.auctionid='100' and b.is_automatic='T';

//select count(distinct m.username) from bid b, buyer_makes_bid m, bid_on_auction o where b.bid_id=m.bid_id and b.bid_id=o.bid_id and o.clothing_id='100' and b.is_automatic='true';

//select m.buyerid from bid b, make m, bidon o where b.bidid=m.bidid and b.bidid=o.bidid and o.auctionid='100' and b.is_automatic='T';

//select bid_increment, upper_limit from bid b, bidon o where b.bidid=o.bidid and o.auctionid='100' and b.is_automatic='T';
//select b.bid_increment, b.upper_limit from bid b, bid_on_auction o where b.bid_id=o.bid_id and o.clothing_id='100' and b.is_automatic='true';

	}%>

</body>
</html>