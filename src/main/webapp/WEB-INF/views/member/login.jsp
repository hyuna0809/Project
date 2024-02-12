<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<link rel="stylesheet" href="/css/login.css">
</head>
<body>
<jsp:include page="../main/menu.jsp" />

<div class="login-wrapper">
	<h2>로그인</h2>
	<form method="post" action="/login" id="login-form">
		<input type="email" name="memberEmail" placeholder="Email">
		<input type="password" name="memberPassword" placeholder="Password">
		<label for="remember-check">
			<input type="checkbox" id="remember-check">아이디 저장하기
		</label>
		<input type="submit" value="로그인">
		<a href="/member/save"> 회원가입</a>
	</form>
</div>

</body>
</html>