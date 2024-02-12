<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>update</title>
    <link rel="stylesheet" href="/css/update.css">

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
<jsp:include page="../main/menu.jsp" />
<form action="/board/update" method="post" name="updateForm">
    <div id="top">
        <h2>게시글 수정</h2>
    </div>
    <input type="hidden" name="id" value="${boardUpdate.id}">
    <input type="hidden" name="boardWriter" value="<%= loggedInMember.getMemberName() %>">
    <p>글쓴이: <%= loggedInMember.getMemberName() %> 님</p>
    글제목: <input type="text" name="boardTitle" value="${boardUpdate.boardTitle}" required> <br>
    내용: <textarea name="boardContents" cols="30" rows="10">${boardUpdate.boardContents} required</textarea> <br>
    <input type="hidden" name="boardHits" value="${boardUpdate.boardHits}">
    <input type="submit" value="글수정">
</form>
</body>
<%
    }
%>
</html>
