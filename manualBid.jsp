<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manual Bid</title>
</head>
<body>
	Create Bid
	<br>
	<br>
	<%
		String clothing_id = request.getParameter("clothing_id");
		String bidMin = "";
		
	 try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement stmt = con.createStatement();
			
			String s="SELECT increment FROM auction WHERE clothing_id='"+clothing_id+"'";
			ResultSet r = stmt.executeQuery(s);
			r.next();
			Double increment = Double.parseDouble(r.getString("increment"));
			
			
			String str = "SELECT MAX(b.bidding_price) as MAX FROM bid b, bid_on_auction o WHERE b.bid_id=o.bid_id and o.clothing_id = " + clothing_id;
			ResultSet result = stmt.executeQuery(str);
			
			result.next();
			
			if (result.getString("MAX")!=null){
				%>Must bid at least $<%=increment%> over last bid of $<%=result.getString("MAX")%><% 
				bidMin=result.getString("MAX");
			}else{
				str = "SELECT init_price as INIT FROM auction WHERE clothing_id = " + clothing_id;
				result = stmt.executeQuery(str);
				result.next();
				%>Must bid at least $<%=increment%> over initial price of $<%=result.getString("INIT")%>
				<%
				bidMin=result.getString("INIT");
			}
			
			db.closeConnection(con);
			%>
						
	<%} catch (Exception e) {
			out.print(e);
	}%>
	<br>
	Enter bid information:
	<form method="post" action="checkManualBid.jsp">
		<table>
			<tr>
				<td>Bid Amount</td><td><input type="text" name="bidding_price"></td>
			</tr>
			<tr>
				<td><input type = "hidden" name = "clothing_id" value = <%=clothing_id%>></td>
			</tr>
			<tr>
				<td><input type = "hidden" name = "bidMin" value = <%=bidMin%>></td>
			</tr>	
		</table>
		<br>
		<input type="submit" value="Make Bid">
	</form>

</body>
</html>