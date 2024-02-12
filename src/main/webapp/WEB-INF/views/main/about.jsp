<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>about</title>

    <link rel="stylesheet" href="/css/about.css">
</head>
<body>
<jsp:include page="../main/menu.jsp" />

<!-- 소개글 -->
<section id="home" class="section">
    <div class="container">
        <div class="content-wrapper text-center">
            <div class="content">
                <h1>물리적 위치 기반의 전기차 충전소 지도 서비스로, <br />사용자들에게 편리하고 신속한 충전소 위치 정보를 제공합니다.</h1>
                <p>"전기차 충전을 더욱 간편하게! <br> 충전 가능한 시간, 속도, 그리고 충전기의 종류를 제공합니다. <br>
                    여행을 떠나기 전에 충전소를 사전에 확인하여 여정을 더욱 원활하게 즐겨보세요"</p>
            </div>
            <img src="/img/charger.png" alt="">
            <a href="https://kr.lovepik.com/images/png-building-energy.html">건물 에너지 Png vectors by Lovepik.com</a>
        </div>
    </div>
</section>
<!-- 소개글 마무리 -->

<!-- 팀소개 시작 -->
<div class="container">
    <h1>Team EZEN NOT NULL</h1>
    <div class="box">
        <div class="imgBx">
            <img src="/img/양병인.png" alt="">
        </div>
        <div class="card-footer">
            <h3>양병인</h3>
            <h3>BACKEND(쇼핑)</h3>
        </div>
    </div>

    <div class="box">
        <div class="imgBx">
            <img src="/img/엄현종.png" alt="">
        </div>
        <div class="card-footer">
            <h3>엄현종</h3>
            <h3>BACKEND(로그인),HTML/CSS</h3>
        </div>
    </div>

    <div class="box">
        <div class="imgBx">
            <img src="/img/김은수.png" alt="">
        </div>
        <div class="card-footer">
            <h3>김은수</h3>
            <h3>BACKEND(게시판)</h3>
        </div>
    </div>

    <div class="box">
        <div class="imgBx">
            <img src="/img/신세연.png" alt="">
        </div>
        <div class="card-footer">
            <h3>신세연</h3>
            <h3>BACKEND(쇼핑)</h3>
        </div>
    </div>

    <div class="box">
        <div class="imgBx">
            <img src="/img/조현아.png" alt="">
        </div>
        <div class="card-footer">
            <h3>조현아</h3>
            <h3>BACKEND(지도)</h3>
        </div>
    </div>

</div>
<!-- 팀소개 마무리 -->


<!-- 프로젝트 과정 -->
<section id="home1">
    <div id="timeline_container">
        <header>
            <figure>
                <img src="/img/logo.png" alt="">
            </figure>
            <h1>프로젝트 과정</h1>
        </header>
        <ul>
            <li class="life_event active">
                <div class="event_icn icon-address"></div>
                <div class="event_content">
                    <h2>요구사항 분석</h2>
                    <p>
                        전기차 충전소 위치, 충전 가능 여부, 전기차 용품 구매가 가능한 쇼핑 카테고리와 커뮤니티 카테고리를 추가하여 전기차 관련 여러 기능을 제공하는 커뮤니티를 만듭니다.
                    </p>
                </div>
                <div class="event_date">
                    2023.12.11
                </div>
            </li>
            <li class="life_event">
                <div class="event_icn icon-address"></div>
                <div class="event_content">
                    <h2>설계 단계</h2>
                    <p>
                        시스템 설계 : 요구사항을 바탕으로 시스템의 구조와 기능을 설계합니다. <br>
                        데이터베이스 구축 : 교통정보를 저장하고 관리할 데이터베이스를 구축합니다.
                    </p>
                </div>
                <div class="event_date">
                    2023.12.13
                </div>
            </li>
            <li class="education_event">
                <div class="event_icn icon-graduation-cap"></div>
                <div class="event_content">
                    <h2>구현 단계</h2>
                    <p>
                        로그인, 회원가입 기능 구현
                    </p>
                </div>
                <div class="event_date">
                    2023.12.17
                </div>
            </li>
            <li class="education_event">
                <div class="event_icn icon-graduation-cap"></div>
                <div class="event_content">
                    <h2>구현 단계</h2>
                    <p>
                        게시판 (작성, 수정, 삭제, 댓글) 기능 구현
                    </p>
                </div>
                <div class="event_date">
                    2023.12.19
                </div>
            </li>
            <li class="education_event">
                <div class="event_icn icon-graduation-cap"></div>
                <div class="event_content">
                    <h2>구현 단계</h2>
                    <p>
                        각 페이지 HTML 완성
                    </p>
                </div>
                <div class="event_date">
                    2023.12.21
                </div>
            </li>
            <li class="education_event">
                <div class="event_icn icon-graduation-cap"></div>
                <div class="event_content">
                    <h2>구현 단계</h2>
                    <p>
                        쇼핑 (상품 목록, 상품 주문, 결제) 기능 구현
                    </p>
                </div>
                <div class="event_date">
                    2023.12.28
                </div>
            </li>

            <li class="user_event">
                <div class="event_icn icon-user"></div>
                <div class="event_content">
                    <h2>시스템 통합</h2>
                    <p>
                        구현한 기능들을 통합합니다.
                    </p>
                </div>
                <div class="event_date">
                    2024.1.2
                </div>
            </li>

            <li class="user_event">
                <div class="event_icn icon-user"></div>
                <div class="event_content">
                    <h2>프로젝트 배포</h2>
                    <p>
                        완성된 프로젝트를 배포합니다.
                    </p>
                </div>
                <div class="event_date">
                    2023.1.4
                </div>
            </li>


            <li class="user_event">
                <div class="event_icn icon-user"></div>
                <div class="event_content">
                    <h2>프로젝트 완성</h2>
                    <ul>
                        <li><a href="https://www.facebook.com/y.srinivasreddy" target="_blank">GITHUB</a></li>
                    </ul>
                </div>
                <div class="event_date">
                    2023.1.5
                </div>
            </li>
        </ul>
    </div><!-- of #timeline_container -->
</section>

</body>
</html>