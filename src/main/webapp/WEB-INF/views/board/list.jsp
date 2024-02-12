<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>list</title>
</head>
<body>
<table>
    <tr>
        <th>id</th>
        <th>title</th>
        <th>writer</th>
        <th>date</th>
        <th>hits</th>
    </tr>
    <c:forEach var="board" items="${boardList}">
        <tr>
            <td><c:out value="${board.id}"/></td>
            <td><a href="<c:out value='/board/${board.id}'/>"><c:out value="${board.boardTitle}"/></a></td>
            <td><c:out value="${board.boardWriter}"/></td>
            <td><c:out value="${board.boardCreatedTime}"/></td>
            <td><c:out value="${board.boardHits}"/></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
