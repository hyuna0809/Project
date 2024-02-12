<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="kr.co.evcharger.product.dto.Product"%>

<html>
<head>
	<!-- 포트원 결제 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<!-- jQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>

<%
	request.setCharacterEncoding("UTF-8");

	String cartId = session.getId();

	String Shipping_cartId = "";
	String Shipping_name = "";
	String Shipping_shippingDate = "";
	String Shipping_country = "";
	String Shipping_zipCode = "";
	String Shipping_addressName = "";

	// 쿠키 가져오기
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			String name = cookie.getName();
			if (name.equals("Shipping_cartId"))
				Shipping_cartId = URLDecoder.decode(cookie.getValue(), "utf-8");
			if (name.equals("Shipping_name"))
				Shipping_name = URLDecoder.decode(cookie.getValue(), "utf-8");
			if (name.equals("Shipping_shippingDate"))
				Shipping_shippingDate = URLDecoder.decode(cookie.getValue(), "utf-8");
			if (name.equals("Shipping_country"))
				Shipping_country = URLDecoder.decode(cookie.getValue(), "utf-8");
			if (name.equals("Shipping_zipCode"))
				Shipping_zipCode = URLDecoder.decode(cookie.getValue(), "utf-8");
			if (name.equals("Shipping_addressName"))
				Shipping_addressName = URLDecoder.decode(cookie.getValue(), "utf-8");
		}
	}
%>

<body>
<jsp:include page="../main/menu.jsp" />

<div class="jumbotron" style="background-color: #2c3034; ">
	<div class="container" style="padding:100px;height:200px;">
		<h1 class="display-3" style="color:white;">주문정보</h1>
	</div>
</div>

<div class="container col-8 alert alert-info"style="padding-top: 50px; color: black;">
	<div class="text-center">
		<h1>영수증</h1>
	</div>
	<div class="row justify-content-between">
		<div class="col-4" align="left">
			<strong>배송 주소</strong> <br>
			성명 : <%= Shipping_name %> <br>
			우편번호 : <%= Shipping_zipCode %><br>
			주소 : <%= Shipping_addressName %> (<%= Shipping_country %>) <br>
		</div>
		<div class="col-4" align="right">
			<p><em>배송일: <%= Shipping_shippingDate %></em></p>
		</div>
	</div>

	<div>
		<table class="table table-hover" style="color: black;">
			<tr>
				<th class="text-center">상품</th>
				<th class="text-center">#</th>
				<th class="text-center">가격</th>
				<th class="text-center">소계</th>
			</tr>
			<% int sum = 0;
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
				if (cartList == null) cartList = new ArrayList<Product>();
				for (int i = 0; i < cartList.size(); i++) {
					Product product = cartList.get(i);
					int total = product.getUnitPrice() * product.getQuantity();
					sum = sum + total;
			%>
			<tr>
				<td class="text-center"><em><%= product.getPname() %> </em></td>
				<td class="text-center"><%= product.getQuantity() %></td>
				<td class="text-center"><%= product.getUnitPrice() %>원</td>
				<td class="text-center"><%= total %>원</td>
			</tr>
			<% } %>
			<tr>
				<td> </td>
				<td> </td>
				<td class="text-right">   <strong>총액: </strong></td>
				<td class="text-center text-danger"><strong><%= sum %> </strong></td>
			</tr>
		</table>
		<%
			String orderName = "주문명 없음";
			if (!cartList.isEmpty()) {
				Product firstProduct = cartList.get(0);
				orderName = firstProduct.getPname() + " 등";
			}
		%>

		<!-- 카카오페이 결제 버튼 추가 -->
		<button id="kakaoPayButton" type="button" class="btn btn-primary">카카오페이 결제</button>
		<a href="/shippingInfo?cartId=<%=Shipping_cartId%>" class="btn btn-secondary" role="button"> 이전 </a>
		<a href="/thankCustomer" class="btn btn-success" role="button"> 주문 완료 </a>
		<a href="/checkOutCancelled" class="btn btn-secondary" role="button"> 취소 </a>


		<script>
			$("#kakaoPayButton").click(function () {
				var IMP = window.IMP;
				IMP.init('imp70061334');

				IMP.request_pay({
					pg: 'kakaopay',
					pay_method: 'card',
					merchant_uid: 'merchant_' + new Date().getTime(),
					name: '<%= orderName %>',
					amount: <%= sum %>, // 주문 총액을 사용
					buyer_email: '<%= "구매자 이메일" %>',
					buyer_name: '<%= "구매자 이름" %>',
					buyer_tel: '<%= "구매자 전화번호" %>',
					buyer_addr: '<%= "구매자 주소" %>',
					buyer_postcode: '<%= "우편번호" %>',
					m_redirect_url: '<%= "결제 완료 후 리다이렉션 URL" %>'
				}, function (rsp) {
					console.log(rsp);
					if (rsp.success) {
						var msg = '결제가 완료되었습니다.';
						msg += '고유ID : ' + rsp.imp_uid;
						msg += '상점 거래ID : ' + rsp.merchant_uid;
						msg += '결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num;
						alert(msg);
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
						alert(msg);
					}
				});
			});
		</script>


	</div>
</div>
</body>
</html>