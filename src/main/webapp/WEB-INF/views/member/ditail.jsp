<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>detail</title>
</head>
<body>
<table>
    <tr>
        <th>id</th>
        <th>email</th>
        <th>password</th>
        <th>name</th>
    </tr>
    <tr>
        <td><c:out value="${member.id}" /></td>
        <td><c:out value="${member.memberEmail}" /></td>
        <td><c:out value="${member.memberPassword}" /></td>
        <td><c:out value="${member.memberName}" /></td>
    </tr>
</table>
</body>
</html>
