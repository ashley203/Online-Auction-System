<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create Auction</title>
	</head>
	<body>
		Create Alert
		<br>
		<br>
		Enter item information:		
		<%
		String command = request.getParameter("type");
		
		if(command.equals("shirt")){ %>
			<form method="post" action="itemInterestedShirt.jsp">
			<table>
				<tr>
					<td>Shirt Size</td><td><input type="text" name="shirtSize"></td>
				</tr>
				<tr>
					<td>Neckline</td><td><input type="text" name="neckline"></td>
				</tr>
				<tr>
					<td>Sleeve Length</td><td><input type="text" name="sleeveLength"></td>
				</tr>
				<tr>
					<td>Brand</td><td><input type="text" name="brand"></td>
				</tr>
				<tr>
					<td>Color</td><td><input type="text" name="color"></td>
				</tr>
				<tr>
					<td>Style</td><td><input type="text" name="style"></td>
				</tr>
				<tr>
					<td>Manufacture Date (yyyy-mm-dd)</td><td><input type="date" name="manufactureDate"></td>
				</tr>
			</table>	
			<br>
			<input type="submit" value="Create">
		</form>
		<% }
		
		if(command.equals("pants")){ %>
		<form method="post" action="itemInterestedPants.jsp">
			<table>
				<tr>
					<td>Pants Size</td><td><input type="text" name="pantsSize"></td>
				</tr>
				<tr>
					<td>Fit</td><td><input type="text" name="fit"></td>
				</tr>
				<tr>
					<td>Brand</td><td><input type="text" name="brand"></td>
				</tr>
				<tr>
					<td>Color</td><td><input type="text" name="color"></td>
				</tr>
				<tr>
					<td>Style</td><td><input type="text" name="style"></td>
				</tr>
				<tr>
					<td>Manufacture Date (yyyy-mm-dd)</td><td><input type="date" name="manufactureDate"></td>
				</tr>
			</table>	
			<br>
			<input type="submit" value="Create">
		</form>
	<% }
		if(command.equals("shoes")){ %>
			<form method="post" action="itemInterestedShoes.jsp">
			<table>
				<tr>
					<td>Shoe Size</td><td><input type="text" name="shoeSize"></td>
				</tr>
				<tr>
					<td>Width</td><td><input type="text" name="width"></td>
				</tr>
				<tr>
					<td>Material</td><td><input type="text" name="material"></td>
				</tr>
				<tr>
					<td>Brand</td><td><input type="text" name="brand"></td>
				</tr>
				<tr>
					<td>Color</td><td><input type="text" name="color"></td>
				</tr>
				<tr>
					<td>Style</td><td><input type="text" name="style"></td>
				</tr>
				<tr>
					<td>Manufacture Date (yyyy-mm-dd)</td><td><input type="date" name="manufactureDate"></td>
				</tr>
			</table>	
			<br>
			<input type="submit" value="Create">
		</form>		
		<%} %>
		<br>
		<a href="itemInterestedType.jsp">Back</a>

	</body>
</html>