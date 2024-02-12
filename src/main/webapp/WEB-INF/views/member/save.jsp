<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>save</title>
    <link rel="stylesheet" href="/css/membersave.css">

    <!-- jQuery cdn -->
    <script
            src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous">
    </script>
</head>
<body>
<jsp:include page="../main/menu.jsp" />

<div class="save-wrapper">
    <h2>회원가입</h2>
    <form action="/member/save" method="post" id="save-form" onsubmit="return submitForm()">
        <input type="email" name="memberEmail" id="memberEmail" onblur="emailCheck()" placeholder="Email" required>
        <p id="check-result"></p>
        <input type="password" minlength="4" maxlength="20" name="memberPassword" placeholder="Password" required>
        <input type="text" name="memberName" placeholder="UserName" minlength="2" maxlength="10" required>
        <input type="submit" value="회원가입">
    </form>
</div>

<script th:inline="javascript">
    const emailCheck = () => {
        const emailInput = document.getElementById("memberEmail");
        const email = emailInput.value;
        const checkResult = document.getElementById("check-result");

        console.log("입력값: ", email);
        $.ajax({
            type: "post",
            url: "/member/email-check",
            data: {
                "memberEmail": email
            },
            success: function(res) {
                console.log("요청성공", res);
                if (res === "ok") {
                    console.log("이미 사용중인 이메일");
                    checkResult.style.color = "red";
                    checkResult.innerHTML = "이미 사용중인 이메일";
                    window.alert("이미 사용중인 이메일입니다. 다른 이메일을 입력해주세요.");
                } else {
                    console.log("사용가능한 이메일");
                    checkResult.style.color = "green";
                    checkResult.innerHTML = "사용가능한 이메일";
                }
            },
            error: function(err) {
                console.log("에러발생", err);
            }
        });
        return false; // 폼 제출을 여기서 중지
    }

    const submitForm = () => {
        const checkResult = document.getElementById("check-result");
        // 사용가능한 이메일이라면 폼 제출
        if (checkResult.innerHTML === "사용가능한 이메일") {
            return true;
        }
        // 중복된 이메일이라면 폼 제출 중지
        window.alert("이메일 중복 확인이 필요합니다.");
        return false;
    }
</script>

</body>
</html>
