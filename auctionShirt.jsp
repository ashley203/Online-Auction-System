<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create Shirt Auction</title>
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
		//Get parameters from the HTML form at the index.jsp
		String shirtSize = request.getParameter("shirtSize");
		String neckline = request.getParameter("neckline");
		String sleeveLength = request.getParameter("sleeveLength");
		String brand = request.getParameter("brand");
		String color = request.getParameter("color");
		String style = request.getParameter("style");
		String manufactureDate = request.getParameter("manufactureDate");
		String minimumPrice = request.getParameter("minimumPrice");
		String initialPrice = request.getParameter("initialPrice");
		String increment = request.getParameter("increment");
		String endDate = request.getParameter("endDate");
		String endTime = request.getParameter("endTime");
		String username = session.getAttribute("username").toString();
		
		//Make insert statements for tables:
		String insert = "INSERT INTO clothing(style, brand, clothing_type, color, manufacture_date)"
				+ "VALUES (?, ?, ?, ?, ?)";
		String insert2 = "INSERT INTO shirts(clothing_id, shirt_size, sleeve_length, neckline)"
				+ "VALUES (?, ?, ?, ?)";
		String insert3 = "INSERT INTO auction(clothing_id, end_date, end_time, min_price, init_price, increment)"
				+ "VALUES (?, ?, ?, ?, ?,?)";
		String insert4 = "INSERT INTO seller_sets_auction(username,clothing_id)"
				+ "VALUES (?,?)";
				
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		PreparedStatement ps2 = con.prepareStatement(insert2);
		PreparedStatement ps3 = con.prepareStatement(insert3);
		PreparedStatement ps4 = con.prepareStatement(insert4);
		
		
		
		if (style.equals("")){
			error = "Input a style";
			ps.setString(1, null);
		}
		else if (brand.equals("")){
			error = "Input a brand";
			ps.setString(2, null);
		}
		else if(color.equals("")){
			error = "Input a color";
			ps.setString(4, null);
		}
		else if (manufactureDate.equals("")){
			error = "Input a manufacture date";
			ps.setString(5, null);
		}
		else if (shirtSize.equals("")){
			error = "Input a shirt size";
			ps2.setString(2, null);
		}
		else if (sleeveLength.equals("")){
			error = "Input a sleeve length";
			ps2.setString(3, null);
		}
		else if (neckline.equals("")){
			error = "Input a neckline";
			ps2.setString(4, null);
		}
		else if(endDate.equals("")){
			error = "Input an end date";
			ps3.setString(2, null);
		}
		else if (endTime.equals("")){
			error = "Input an end time";
			ps3.setString(3, null);
		}
		else if (minimumPrice.equals("")){
			error = "Input a minimum price";
			ps3.setString(4, null);
		}
		else if(initialPrice.equals("")){
			error = "Input an initial price";
			ps3.setString(5, null);
		}
		else if(increment.equals("")){
			error = "Input an increment";
			ps3.setString(6, null);
		}
		else{
			ps.setString(1, style);
			ps.setString(2, brand);
			ps.setString(3, "shirt");
			ps.setString(4, color);
			ps.setString(5, manufactureDate);
				
			ps2.setString(2, shirtSize);
			ps2.setString(3, sleeveLength);
			ps2.setString(4, neckline);		
			
			ps3.setString(2, endDate);
			ps3.setString(3, endTime);
			ps3.setString(4, minimumPrice);
			ps3.setString(5, initialPrice);
			ps3.setString(6, increment);	
			
			ps4.setString(1,username);				
		}
		
		ps.executeUpdate();
		String str = "select max(clothing_id) as max from clothing" ;
		ResultSet result = stmt.executeQuery(str);
		result.next();
		String cid = result.getString("max");
		
		ps2.setString(1,cid);
		ps2.executeUpdate();
		
		ps3.setString(1,cid);
		ps3.executeUpdate();
		
		ps4.setString(2,cid);
		ps4.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		
		String redirectURL = "auctionSuccessful.jsp";
        response.sendRedirect(redirectURL);
		
	} catch (Exception ex) {
		//out.print(ex);
		if(error.equals("")){
			error="Something went wrong, make sure you've typed everything correctly";
		}
		out.print(error);
		%> <br> <a href="chooseAuctionType.jsp">Back</a><%
	}
%>	<br>

	</body>
</html>

			