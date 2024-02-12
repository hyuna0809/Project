<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>index</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
        }
        a {
            display: inline-block;
            margin: 10px;
            padding: 8px 16px;
            text-decoration: none;
            color: #fff;
            background-color: #F1575B;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #d1454c;
        }
    </style>
</head>
<body>
<h2>Hello Spring Boot!</h2>
<a href="<c:url value='/member/save'/>">회원가입</a>
<a href="<c:url value='/member/login'/>">로그인</a>
<a href="<c:url value='/member/'/>">회원목록</a>
</body>
</html>
