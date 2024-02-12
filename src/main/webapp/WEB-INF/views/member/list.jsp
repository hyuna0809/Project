<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<h2>list.jsp</h2>
<table>
    <tr>
        <th>id</th>
        <th>memberEmail</th>
        <th>memberPassword</th>
        <th>memberName</th>
        <th>상세조회</th>
        <th>삭제</th>
    </tr>
    <c:forEach var="member" items="${memberList}">
        <tr>
            <td><c:out value="${member.id}" /></td>
            <td><c:out value="${member.memberEmail}" /></td>
            <td><c:out value="${member.memberPassword}" /></td>
            <td><c:out value="${member.memberName}" /></td>
            <td>
                <a href="<c:url value='/member/'/>${member.id}">조회</a>
            </td>
            <td>
                <a href="<c:url value='/member/delete/'/>${member.id}">삭제</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
