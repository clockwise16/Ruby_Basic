180711

# Sample-Map

* scaffold 이용

  ```ruby
  $ rails g scaffold map name lat:float lon:float
  $ rake db:migrate
  ```



* 위도 경도에 맞는 다음 지도 보이기

  ```html
  # maps => show.html.erb
  <p>
    <strong>Lon:</strong>
    <%= @map.lon %>
  </p>
  
  <div id="map" style="width:500px;height:400px;"></div>
  
  <script>
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
    	center: new daum.maps.LatLng(<%= @map.lat %>, <%= @map.lon %>), //지도의 중심좌표.
    	level: 3 //지도의 레벨(확대, 축소 정도)
    };
    
    var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴  
  </script>
  
  <%= link_to 'Edit', edit_map_path(@map) %> |
  <%= link_to 'Back', maps_path %>
  ```

  ```html
  # layouts => application.html.erb => head 부분에 넣는다, 그래야 가장 먼저 빠르게 지도를 그려준다.
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 APP KEY를 넣으시면 됩니다."></script>
  
  # 발급받은 JavaScript 키를 삽입 해준다, b2b01215c65b9e7cc86279cb7424f670 
  ```

  

* 카카오 developers 가입 후

  일반 => 플랫폼 추가 https://developers.kakao.com/apps/211365/settings/general 

  사이트 도메인입력 https://sample-map-clockwise16.c9users.io/ 



* 지도에 마커 표시 하기

  ```html
  # maps => show.html.erb
    var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴  
  
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
            center: new daum.maps.LatLng(<%= @map.lat %>, <%= @map.lon %>), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };
    
    var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
    
    // 지도를 클릭한 위치에 표출할 마커입니다
    var marker = new daum.maps.Marker({ 
        // 지도 중심좌표에 마커를 생성합니다 
        position: map.getCenter() 
    }); 
    // 지도에 마커를 표시합니다
    marker.setMap(map);
    
    // 지도에 클릭 이벤트를 등록합니다
    // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
    daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
        
        // 클릭한 위도, 경도 정보를 가져옵니다 
        var latlng = mouseEvent.latLng; 
        
        // 마커 위치를 클릭한 위치로 옮깁니다
        marker.setPosition(latlng);
        
        var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
        message += '경도는 ' + latlng.getLng() + ' 입니다';
        
        var resultDiv = document.getElementById('clickLatlng'); 
        resultDiv.innerHTML = message;
        
    });
  
  </script>
  ```

  다음 지도 API 참고 : http://apis.map.daum.net/web/sample/dragCustomOverlay/
  
