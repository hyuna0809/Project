<%@ page contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="kr.co.evcharger.product.dto.Product"%>
<%@ page import="kr.co.evcharger.product.dao.ProductRepository"%>


<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>배송 정보</title>
</head>
<body>
<jsp:include page="../main/menu.jsp" />
<div class="jumbotron" style="background-color: #2c3034; ">
	<div class="container" style="padding:100px;height:200px;">
		<h1 class="display-3" style="color:white;">배송정보</h1>
	</div>
</div>
<div class="container" style="padding-top: 50px;">
	<form action="/processShippingInfo" class="form-horizontal" method="post" style="color: black;">
		<input type="hidden" name="cartId" value="<%=request.getParameter("cartId")%>" />
		<div class="form-group row">
			<label class="col-sm-2">성명</label>
			<div class="col-sm-3">
				<input name="name" type="text" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">배송일</label>
			<div class="col-sm-3">
				<input name="shippingDate" type="date" class="form-control" required/>(yyyy/mm/dd)
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">국가명</label>
			<div class="col-sm-3">
				<input name="country" type="text" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">우편번호</label>
			<div class="col-sm-3">
				<input name="zipCode" type="text" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<label class="col-sm-2">주소</label>
			<div class="col-sm-5">
				<input name="addressName" type="text" class="form-control" required/>
			</div>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10 ">
				<a href="./cart?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button"> 이전 </a>
				<input   type="submit" class="btn btn-primary" value="등록" />
				<a href="/checkOutCancelled" class="btn btn-secondary" role="button"> 취소 </a>
			</div>
		</div>
	</form>
</div>
</body>
</html>


