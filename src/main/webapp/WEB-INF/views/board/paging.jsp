<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/css/paging.css">
</head>
<body>
<jsp:include page="../main/menu.jsp" />

<div id="write">
    <button onclick="saveReq()">글작성</button>
</div>

<div id="top">
    <h1>게시판</h1>
</div>

<table>
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>글쓴이</th>
        <th>날짜</th>
        <th>조회수</th>
    </tr>
    <c:forEach var="board" items="${boardList.content}">
        <tr>
            <td>${board.id}</td>
            <td><a href="/board/${board.id}?page=${boardList.number + 1}">${board.boardTitle}</a></td>
            <td>${board.boardWriter}</td>
                <%--<td><fmt:formatDate value="${java.util.Date.from(board.boardCreatedTime.toInstant())}" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
            <td>${board.boardCreatedTime}</td>
            <td>${board.boardHits}</td>
        </tr>
    </c:forEach>
</table>

<div id="num">
    <a href="/board/?page=1">&lt;&lt;</a>
    <c:if test="${boardList.number > 0}">
        <a href="/board/?page=${boardList.number}">&lt;</a>
    </c:if>

    <c:forEach var="page" begin="${startPage}" end="${endPage}">
        <c:choose>
            <c:when test="${page == boardList.number + 1}">
                <span>${page}</span>
            </c:when>
            <c:otherwise>
                <a href="/board/?page=${page}">${page}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${boardList.number + 1 < boardList.totalPages}">
        <a href="/board/?page=${boardList.number + 2}">&gt;</a>
    </c:if>
    <a href="/board/?page=${boardList.totalPages}">&gt;&gt;</a>
</div>



</body>
<script>
    const saveReq = () => {
        location.href = "/board/save";
    }
</script>
</html>