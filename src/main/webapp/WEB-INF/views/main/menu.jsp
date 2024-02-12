<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %><%--
  Created by IntelliJ IDEA.
  User: 411-14
  Date: 2023-12-27
  Time: 오후 5:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>menu</title>
    <link rel="stylesheet" href="/css/menu.css">
</head>
<body>

<%
    // 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
    MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");
%>

<header class="header">
    <h1 class="logo"><a href="/home">EV CHARGING</a></h1>
    <ul class="main-nav">
        <li><a href="/about">About</a></li>
        <li><a href="/charging">Charger</a></li>
        <li><a href="/products">Shopping</a></li>
        <li><a href="/faq">FaQ</a></li>
        <li><a href="/board">Community</a></li>
        <%
        // 로그인하지 않은 경우
        if (loggedInMember == null) {
        %>
        <li><a href="/member/login">Login</a></li>
        <%
            }else{
        %>
        <li><a href=/logout>Logout</a></li>
        <%
            }
        %>
    </ul>
</header>

</body>

</html>