<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.evcharger.product.dto.Product"%>
<%@ page import="kr.co.evcharger.product.dao.ProductRepository"%>
<%@ page import="kr.co.evcharger.member.dto.MemberDTO" %>

<html>
<head>
    <link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/css/sidebar.css">

    <title>상품 목록</title>
    <style>


        *{
            font-family: 'Raleway', sans-serif;

        }

        .products {

            flex: 0 0 33%;
            width: 33%;
            padding: 20px
        }
        .container{
            position: fixed;
            top: 300px;
            left: 500px;


        }



        /*네비바*/
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Raleway', sans-serif;

        }

        header {
            z-index: 99;

        }

        ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        h2,
        h3,
        a {
            color: #34495e;
        }

        .header a {
            text-decoration: none;
        }

        .logo {
            margin: 0;
            font-size: 1.45em;
        }

        .main-nav {
            margin-top: 5px ;

        }

        .logo a,
        .main-nav a {
            padding: 10px 15px;
            text-transform: uppercase;
            text-align: center;
            display: block;
            font-weight: bold;
            font-size: 1em;
        }

        .main-nav a {
            color: #34495e;


        }

        .main-nav a:hover {
            color: #718daa;
        }

        .header {
            padding-top: 13px;
            padding-bottom: 12px;
            border: 1px solid #a2a2a2;
            background-color: #f4f4f4;
            -webkit-box-shadow: 0px 0px 14px 0px rgba(0,0,0,0.75);
            -moz-box-shadow: 0px 0px 14px 0px rgba(0,0,0,0.75);
            box-shadow: 0px 0px 14px 0px rgba(0,0,0,0.75);
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            position: absolute;
            top: 0;
            /* width: 100% */
            left: 0;
            right: 0;

        }

        @media (min-width: 769px) {
            .header,
            .main-nav {
                display: flex;
            }
            .header {
                flex-direction: column;
                align-items: center;
                .header{
                    width: 80%;
                    margin: 0 auto;
                    max-width: 1150px;
                }
            }

        }

        @media (min-width: 1025px) {
            .header {
                flex-direction: row;
                justify-content: space-between;

            }

        }
        /*네비바 마무리*/
    </style>
    <%
        // 세션에서 "loggedInMember" 속성을 가져와서 로그인 여부 확인
        MemberDTO loggedInMember = (MemberDTO) session.getAttribute("loggedInMember");
    %>

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


    <%--<jsp:include page="../main/menu.jsp" />--%>
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
            <%--			<ul class="social-links list-inline unstyled list-hover-slide">--%>
            <%--				<li><a href="${pageContext.request.contextPath}/products">상품목록</a></li>--%>
            <%--				<li><a href="/addProduct">상품등록</a></li>--%>
            <%--				<li><a href="${pageContext.request.contextPath}/editProduct">상품수정</a></li>--%>
            <%--				<li><a href="${pageContext.request.contextPath}/deleteProduct">상품삭제</a></li>--%>
            <%--			</ul>--%>
        </div>
    </header>
</head>
<body>


<%
    ProductRepository dao = ProductRepository.getInstance();
    ArrayList<Product> listOfProducts = dao.getAllProducts();
%>

<div class="container">
    <div class="row" align="center">
        <%@ include file="../main/dbconn.jsp"%>

        <%
            // SQL 쿼리를 통한 p_type이 1인 행만 출력
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String sql = "select * from product where p_type = 1";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
        %>
        <div class="products mb-4">
            <a href="./product?p_id=<%=rs.getString("p_id")%>" class="p_id">
                <img src="/img/<%=rs.getString("p_fileName")%>" style="width: 100%">
            </a>
            <a href="./product?p_id=<%=rs.getString("p_id")%>" class="p_id">
                <h3><%=rs.getString("p_name")%></h3>
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