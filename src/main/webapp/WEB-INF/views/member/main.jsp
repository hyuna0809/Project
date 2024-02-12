<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>main</title>
</head>
<body>
session 값 확인: <p><%= session.getAttribute("loginEmail") %></p>
<a href="/member/update">내 정보 수정하기</a>
<a href="/member/logout">로그아웃</a>

<!-- 로그인을 하면 처음에 눌렀던 페이지로 가지게 스크립트 추가 ex) 게시판에서 로그인 누르면 게시판 페이지 가지는 것처럼-->
</body>
</html>
