<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>faq</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/faq.js"></script>
    <link rel="stylesheet" href="/css/faq.css">
</head>
<body>
<jsp:include page="../main/menu.jsp"/>


<!--FAQ-->
<section>
    <h1>FAQ</h1>
    <div>
        <div class="accordion">
            <div class="accordion-item">
                <div class="accordion-item-header">
                    전기차의 장점은 무엇인가요?
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        탄소 및 미세먼지가 없어 환경오염을 최소화하고 휘발유 차량 대비 연료비가 약 90% 정도 절감된다. 또 엔진 및 변속장치가 없어 수선유지비가 적게 들며, 무소음 및 무진동으로 쾌적한 주행환경을 제공합니다.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-item-header">
                    전기차는 전자파가 많이 발생되나요?
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        국립전파연구원에 따르면, 전기차 충전시 발생 전자파는 인체보호 기준대비 0.5% 수준이며 이는 전기면도기(1.59%),대형TV(0.2%),컴퓨터(0.54%)와 유사한 수준입니다.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-item-header">
                    개인용 충전기를 많이 사용하면 누전세도 많이 나오나요?
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        전기차는 전력계통이 가정용과 구분되어 누진제가 적용되지 않습니다.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-item-header">
                    전기차는 몇 년만 타면 배터리를 교체해야 하나요?
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        전기차는 차종별 최대 10년까지 배터리 보증기간을 설정해 두고 있어 배터리 교체에 따른 이용자 부담을 최소화하고 있다. 여기다 제조사별로 다양한 배터리 관련 프로그램을 개발 및 지원하고 있습니다.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-item-header">
                    충전기가 없으면 전기차를 구매하지 못하나요?
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        전기차 충전기는 구매자의 선택사항으로 충전기가 없어도 전기차를 구매할 수 있다. 또 제주도는 전국 최초의 개방형 충전기를 구축하고 있어 자가 충전기 없이도 운행에 큰 불편이 없습니다.
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <div class="accordion-item-header">
                    전기차 방전 등을 대비한 긴급 출동서비스는 없나요?
                </div>
                <div class="accordion-item-body">
                    <div class="accordion-item-body-content">
                        전기차 제조사 및 보험사별로 견인서비스를 제공하고 있으며, 제주도에서 위탁 운영 중인 '제주 EV 콜센터'에서도 긴급구호서비스를 지원하고 있다. 제주 EV 콜센터는 연중무휴로 운영되고 있습니다.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    const accordionItemHeaders = document.querySelectorAll(".accordion-item-header");

    accordionItemHeaders.forEach(accordionItemHeader => {
        accordionItemHeader.addEventListener("click", event => {

            // Uncomment in case you only want to allow for the display of only one collapsed item at a time!

            // const currentlyActiveAccordionItemHeader = document.querySelector(".accordion-item-header.active");
            // if(currentlyActiveAccordionItemHeader && currentlyActiveAccordionItemHeader!==accordionItemHeader) {
            //   currentlyActiveAccordionItemHeader.classList.toggle("active");
            //   currentlyActiveAccordionItemHeader.nextElementSibling.style.maxHeight = 0;
            // }

            accordionItemHeader.classList.toggle("active");
            const accordionItemBody = accordionItemHeader.nextElementSibling;
            if(accordionItemHeader.classList.contains("active")) {
                accordionItemBody.style.maxHeight = accordionItemBody.scrollHeight + "px";
            }
            else {
                accordionItemBody.style.maxHeight = 0;
            }

        });
    });
</script>

</body>
</html>