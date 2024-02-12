<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>주문 취소</title>
</head>
<body>
	<jsp:include page="../main/menu.jsp" />
	<div class="jumbotron" style="background-color: #2c3034; ">
		<div class="container" style="padding:100px;height:200px;">
			<h1 class="display-3" style="color:white;">주문취소</h1>
		</div>
	</div>
	<div class="container"style="padding-top: 50px;">
		<h2 class="alert alert-danger">주문이 취소되었습니다.</h2>
	</div>
	<div class="container">
		<p><a href="/products" class="btn btn-secondary"> &laquo; 상품 목록</a>
	</div>	
</body>
</html>
