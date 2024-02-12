<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.evcharger.product.dto.Product"%>
<%@ page import="kr.co.evcharger.product.dao.ProductRepository"%>
<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>
<html>
<head>
	<title>상품 목록</title>
	<link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/css/sidebar.css">
	<link rel="stylesheet" href="/css/products.css">
	<%
		// 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
		MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");
	%>

	<body>
	<%--네비바--%>
	<header class="header">
		<h1 class="logo"><a href="/home">EV CHARGING</a></h1>
		<ul class="main-nav">
			<li><a href="#">About</a></li>
			<li><a href="/charging">Charger</a></li>
			<li><a href="/products">Shopping</a></li>
			<li><a href="/faq">FaQ</a></li>
			<li><a href="/board">Community</a></li>
			<%
				// 로그인하지 않은 경우
				if (loggedInMember == null) {
			%>
			<li><a href="/login">Login</a></li>
			<%
			}else{
			%>
			<li><a href=/logout>Logout</a></li>
			<%
				}
			%>
		</ul>
	</header>
	<%-- 네비바 마무리 --%>

	<%--사이드바 html--%>
	<header class="header1" role="banner" >
		<div class="nav-wrap">
			<nav class="main-nav" role="navigation">
				<ul class="unstyled list-hover-slide">
					<li><a href="/products">ALL</a></li>
					<li><a href="/connector">CONNECTOR</a></li>
					<li><a href="/cover">COVER</a></li>
					<li><a href="/goods">GOODS</a></li>
				</ul>
			</nav>
		</div>
	</header>
</head>

<%--<jsp:include page="../main/menu.jsp" />--%>

<%

	ProductRepository dao = ProductRepository.getInstance();
	ArrayList<Product> listOfProducts = dao.getAllProducts();
%>

<div class="container">
	<div class="row" align="center">
		<%@ include file="../main/dbconn.jsp"%>
		<%

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from product";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
		%>
		<div class="products mb-4">
			<a href="/product?p_id=<%=rs.getString("p_id")%>" class="p_id">
				<img src="/img/<%=rs.getString("p_fileName")%>" style="width: 100%">
			</a>
			<a href="/product?p_id=<%=rs.getString("p_id")%>" class="p_id">
				<h4><%=rs.getString("p_name")%></h4>
				<p><%=rs.getString("p_description")%></p>
				<p><%=rs.getString("p_UnitPrice")%>원</p>
			</a>
		</div>
		<%
			}
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		%>
	</div>
	<hr>
</div>

</body>
</html>