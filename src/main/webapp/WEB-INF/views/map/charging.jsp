<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>KakaoMap Charging Stations</title>
    <meta charset="utf-8" />
    <title>Grayscale - Start Bootstrap Theme</title>
    <link rel="stylesheet" href="/css/charging.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed6a2d937ddda5422df8df2ee47ec786&libraries=services"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>

        // 필터 상태를 저장하는 객체
        let filters = {};
        var selectedRadius = 5; // 기본 반경 값을 5km로 초기화합니다.
        var map;
        var geocoder;
        let globalAddr = '';  // 전역 변수 선언

        // 필터 타입별로 배열 생성
        let filterTypes = ['distance', 'chargeTp', 'cpStat', 'cpTp'];

        filterTypes.forEach(filterType => {
            filters[filterType] = [];
        });
        // 'filter-button1' 클래스를 가진 모든 버튼을 선택합니다.
        const buttons1 = document.querySelectorAll('.filter-button1');

        // 'filter-button1' 클래스를 가진 버튼에 대해 클릭 이벤트 리스너 추가
        buttons1.forEach(button => {
            button.addEventListener('click', () => {
                console.log("distance클릭됨");
                // 현재 버튼과 다른 버튼의 선택 상태를 해제합니다.
                buttons1.forEach(otherButton => {
                    if (otherButton !== button) {
                        otherButton.classList.remove('selected');
                        const otherFilterType = otherButton.id.split('-')[0];
                        filters[otherFilterType] = []; // 다른 버튼의 필터 타입 배열을 비웁니다.
                    }
                });
                // 현재 버튼의 선택 상태를 추가합니다.
                button.classList.add('selected');
                const filterType = button.id.split('-')[0];
                const filterValue = button.dataset.filterValue;
                filters[filterType] = [filterValue]; // 현재 버튼의 필터 값을 설정합니다.
            });
        });


        function initializeMap() {

            var address;
            var urlParams = new URLSearchParams(window.location.search);
            var urlAddress = urlParams.get('searchAddress');
            var searchAddressValue = document.getElementById('searchAddress').value;
            if (searchAddressValue) {
                // 검색 창에서 검색어를 가져옵니다.
                address = searchAddressValue;
            } else if (urlAddress) {
                // URL에서 검색어를 가져옵니다.
                address = urlAddress;
            } else {
                // 둘 다 없는 경우에는 기본값을 사용합니다.
                address = '서울';
            }

            var mapContainer = document.getElementById('map');
            var mapOption = {
                center: new kakao.maps.LatLng(37.5665, 126.9780),
                level: 6
            };
            map = new kakao.maps.Map(mapContainer, mapOption);
            geocoder = new kakao.maps.services.Geocoder();


            // 사용자가 검색을 시작하기 전에 목록을 초기화합니다.
            document.getElementById('list').innerHTML = '';

            geocoder.addressSearch(address, function (result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    map.setCenter(coords);
                    var url = 'https://api.odcloud.kr/api/EvInfoServiceV2/v1/getEvSearchList';

                    // 기존 코드의 일부는 생략하고, 페이지를 순회하는 부분만 추가합니다.
                    for (let page = 1; page <= 5; page++) {
                        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'i7KDhs5d0cqS%2F0uqn3OCoRVpFFdC%2FvHRnv5o9liqwiJ0lW1yUHMTQ7ftsQWKcF7K7KTd71eQPZdnwWf%2FUUyZow%3D%3D'; // 실제 서비스 키로 대체해야 합니다.
                        queryParams += '&' + encodeURIComponent('page') + '=' + encodeURIComponent(page);
                        queryParams += '&' + encodeURIComponent('perPage') + '=' + encodeURIComponent('1000');
                        fetch(url + queryParams)
                            .then(response => response.json())
                            .then(data => {
                                console.log(`Page ${page}:`, data.data);
                                var stations = data.data;
                                var R = 6371; // radius of Earth in km

                                // 필터링 조건이 있는지 확인합니다.
                                var hasFilters = Object.values(filters).some(filterArray => filterArray.length > 0);
                                var filteredStations = hasFilters ? filterStations(stations, filters) : stations;

                                console.log("필터링된 충전소 목록:", filteredStations);
                                console.log("함수내의 필터:", filters);

                                var stationNames = new Set();

                                for (var i = 0; i < filteredStations.length; i++) {
                                    var station = filteredStations[i];
                                    var mlat = station.lat;
                                    var mlong = station.longi;
                                    var dLat = toRad(mlat - result[0].y);
                                    var dLong = toRad(mlong - result[0].x);
                                    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(toRad(result[0].y)) * Math.cos(toRad(mlat)) * Math.sin(dLong / 2) * Math.sin(dLong / 2);
                                    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                                    var d = R * c;
                                    if (d <= selectedRadius) { // distance is less than or equal to 10km
                                        var markerPosition = new kakao.maps.LatLng(mlat, mlong);
                                        var markerImageSrc = '/img/22.png'; // 마커 이미지 URL
                                        var markerImageSize = new kakao.maps.Size(130, 45); // 마커 이미지의 크기
                                        var markerImage = new kakao.maps.MarkerImage(markerImageSrc, markerImageSize);


                                        var marker = new kakao.maps.Marker({
                                            position: markerPosition,
                                            map: map,
                                            image: markerImage
                                        });

                                        var overlayContent = '<div style="font-size:9px;font-weight:bold;margin-bottom:42px;color: black;">' + station.csNm + '</div>'
                                        var overlay = new kakao.maps.CustomOverlay({
                                            position: markerPosition,
                                            content: overlayContent,
                                            map: map
                                        });


                                        // 충전소의 각 정보를 데이터 속성으로 저장하는 예
                                        if (!stationNames.has(station.csNm)) {
                                            stationNames.add(station.csNm);
                                            var stationElement = document.createElement('div');
                                            // 기타 정보를 데이터 속성으로 저장
                                            globalAddr = station.addr;
                                            stationElement.dataset.addr = station.addr;
                                            stationElement.dataset.chargeTp = station.chargeTp;
                                            stationElement.dataset.cpStat = station.cpStat;
                                            stationElement.dataset.lat = station.lat;
                                            stationElement.dataset.longi = station.longi;
                                            stationElement.dataset.cpTp = station.cpTp;
                                            stationElement.dataset.statUpdatetime = station.statUpdatetime;
                                            stationElement.dataset.csNm = station.csNm;


                                            // 충전소 이름과 아이콘 추가
                                            var iconElement = document.createElement('i');
                                            iconElement.className = 'fa-solid fa-route';
                                            stationElement.appendChild(iconElement);


                                            // 충전소 이름 추가
                                            var nameNode = document.createTextNode(station.csNm); // 충전소 이름과 구분자를 추가합니다.
                                            var nameSpan = document.createElement('span'); // 이름을 넣을 span 요소 생성
                                            nameSpan.appendChild(nameNode);
                                            nameSpan.style.fontSize = "20px"; // 이름에 대한 CSS 적용
                                            nameSpan.style.fontWeight = "bold";
                                            nameSpan.style.marginLeft = "-20px";
                                            stationElement.appendChild(nameSpan); // 이름을 stationElement에 추가
                                            stationElement.appendChild(document.createElement('br'));




                                            var addrNode = document.createTextNode(station.addr); // 충전소 주소 텍스트 노드를 생성합니다.
                                            var addrSpan = document.createElement('span'); // 주소를 넣을 span 요소 생성
                                            addrSpan.appendChild(addrNode);
                                            addrSpan.style.fontSize = "14px"; // 주소에 대한 CSS 적용
                                            addrSpan.style.marginLeft = "5px";


                                            if (station.addr.length > 9) {
                                                var addrSpan = document.createElement('span');
                                                var shortSpan = document.createElement('span');
                                                var icon = document.createElement('i'); // Font Awesome 아이콘을 위한 i 요소 생성
                                                icon.className = 'fa-solid fa-angle-down'; // 아이콘 클래스 적용

                                                addrSpan.appendChild(document.createTextNode(station.addr));
                                                shortSpan.appendChild(document.createTextNode(station.addr.substring(0, 9) + " "));
                                                shortSpan.appendChild(icon); // 아이콘 추가

                                                addrSpan.style.display = 'none';
                                                addrSpan.style.fontSize = '14px';
                                                shortSpan.style.fontSize = '14px';

                                                (function(addrSpan, shortSpan) {
                                                    shortSpan.onclick = function() {
                                                        shortSpan.style.display = 'none';
                                                        addrSpan.style.display = 'inline';
                                                    };

                                                    addrSpan.onclick = function() {
                                                        addrSpan.style.display = 'none';
                                                        shortSpan.style.display = 'inline';
                                                    };
                                                })(addrSpan, shortSpan);

                                                stationElement.appendChild(shortSpan);
                                                stationElement.appendChild(addrSpan);
                                            }

                                            stationElement.appendChild(addrSpan); // 주소를 stationElement에 추가
                                            stationElement.className = 'station';
                                            document.getElementById('list').appendChild(stationElement);

                                        }
                                    }
                                }
                            })
                            .catch(error => {
                                alert('API 요청에 실패했습니다.');
                            });
                    }


                    // 슬라이더 아이콘에 대한 이벤트 리스너
                    document.querySelector('.fa-sliders').addEventListener('click', function() {
                        console.log('슬라이더 아이콘이 클릭되었습니다.');
                        var bottomSidebar = document.getElementById('bottomSidebar');
                        bottomSidebar.classList.toggle('active'); // active 클래스를 토글합니다.
                    });

                    // 닫기 버튼에 대한 이벤트 리스너
                    document.querySelector('#closeSidebarBtn').addEventListener('click', function() {
                        console.log("슬라이더 닫기")
                        var bottomSidebar = document.getElementById('bottomSidebar');
                        bottomSidebar.classList.remove('active'); // active 클래스를 제거하여 닫습니다.
                    });


                    // 추가: 현재 위치 아이콘 클릭 시 현재 위치 가져와서 주소 설정 및 지도 초기화
                    document.getElementById('currentLocationIcon').addEventListener('click', function() {
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(function(position) {
                                const latitude = position.coords.latitude;
                                const longitude = position.coords.longitude;
                                const geocoder = new kakao.maps.services.Geocoder();

                                geocoder.coord2Address(longitude, latitude, function(result, status) {
                                    if (status === kakao.maps.services.Status.OK) {
                                        const currentAddress = result[0].address.address_name;

                                        document.getElementById('searchAddress').value = currentAddress;
                                        initializeMap(); // 지도 초기화
                                    } else {
                                        alert('현재 위치의 주소를 찾을 수 없습니다.');
                                    }
                                });
                            }, function(error) {
                                alert('현재 위치를 가져오는 데 실패했습니다.');
                            });
                        } else {
                            alert('이 브라우저는 Geolocation을 지원하지 않습니다.');
                        }
                    });

                } else {
                    alert('검색 결과가 없거나 에러가 발생했습니다.');
                }
            });
        }

        function filterStations(stations, filters) {

            console.log('현재 적용된 필터 조건:', filters);

            return stations.filter(station => {
                // 충전 타입 필터링
                if (filters.chargeTp.length > 0 && !filters.chargeTp.includes(station.chargeTp)) {
                    return false;
                }

                // 충전 가능 여부 필터링
                if (filters.cpStat.length > 0 && !filters.cpStat.includes(station.cpStat)) {
                    return false;
                }

                // 커넥터 타입 필터링
                // 커넥터 타입은 여러 값을 포함할 수 있으므로, split을 사용해 배열로 만든 후 some 메서드로 확인
                if (filters.cpTp.length > 0) {
                    const cpTpValues = station.cpTp.split(' '); // 예를 들어 '1 3 4' => ['1', '3', '4']
                    if (!filters.cpTp.some(cpTp => cpTpValues.includes(cpTp))) {
                        return false;
                    }
                }

                return true; // 모든 필터 조건을 통과한 경우

            });
        }



        function toRad(Value) {
            return Value * Math.PI / 180;
        }

        window.addEventListener('DOMContentLoaded', (event) => {
            initializeMap();

            const additionalSidebar = document.querySelector('.additionalSidebar');
            const additionalSidebarContent = document.querySelector('.additionalSidebar div');

            // 사이드바 목록 클릭 시 새로운 사이드바 보이기
            const sidebar = document.getElementById('sidebar');

            sidebar.addEventListener('click', function(event) {
                console.log("사이드바 클릭됨")

                // 출발지와 도착지 입력창의 값을 초기화합니다.
                document.querySelector('#departure').value = '';
                document.querySelector('#destination').value = '';

                if (event.target.classList.contains('station')) {
                    const stationElement = event.target;
                    globalAddr = stationElement.dataset.addr;
                    const chargeTp = stationElement.dataset.chargeTp;
                    const cpStat = stationElement.dataset.cpStat;
                    const cpTp = stationElement.dataset.cpTp;
                    const statUpdatetime = stationElement.dataset.statUpdatetime; // 상태 업데이트 시간
                    const lat = event.target.dataset.lat; // 위도
                    const lng = event.target.dataset.longi; // 경도
                    const csNm = stationElement.dataset.csNm;

                    // 이제 가져온 데이터를 additionalSidebar에 표시합니다.
                    // 추가 사이드바 내부의 해당 요소들을 선택합니다.
                    const addressTextElement = additionalSidebar.querySelector('#addressText');
                    const chargeTypeTextElement = additionalSidebar.querySelector('#chargeTypeText');
                    const cpStatusTextElement = additionalSidebar.querySelector('#cpStatusText');
                    const updateTimeTextElement = additionalSidebar.querySelector('#updateTimeText'); // 상태
                    const chargingPortTypeTextElement = additionalSidebar.querySelector('#chargingPortTypeText');
                    const stationNameTextElement = additionalSidebar.querySelector('#stationNameText');

                    stationNameTextElement.textContent = csNm;

                    // 텍스트 내용을 업데이트합니다.
                    if (addressTextElement) addressTextElement.textContent = globalAddr;
                    if (chargeTypeTextElement) {
                        // chargeTp 값에 따라 텍스트 내용을 '완속' 또는 '급속'으로 설정
                        if (chargeTp == '1') {
                            chargeTypeTextElement.textContent = '완속';
                        } else if (chargeTp == '2') {
                            chargeTypeTextElement.textContent = '급속';
                        }
                    }

                    if (chargingPortTypeTextElement) {
                        switch (cpTp) {
                            case '1':
                                chargingPortTypeTextElement.textContent = 'B타입(5핀)';
                                break;
                            case '2':
                                chargingPortTypeTextElement.textContent = 'C타입(5핀)';
                                break;
                            case '3':
                                chargingPortTypeTextElement.textContent = 'BC타입(5핀)';
                                break;
                            case '4':
                                chargingPortTypeTextElement.textContent = 'BC타입(7핀)';
                                break;
                            case '5':
                                chargingPortTypeTextElement.textContent = 'DC차 데모';
                                break;
                            case '6':
                                chargingPortTypeTextElement.textContent = 'AC3상';
                                break;
                            case '7':
                                chargingPortTypeTextElement.textContent = 'DC콤보';
                                break;
                            case '8':
                                chargingPortTypeTextElement.textContent = 'DC차데모+DC콤보';
                                break;
                            case '9':
                                chargingPortTypeTextElement.textContent = 'DC차데모+AC3상';
                                break;
                            case '10':
                                chargingPortTypeTextElement.textContent = 'DC차데모+DC콤보+AC3상';
                                break;
                            default:
                                chargingPortTypeTextElement.textContent = '알 수 없는 타입';
                                break;
                        }
                    }

                    if (cpStatusTextElement) {
                        // cpStat 값에 따라 텍스트 내용을 설정
                        switch (cpStat) {
                            case '0':
                                cpStatusTextElement.textContent = '상태확인불가';
                                break;
                            case '1':
                                cpStatusTextElement.textContent = '충전가능';
                                break;
                            case '2':
                                cpStatusTextElement.textContent = '충전중';
                                break;
                            case '3':
                                cpStatusTextElement.textContent = '고장/점검';
                                break;
                            case '4':
                                cpStatusTextElement.textContent = '통신장애';
                                break;
                            case '9':
                                cpStatusTextElement.textContent = '충전예약';
                                break;
                            default:
                                cpStatusTextElement.textContent = '알 수 없는 상태';
                                break;
                        }

                    }

                    if (updateTimeTextElement) updateTimeTextElement.textContent = statUpdatetime;

                    /*additionalSidebarContent.textContent = stationName;*/
                    additionalSidebarContent.className = 'station-name'; // 클래스 추가
                    additionalSidebar.style.display = 'block'; // 사이드바 보이기

                    // 로드뷰 컨테이너가 존재하는지 확인하고, 없으면 생성
                    let roadviewContainer = document.querySelector('.roadview');
                    if (!roadviewContainer) {
                        roadviewContainer = document.createElement('div');
                        roadviewContainer.className = 'roadview';
                        additionalSidebar.appendChild(roadviewContainer);
                    }

                    // 로드뷰 객체 생성
                    const roadview = new kakao.maps.Roadview(roadviewContainer);
                    const roadviewClient = new kakao.maps.RoadviewClient();

                    // 좌표 객체 생성
                    const position = new kakao.maps.LatLng(lat, lng);

                    // 가장 가까운 로드뷰 좌표를 찾기
                    roadviewClient.getNearestPanoId(position, 100, function(panoId) {
                        if (panoId === null) {
                            roadviewContainer.textContent = '가까운 로드뷰가 없습니다.';
                        } else {
                            // 로드뷰를 해당 좌표로 이동
                            roadview.setPanoId(panoId, position);
                        }
                    });

                }
            });

            function convertAddressToCoordinates(address, callback) {
                var apiUrl = 'https://dapi.kakao.com/v2/local/search/address.json?query=' + encodeURIComponent(address);

                $.ajax({
                    url: apiUrl,
                    type: 'GET',
                    headers: {
                        'Authorization': 'KakaoAK ' + '89860aca1b419fbbe393433c901cb889'
                    },
                    success: function(result) {
                        // 첫번째 결과의 좌표를 가져옵니다.
                        var coordinates = result.documents[0].x + ',' + result.documents[0].y;
                        callback(coordinates);
                        console.log(coordinates);
                    }
                });
            }

            var markers = [];
            var polyline;

            document.querySelector('#findroad').addEventListener('click', function() {
                var inputDeparture = document.getElementById('departure').value;
                var inputDestination = document.getElementById('destination').value;

                convertAddressToCoordinates(inputDeparture, function(departure) {
                    convertAddressToCoordinates(inputDestination, function (destination) {
                        var apiUrl = 'https://apis-navi.kakaomobility.com/v1/directions?origin=' + departure + '&destination=' + destination;

                        $.ajax({
                            url: apiUrl,
                            type: 'GET',
                            headers: {
                                'Authorization': 'KakaoAK ' + '89860aca1b419fbbe393433c901cb889'
                            },
                            success: function(result){
                                // 기존의 마커와 폴리라인 제거
                                markers.forEach(function(marker) {
                                    marker.setMap(null);
                                });
                                markers = [];
                                if (polyline) {
                                    polyline.setMap(null);
                                    polyline = null;
                                }

                                console.log("결과",result);
                                var coords = new kakao.maps.LatLng(result.routes[0].summary.origin.y, result.routes[0].summary.origin.x);
                                var marker = new kakao.maps.Marker({ map: map, position: coords });
                                markers.push(marker);
                                map.setCenter(coords);

                                var coords2 = new kakao.maps.LatLng(result.routes[0].summary.destination.y, result.routes[0].summary.destination.x);
                                var marker2 = new kakao.maps.Marker({ map: map, position: coords2 });
                                markers.push(marker2);

                                // 경로 그리기
                                var linePath = [];
                                if (result.routes[0].sections[0].guides) {
                                    var guides = result.routes[0].sections[0].guides;
                                    for (var i = 0; i < guides.length; i++) {
                                        var position = guides[i];
                                        linePath.push(new kakao.maps.LatLng(position.y, position.x));
                                    }
                                } else {
                                    console.log("Guides is undefined");
                                }

                                polyline = new kakao.maps.Polyline({
                                    path: linePath,
                                    strokeWeight: 6,
                                    strokeColor: '#FF0000',
                                    strokeOpacity: 1,
                                    strokeStyle: 'solid'
                                });

                                polyline.setMap(map);
                            }
                        });
                    });
                });
            });



            // 출발지와 도착지 주소를 저장할 변수를 선언합니다.
            let departureAddr = null;
            let destinationAddr = null;

            // '출발' 버튼 클릭 이벤트 리스너를 추가합니다.
            document.querySelector('#location-departure').addEventListener('click', function() {
                console.log("출발클릭됨");
                // 사이드바에서 선택된 주소를 출발지 주소로 설정합니다.
                departureAddr = globalAddr;
                console.log('출발지 주소 설정:', departureAddr);

                // 출발지 입력창에 주소 표시
                document.querySelector('#departure').value = departureAddr;
            });

            // '도착' 버튼 클릭 이벤트 리스너를 추가합니다.
            document.querySelector('#location-destination').addEventListener('click', function() {
                console.log("도착클릭됨");
                // 사이드바에서 선택된 주소를 도착지 주소로 설정합니다.
                destinationAddr = globalAddr;
                console.log('도착지 주소 설정:', destinationAddr);

                // 도착지 입력창에 주소 표시
                document.querySelector('#destination').value = destinationAddr;
            });



            // 새로운 사이드바의 'x' 버튼 클릭 시 숨기기
            const closeBtn = document.querySelector('.additionalSidebar .closeBtn');
            closeBtn.addEventListener('click', function() {
                additionalSidebar.style.display = 'none'; // 사이드바 숨기기
            });
        });

    </script>

</head>

<body>
<jsp:include page="../main/menu.jsp"/>

<div id="sky-blue-box">
    <div class="charging-text">충전소 찾기</div>
    <div class="charging-text2">전국 어디서든 충전이 필요할 떈 가장 가까운 충전소를 확인하세요.</div>
</div>

<div id="sidebar">
    <i class="fa-solid fa-sliders"></i>
    <i id="currentLocationIcon" class="fa-solid fa-location-crosshairs"></i>
    <button id="toggleButton">
        <span id="openArrow"><i class="fa-solid fa-angle-right"></i></span> <!-- 사이드바가 접혀 있을 때의 화살표 -->
        <span id="closeArrow"><i class="fa-solid fa-angle-left"></i></span> <!-- 사이드바가 펼쳐져 있을 때의 화살표 -->
    </button>

    <div id="bottomSidebar" class="bottomSidebar">

        <div id="ChargingStationFilters">충전소 탐색 필터</div>
        <hr>
        <div id="distance-filters">
            <div class="filter-text">탐색 반경</div>
            <div>
                <button class="filter-button1" id="distance-1km" data-filter-value="1">1km</button> <%--1--%>
                <button class="filter-button1" id="distance-2km" data-filter-value="2">2km</button><%--2--%>
                <button class="filter-button1" id="distance-3km" data-filter-value="3">3km</button><%--3--%>
                <button class="filter-button1" id="distance-5km" data-filter-value="5">5km</button><%--5--%>
                <button class="filter-button1" id="distance-10km" data-filter-value="10">10km</button><%--10--%>
            </div>
        </div>

        <div id="charge-type-filters">
            <div class="filter-text">충전 속도</div>
            <div>
                <button class="filter-button" id="chargeTp-1" data-filter-value="1">완속</button> <%--1--%>
                <button class="filter-button" id="chargeTp-2" data-filter-value="2">급속</button> <%--2--%>
            </div>
        </div>

        <div id="cpStat-filters">
            <div class="filter-text">충전 가능 여부</div>
            <div>
                <button class="filter-button" id="cpStat-1" data-filter-value="1">충전가능</button> <%--1--%>
            </div>
        </div>

        <div id="cpTp-filters">
            <div class="filter-text">커넥터 타입</div>
            <div>
                <button class="filter-button" id="cpTp-B" data-filter-value="1 3 4">B타입</button> <%--1,3,4--%>
                <button class="filter-button" id="cpTp-C" data-filter-value="2 3 4">C타입</button> <%--2,3,4--%>
                <button class="filter-button" id="cpTp-DC" data-filter-value="7 8 10">DC콤보</button> <%--7,8,10--%>
                <button class="filter-button" id="cpTp-DC1" data-filter-value="5 8 9 10">차데모</button> <%--5,8,9,10--%>
                <button class="filter-button" id="cpTp-AC" data-filter-value="6 9 10">AC3상</button> <%--6,9,10--%>
            </div>
        </div>

        <hr id="lastLine">
        <button  id="resetFilters">선택 초기화</button>
        <button  id="searchStations">충전소 찾기</button>


        <button id="closeSidebarBtn">
            <i class="fa-solid fa-xmark"></i>
        </button>
    </div>

    <div id="content">

        <div id="search-container">
            <label for="searchAddress"></label>
            <input type="text" id="searchAddress" placeholder="지역명을 입력하세요">
            <button id="searchButton" onclick="initializeMap()">검색</button>
        </div>


        <div id="list" style="overflow: auto; height: 600px; margin-top: 60px; margin-left:0px;"></div>

    </div>
</div>

<div class="additionalSidebar">
    <div id="stationNameText"></div>
    <div class="roadview"></div>
    <div>새로운 사이드바</div>

    <div class="star" id="location-departure">
        <i class="fa-solid fa-location-dot"></i>
        <span>출발</span>
    </div>
    <div class="nevi" id="location-destination">
        <i class="fa-solid fa-location-dot"></i>
        <span>도착</span>
    </div>

    <div class="input-container">
        <label for="departure"></label>
        <input type="text" id="departure" name="departure" placeholder="출발지를 입력하세요">

        <label for="destination"></label>
        <input type="text" id="destination" name="destination" placeholder="도착지를 입력하세요">

        <button id="findroad" type="submit">길찾기 > </button>
    </div>

    <div class="middle-contents">
        <div class="content-item">
            <i class="fa-solid fa-location-dot"></i>
            <span id="addressText"></span> <!-- 주소 정보 -->
        </div>
        <div class="content-item">
            <i class="fa-solid fa-bolt"></i>
            <span id="chargeTypeText"></span> <span id="chargingPortTypeText"></span> <!-- 충전 타입 정보 -->
        </div>
        <div class="content-item">
            <i class="fa-solid fa-charging-station"></i>
            <span id="cpStatusText"></span> <!-- 충전소 상태 정보 -->
        </div>
        <div class="content-item">
            <i class="fa-solid fa-circle-info"></i>
            <span id="updateTimeText"></span> <!-- 상태 업데이트 시간 정보 -->
        </div>
    </div>

    <button class="closeBtn"><i class="fa-solid fa-xmark"></i></button>
</div>

<div id="map-container">
    <div id="map"></div>
</div>



<script>

    window.addEventListener('DOMContentLoaded', (event) => {
        const toggleButton = document.getElementById('toggleButton');
        const openArrow = document.getElementById('openArrow');
        const closeArrow = document.getElementById('closeArrow');

        // 페이지가 로드되었을 때의 기본 상태를 설정합니다.
        openArrow.style.display = 'none';
        closeArrow.style.display = 'inline';

        toggleButton.addEventListener('click', function() {
            var sidebar = document.getElementById('sidebar');
            if (sidebar.style.transform === "translateX(-100%)") {
                sidebar.style.transform = "translateX(0)";
                this.style.right = "0px";
                openArrow.style.display = 'none';
                closeArrow.style.display = 'inline';
            } else {
                sidebar.style.transform = "translateX(-100%)";
                this.style.right = "-30px";
                openArrow.style.display = 'inline';
                closeArrow.style.display = 'none';
            }
        });


        // distance 버튼
        document.querySelectorAll('.filter-button1').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.filter-button1').forEach(otherButton => {
                    otherButton.classList.remove('selected');
                });

                this.classList.add('selected');
                selectedRadius = parseInt(this.getAttribute('data-filter-value'));
            });
        });

        // 각 필터 버튼에 대한 클릭 이벤트 리스너
        document.querySelectorAll('.filter-button').forEach(button => {
            button.addEventListener('click', (event) => {
                const filterType = event.target.id.split('-')[0];
                const filterValues = event.target.dataset.filterValue.split(' ');

                // 기존 필터 값을 토글합니다.
                filterValues.forEach(filterValue => {
                    const index = filters[filterType].indexOf(filterValue);
                    if (index > -1) {
                        filters[filterType].splice(index, 1); // 필터 값 제거
                        button.classList.remove('selected');
                    } else {
                        filters[filterType].push(filterValue); // 필터 값 추가
                        button.classList.add('selected');
                    }
                });
                // 적용된 필터를 콘솔에서 확인합니다.
                console.log(`적용된 필터 [${filterType}]:`, filters[filterType]);
            });
        });
        // '충전소 찾기' 버튼 클릭 리스너
        document.getElementById('searchStations').addEventListener('click', () => {
            console.log('모든 적용된 필터:', filters);
            // 필터링된 충전소 데이터를 가져와 지도를 업데이트합니다.
            initializeMap(); // 필터링 조건이 적용된 상태로 지도를 다시 로드합니다.
            var bottomSidebar = document.getElementById('bottomSidebar');
            bottomSidebar.classList.toggle('active'); // active 클래스를 토글합니다.
        });

        // 선택 초기화 버튼에 클릭 이벤트 추가
        document.querySelector('#resetFilters').addEventListener('click', () => {
            filterTypes.forEach(filterType => {
                filters[filterType] = [];
            });

            ['.filter-button', '.filter-button1'].forEach(selector => {
                document.querySelectorAll(selector).forEach(button => {
                    button.classList.remove('selected');
                });
            });
        });

    });






</script>




</body>
</html>
