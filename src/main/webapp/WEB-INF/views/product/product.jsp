<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="kr.co.evcharger.product.dao.ProductRepository"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.evcharger.product.dto.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<%@ include file="../main/dbconn.jsp" %>


<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<title>상품 상세 정보</title>

	<!-- 자바스크립트로 장바구니에 등록하기 위한 핸들러 함수 addToCart() 작성   -->
	<%
		// 기존 장바구니 정보 가져오기
		List<Product> cartList = (List<Product>) session.getAttribute("cartlist");
		//ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");

		// 만약 기존 장바구니 정보가 없으면 새로운 ArrayList 생성
		if (cartList == null) {
			cartList = new ArrayList<Product>();
			session.setAttribute("cartlist", cartList);
		}

		System.out.println("Cart List from Session: " + cartList);

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String targetPId = request.getParameter("p_id");
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, targetPId);
		rs = pstmt.executeQuery();

		// rs.next()를 사용하여 결과가 있는지 확인
		if (rs.next()) {
	%>

	<script type="text/javascript">
		// addToCart 함수 내에서 사용할 장바구니 리스트 선언 및 초기화
		var cartList = ${not empty cartList ? pageContext.getAttribute("cartlist") : '[]'};

		function addToCart() {

			if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
				var productId = '<%= rs.getString("p_id") %>';
				var productName = '<%= rs.getString("p_name") %>';
				var unitPrice = '<%= rs.getString("p_unitPrice") %>';
				var quantity = 1;
				var total = unitPrice * quantity;
				// 클라이언트 측에서 서버로부터 받아온 cartList를 초기화
				cartList = ${not empty cartList ? pageContext.getAttribute("cartlist") : '[]'};
				// 장바구니에 추가하려는 상품이 이미 있는지 확인
				var existingProduct = cartList.find(function (item) {
					return item.productId === productId;
				});

				if (existingProduct) {
					// 이미 있는 경우 수량 증가
					existingProduct.quantity += quantity;
					existingProduct.total = existingProduct.unitPrice * existingProduct.quantity;

				} else {
					// 없는 경우 새로운 상품 추가
					var product = {
						productId: productId,
						pname: productName,
						unitPrice: unitPrice,
						quantity: quantity,
						total: total
					};
					cartList.push(product);
				}

				// 서버에 업데이트된 장바구니 정보 전송
				fetch('/updateCart', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
					},
					body: JSON.stringify(cartList),  // 배열 형식으로 전송
				}).then(response => {
					// 서버 응답 처리 (필요에 따라 추가 작업 수행)
					console.log('장바구니가 성공적으로 업데이트되었습니다');
				}).catch(error => {
					console.error('장바구니 업데이트 중 오류 발생:', error);
				});
				// 추가로 작업이 필요한 경우 이 부분에 작성
				return false;
			}
		}

	</script>

</head>
<body>
<jsp:include page="../main/menu.jsp" />

<div class="jumbotron" style="background-color: #2c3034; ">
	<div class="container" style="padding:100px;height:200px;">
		<h1 class="display-3" style="color:white;">상품정보</h1>
	</div>
</div>
<div class="container" style="padding-top: 50px;">
	<div class="row">
		<div class="col-md-5">
			<img src="/img/<%=rs.getString("p_fileName")%>" style="width: 100%" alt=""/>
		</div>
		<div class="col-md-6" style="color: black;">
			<h3><%=rs.getString("p_name")%></h3>
			<p><%=rs.getString("p_description")%>
			<p><b>상품 코드 : </b><span class="badge badge-danger"> <%=rs.getString("p_id")%></span>
			<p><b>제조사</b> : <%=rs.getString("p_manufacturer")%>
			<h4><%=rs.getString("p_unitPrice")%>원</h4>
			<!-- name과 action 속성 값을 설정하도록 form태그 작성 -->
			<p>
			<form name="addForm" action="/addCart?p_id=<%=rs.getString("p_id")%>" method="post">
				<!-- 상품주문을 클릭하면 핸들러 함수 addToCart()가 실행되도록 onclick 속성 작성 -->
				<a href="#" class="btn btn-info" onclick="addToCart()"> 상품 주문 &raquo;</a>
				<!-- 장바구니 클릭하면 cart.jsp 가 실행되도록 작성 -->
				<a href="/cart" class="btn btn-warning"> 장바구니 &raquo;</a>
				<a href="/products" class="btn btn-secondary"> 상품 목록 &raquo;</a>
			</form>
		</div>
	</div>
	<hr>
</div>
<jsp:include page="../main/footer.jsp" />



</body>
</html>
<%
	} // rs.next() 블록 닫기
%>
