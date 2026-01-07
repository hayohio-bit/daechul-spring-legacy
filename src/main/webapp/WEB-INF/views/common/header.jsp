<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Header</title>
    <meta charset="UTF-8">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>

<body>
	<div class="header">
		<div class="container">
			<h1><a href="/index.jsp">Daechul is in season</a></h1>
			<div class="user-info">
				<span>username</span>
				<a href="">로그아웃</a>
			</div>
		</div>
	</div>
	
	<div class="navbar">
		<div class="container">
			<a href="">Home</a>
			<a href="">Board</a>
		</div>	
	</div>
</body>
</html>