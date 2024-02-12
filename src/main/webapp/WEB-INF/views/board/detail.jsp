<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>detail</title>
    <link rel="stylesheet" href="/css/detail.css">
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <%
        // 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
        MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");
        if (loggedInMember == null) {
            loggedInMember = new MemberDTO(); // 빈 MemberDTO 생성
        }
    %>
</head>
<body>
<jsp:include page="../main/menu.jsp" />
<div id="top">
    <h2>게시글</h2>
</div>
<table>
    <tr>
        <th>번호</th>
        <td>${board.id}</td>
    </tr>
    <tr>
        <th>제목</th>
        <td>${board.boardTitle}</td>
    </tr>
    <tr>
        <th>글쓴이</th>
        <td>${board.boardWriter}</td>
    </tr>
    <tr>
        <th>날짜</th>
        <td>${empty board.boardUpdatedTime ? board.boardCreatedTime : board.boardUpdatedTime}</td>
    </tr>
    <tr>
        <th>조회수</th>
        <td>${board.boardHits}</td>
    </tr>
    <tr>
        <th>내용</th>
        <td>${board.boardContents}</td>
    </tr>
</table>
<div id="additional-content-for-loggedInMember">
    <button onclick="listReq()">목록</button>
    <c:if test="${loggedInMember != null && loggedInMember.memberName eq board.boardWriter}">
        <button onclick="updateReq()">수정</button>
        <button onclick="deleteReq()">삭제</button>
    </c:if>
</div>
<!-- 댓글 작성 부분 -->
<div id="comment-write">
    <c:choose>
        <c:when test="${loggedInMember eq null}">
            <input type="text" id="commentWriter" placeholder="작성자" value="로그인을 해주세요" required readonly>
            <input type="text" id="commentContents" placeholder="내용" required readonly>
        </c:when>
        <c:otherwise>
            <input type="text" id="commentWriter" placeholder="작성자" value="${loggedInMember.memberName}" required readonly>
            <input type="text" id="commentContents" placeholder="내용" required>
        </c:otherwise>
    </c:choose>

    <button id="comment-write-btn" onclick="commentWrite()">댓글작성</button>
</div>
<div id="middle">
    <h3>댓글</h3>
</div>
<!-- 댓글 출력 부분 -->
<div id="comment-list">
    <table>
        <tr>
            <th>댓글번호</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성시간</th>
        </tr>
        <c:forEach var="comment" items="${commentList}">
            <tr>
                <td>${comment.id}</td>
                <td>${comment.commentWriter}</td>
                <td>${comment.commentContents}</td>
                <td>${comment.commentCreatedTime}</td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
<script>
    const commentWrite = () => {
        const writer = document.getElementById("commentWriter").value;
        const contents = document.getElementById("commentContents").value;
        console.log("작성자: ", writer);
        console.log("내용: ", contents);
        const id = ${board.id}; // 게시글번호
        $.ajax({
            // 요청방식: post, 요처주소: /comment/save, 요청데이터: 작성자 작성내용 게시글번호
            "type": "post",
            url: "/comment/save",
            data: {
                "commentWriter": writer,
                "commentContents": contents,
                "boardId": id
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', $('[name="_csrf"]').val());
            },
            success: function (res) {
                console.log("요청성공", res);
                let output = "<table>";
                output += "<tr><th>댓글번호</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for (let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].id + "</td>";
                    output += "<td>" + res[i].commentWriter + "</td>";
                    output += "<td>" + res[i].commentContents + "</td>";
                    output += "<td>" + res[i].commentCreatedTime + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('comment-list').innerHTML = output;
                document.getElementById('commentContents').value = '';
            },
            error: function (err) {
                console.log("요청실패", err);
            }
        });
    }
    const listReq = () => {
        console.log("목록 요청");
        const page = ${page};
        location.href = "/board";
    }

    const updateReq = () => {
        console.log("수정 요청");
        const id = ${board.id};
        location.href = "/board/update/" + id;
    }
    const deleteReq = () => {
        console.log("삭제 요청");
        const id = ${board.id};
        location.href = "/board/delete/" + id;
    }
</script>
</html>
