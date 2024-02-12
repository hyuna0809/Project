<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Kakao Maps API</title>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed6a2d937ddda5422df8df2ee47ec786&libraries=services"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <style>
    #map {
      width: 100%;
      height: 400px;
    }
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid #dddddd;
      text-align: left;
      padding: 8px;
    }
    th {
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>
<div id="map"></div>
<table id="routeInfo">
  <tr>
    <th>Name</th>
    <th>X 좌표(경도)</th>
    <th>Y 좌표(위도)</th>
  </tr>
</table>

<script>
  // 카카오맵 API 키 설정
  const KAKAO_MAPS_API_KEY = '89860aca1b419fbbe393433c901cb889';

  // 카카오맵 API 로드
  kakao.maps.load(() => {
    const mapContainer = document.getElementById('map');
    const mapOptions = {
      center: new kakao.maps.LatLng(37.5, 127), // 지도 중심 좌표
      level: 5 // 확대 수준
    };
    const map = new kakao.maps.Map(mapContainer, mapOptions);

    // API 호출 및 지도에 표시하는 함수
    function displayRoute() {
      const origin = '127.111202,37.394912'; // 서울의 좌표 (위도, 경도)
      const destination = '127.0276,37.4979'; // 강남의 좌표 (위도, 경도)

      const apiUrl = 'https://apis-navi.kakaomobility.com/v1/directions?origin=' + origin + '&destination=' + destination;
      // 다른 파라미터 추가

      $.ajax({
        method: 'GET',
        url: apiUrl,
        headers: {
          Authorization: 'KakaoAK ' + KAKAO_MAPS_API_KEY
        },
        success: function (response) {
          console.log(response);
          const route = response.routes[0]; // 첫 번째 경로 정보 가져오기

          // 콘솔에 도로의 꼭짓점 좌표 출력
          route.sections.forEach((section) => {
            section.roads.forEach((road) => {
              /*console.log("도로의 꼭짓점 좌표:", road.vertexes);*/
            });
          });

          // Polyline 그리기
          const path = route.sections.reduce((points, section) => {
            section.roads.forEach((road) => {
              for (let i = 0; i < road.vertexes.length; i += 2) {
                const longitude = road.vertexes[i]; // 경도
                const latitude = road.vertexes[i + 1]; // 위도

                // 좌표를 kakao.maps.LatLng 객체로 변환하여 points 배열에 추가
                points.push(new kakao.maps.LatLng(latitude, longitude));
              }
            });
            return points;
          }, []);



          console.log("패스:", path);
          const polyline = new kakao.maps.Polyline({
            path: path,
            strokeWeight: 5,
            strokeColor: '#FF0000',
            strokeOpacity: 0.7,
            strokeStyle: 'solid'
          });
          polyline.setMap(map);

          // 출발지, 목적지 마커 표시
          const start = new kakao.maps.LatLng(route.summary.origin.y, route.summary.origin.x);
          const end = new kakao.maps.LatLng(route.summary.destination.y, route.summary.destination.x);
          const startMarker = new kakao.maps.Marker({ position: start, map: map });
          const endMarker = new kakao.maps.Marker({ position: end, map: map });

          // 경로 정보 테이블에 추가
          const routeInfoTable = document.getElementById('routeInfo');
          const startRow = routeInfoTable.insertRow();
          const cell1 = startRow.insertCell(0);
          const cell2 = startRow.insertCell(1);
          const cell3 = startRow.insertCell(2);
          cell1.innerHTML = route.summary.origin.name;
          cell2.innerHTML = route.summary.origin.x;
          cell3.innerHTML = route.summary.origin.y;

          const endRow = routeInfoTable.insertRow();
          const cell4 = endRow.insertCell(0);
          const cell5 = endRow.insertCell(1);
          const cell6 = endRow.insertCell(2);
          cell4.innerHTML = route.summary.destination.name;
          cell5.innerHTML = route.summary.destination.x;
          cell6.innerHTML = route.summary.destination.y;
        },
        error: function () {
          // API 호출 실패 시 처리
          alert('Failed to fetch data from Kakao API');
        }
      });
    }

    // displayRoute 함수 호출
    displayRoute();
  });
</script>
</body>
</html>
