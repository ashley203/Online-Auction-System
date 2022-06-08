<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sign Up</title>
	</head>
	<body>
		Sign Up
		<br>
		<br>
		
		<form method="post" action="checkSignUp.jsp">
			<table>
				<tr>
					<td>First name</td><td><input type="text" name="firstName"></td>
				</tr>
				<tr>
					<td>Last name</td><td><input type="text" name="lastName"></td>
				</tr>
				<tr>
					<td>Email</td><td><input type="email" name="email"></td>
				</tr>
				<tr>
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			</table>	
			<br>
			<input type="submit" value="Sign Up">
		</form>

	</body>
</html>