<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.evcharger.product.dto.Product"%>
<%@ page import="java.util.Enumeration" %>
<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ include file="../main/dbconn.jsp" %>
<%@ page session="true" %>
<html>
<head>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" style="top: auto">
	<%
		String cartId = session.getId();
	%>
	<title>장바구니</title>
	<%
		// 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
		MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");

		// 로그인하지 않은 경우
		if (loggedInMember == null) {

	%>
	<script>
		alert("로그인을 해주세요.")
		location.href="/member/login"
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		function removeFromCart(productId) {
			if (confirm("장바구니에서 이 상품을 삭제하시겠습니까?")) {
				// 서버에 삭제 요청
				fetch('/removeCart', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
					},
					body: JSON.stringify({ cartList: [{ productId: productId }] }),  // 삭제할 상품의 ID를 서버에 전송
				}).then(response => {
					// 서버 응답을 확인하고 페이지 리로드
					if (response.ok) {
						console.log('장바구니에서 상품이 성공적으로 삭제되었습니다');
						// 페이지 리로드
						location.reload();
					} else {
						// 응답이 성공이 아닌 경우 에러 핸들링
						return response.json().then(errorData => {
							console.error('장바구니 상품 삭제 중 오류 발생:', errorData);
							// 에러 메시지를 표시하거나 다른 조치를 취할 수 있음
						});
					}
				}).catch(error => {
					console.error('장바구니 상품 삭제 중 오류 발생:', error);
				});
				// 추가로 작업이 필요한 경우 이 부분에 작성
				return false;
			}
		}
	</script>
	<jsp:include page="../main/menu.jsp" />
</head>
<body>

<div class="jumbotron" style="background-color: #2c3034; ">
	<div class="container" style="padding:100px;height:200px;">
		<h1 class="display-3" style="color:white;">장바구니</h1>
	</div>
</div>
<div class="container" style="padding-top: 50px;">
	<div class="row">
		<table width="100%">
			<tr>

				<td align="right"><a href="/shippingInfo?cartId=<%= cartId %>" class="btn btn-success">주문하기	</a></td>
			</tr>
		</table>
	</div>
	<div style="padding-top: 50px">
		<table class="table table-hover" style="color:black;">
			<tr>
				<th>상품</th>
				<th>가격</th>
				<th>수량</th>
				<th>소계</th>
				<th>비고</th>
			</tr>
			<%
				int sum = 0;
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");

				if (cartList == null)
					cartList = new ArrayList<Product>();

				for (int i = 0; i < cartList.size(); i++) { // 상품리스트 하나씩 출력하기
					Product product = cartList.get(i);
					int total = product.getUnitPrice() * product.getQuantity();
					sum = sum + total;
			%>
			<tr>
				<td><%=product.getProductId()%> - <%=product.getPname()%></td>
				<td><%=product.getUnitPrice()%></td>
				<td><%=product.getQuantity()%></td>
				<td><%=total%></td>
				<td><a href="#" onclick="removeFromCart('<%= product.getProductId() %>')">삭제</a></td>



			</tr>
			<%
				}
			%>
			<tr>
				<th></th>
				<th></th>
				<th>총액</th>
				<th><%=sum%></th>
				<th></th>
			</tr>
		</table>
		<a href="/products" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
	</div>
	<hr>
</div>
<jsp:include page="../main/footer.jsp" />
</body>
	<%
	}
	%>
</html>
