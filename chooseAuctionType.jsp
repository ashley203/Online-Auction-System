<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Choose Auction Type</title>
	</head>
	<body>
		Create Auction
		<br>
		<br>
		Choose Clothing Type:
		<br>
	
		<form action="createAuction.jsp" method="post" >
		  <input type="radio" name="type" value="shirt"/>Shirt
		  <br>
		  <input type="radio" name="type" value="pants"/>Pants
		  <br>
		  <input type="radio" name="type" value="shoes"/>Shoes
		  <br>
		  <input type="submit" value="submit" />
		</form>
		<br>
		<a href="homePage.jsp">Back</a>
		
		
		<br>

	</body>
</html>

			