<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 제이쿼리 불러오기 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/mypage.css">


    <title>주차의 민족</title>
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
<div class="container"></div>

<section>
    <div class="join">
        <h2>ALL PARKING</h2>
        <div class="basic">
            <h3>MY PAGE</h3>
            <div class="id">
                <p>아이디</p>
                <input type="hidden" name="boardWriter" value="<%= loggedInMember.getMemberEmail() %>">
                <p class="text"><%= loggedInMember.getMemberEmail() %></p>
            </div>
            <!-- 비밀번호 입력 부분은 주석 처리 -->
            <!--
            <div class="pw">
                <p>비밀번호</p>
                <input type="password" class="text">
            </div>
            -->
            <div class="name">
                <p>이름</p>
                <input type="hidden" name="boardWriter" value="<%= loggedInMember.getMemberName() %>">
                <p class="text"><%= loggedInMember.getMemberName() %></p>
            </div>
            </div>
            <div class="bt1">
                <input type="button" class="submit" name="회원정보 수정" value="회원정보 수정" onclick="location.href='/member/update'">
                <input type="button" class="submit" name="취소" value="취소" onclick="location.href='/home'">
            </div>
        </div>
</section>
</body>
<%
    }
%>

</html>
