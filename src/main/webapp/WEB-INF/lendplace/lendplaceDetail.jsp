<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/common-header.jspf" %>
<link rel="stylesheet"  type="text/css" href="<c:url value="/resources/css/meetings.detail.css"/>">
<script type="text/javascript">

</script>
</head>
<body>
<table width=930px border="0" align=center>
<tr>
<td>

<table style="width:100%;" border="0">
	<tr>
		<td style="font-weight: bold;font-size: large;font-family: sans-serif;">장소 상세보기</td>
		<td align="right"><input type="button" value="목록보기" onclick="location.href='<c:url value="/lendplace?currentPageNo=${currentPageNo}"/>'"></td>
	</tr>
</table>

<table class="md_header_table">
<tr>

<td width="15%" class="md_header_table_td1">
<div><img class="md_header" src="${data.L_REP_IMG }" ></div>
</td>

<td width="85%" class="md_header_table_td2">

<div class="md_header_subject">${data.L_TITLE }</div>
<br>
<table border="0">
<tr>
<td>주소 : ${data.L_ADDR }</td>
</tr>
<tr>
<td>수용인원 : ${data.L_PNUM }명</td>
</tr>
<tr>
<td>대관시간 : ${data.L_SDATE }~${data.L_EDATE }</td>
</tr>
<tr>
<td>대관금액 : 원</td>
</tr>
<tr>
<td>대여횟수 : ${data.L_USE_NUM }번</td>
</tr>
</table>
<hr class="md_hr">



<table  align="right">
<tr><td align="right">
<input type="button" name="lendplace_submit" value="장소사용 신청하기" onclick="return lp_check();">
</td></tr>
</table>

</td>
</tr>
</table>

<hr class="md_hr">

<table  class="md_content">
<tr>
<td>
<div style="font-weight: bold;font-size: large;">장소정보</div>
<div style="border:1px solid red;padding:2%;">${data.L_CONTENT }</div>

<br>
<br>
</td>
</tr>

<tr><td>

<div style="font-weight: bold;font-size: large;">지도보기</div>
<div id="map" style="width:100%;height:350px;" class="md_contet_map"></div>
<br>
<b>※&nbsp;${data.L_ADDR }&nbsp;(${data.L_TITLE })</b>
<br>

<script src="//apis.daum.net/maps/maps3.js?apikey=a18085cad4f8315645fc4a233bdb2875&libraries=services" onerror="alertify.log('지도 로드중 에러!')"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

//지도에 컨트롤을 추가해야 지도위에 표시됩니다
//daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

//주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

//주소로 좌표를 검색합니다
geocoder.addr2coord('${data.L_ADDR }', function(status, result) {

// 정상적으로 검색이 완료됐으면 
 if (status === daum.maps.services.Status.OK) {

    var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new daum.maps.Marker({
        map: map,
        position: coords
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new daum.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">${data.L_TITLE }</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
} 
});


/* 장소사용 신청전 로그인 확인  */
function lp_check(kind){
	var session_id = '<s:property value="#session.session_m_email"/>';
	
	if(session_id == null || session_id.length <= 0){
		alertify.error("로그인 상태가 아닙니다.");
		return false;
	}
	if(session_id != null){
		location.href='lendplaceBook.action?l_no=<s:property value="detailData.l_no"/>';
	}
}

</script>


<!-- 모임장소 추천안내 -->
<div style="font-weight: bold;font-size:small;padding-top: 50px">모임장소 추천안내</div>
<div class="cancel_info">
* TEP에서 소규모의 미팅이나 스터디, 세미나 그리고 대규모의 강연까지 가능한 모임장소를 추천해 드립니다.<br>
* 모임의 목적에 맞는 규모와 장소, 시간, 편의시설, 지원장비 등을 꼼꼼히 확인하시고 목록에서 장소를 신청해 주세요.<br>
</div>

</td></tr>
</table>


</td>
</tr>
</table>
</body>
</html>