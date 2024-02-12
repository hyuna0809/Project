<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 아이디 오류</title>
</head>
<body>
	<jsp:include page="../main/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h2 class="alert alert-danger">해당 상품이 존재하지 않습니다.</h2>
		</div>
	</div>
	<div class="container">
	<!-- 오류가 발생했을 때 해당 오류 페이지를 출력하도록 표현문 태그에 request 내장객체인 getRequestURL()메소드작성/ 요청 파라미터를 출력하도록
	표현문태그에 request 내장객체의 getQueryString()메소드 작성-->
		<p><%=request.getRequestURL()%>?<%=request.getQueryString()%>
		<p><a href="../products.jsp" class="btn btn-secondary"> 상품 목록 &raquo;</a>
	</div>
</body>
</html>
