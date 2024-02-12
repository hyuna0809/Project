<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>save</title>
    <link rel="stylesheet" href="/css/boardsave.css">
    <%
        // 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
        MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");

        // 로그인하지 않은 경우
        if (loggedInMember == null) {

    %>

    <script>
        alert("로그인을 해주세요.")
        location.href="/member/login"
    </script>

    <%
    } else {
    %>

    <link rel="stylesheet" href="/css/boardsave.css">
</head>

<body>
<jsp:include page="../main/menu.jsp" />
<form action="/board/save" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div id="top">
        <h2>게시글 작성</h2>
    </div>

    <!-- boardWriter 값을 자동으로 로그인한 사용자의 이름으로 설정 -->
    <input type="hidden" name="boardWriter" value="<%= loggedInMember.getMemberName() %>">
    <p>글쓴이: <%= loggedInMember.getMemberName() %> 님</p>

    글제목: <input type="text" name="boardTitle" required> <br>
    내용: <textarea name="boardContents" cols="30" rows="10" required></textarea> <br>
    <input type="submit" value="글작성">
</form>
</body>
<%
    }
%>
</html>
