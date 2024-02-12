<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/css/update.css">
    <meta charset="UTF-8">
    <title>update</title>
    <%
        // 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
        MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");

        // 로그인하지 않은 경우
        if (loggedInMember == null) {

    %>

    <script>
        alert("로그인을 해주세요.")
        location.href="/login"
    </script>

    <%
    } else {
    %>
</head>
<body>
<form action="/mypage" method="post">
    <input type="hidden" name="id" value="<%= loggedInMember.getId() %>"><br>
    <input type="hidden" name="memberEmail" value="<%= loggedInMember.getMemberEmail() %>">
    이메일: <%= loggedInMember.getMemberEmail() %><br>
    비밀번호: <input type="password" value="${updateMember.memberPassword}" name="memberPassword" minlength="4" maxlength="20" required> <br>
    이름: <input type="text" value="${updateMember.memberName}" name="memberName" minlength="2" maxlength="10" required> <br>
    <input type="submit" value="정보수정">

</form>
</body>
<%
    }
%>
</html>
