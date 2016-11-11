<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/include/common-header.jspf"%>
<style type="text/css">
table.login_table {
	border-style: solid;
	border-color: red;
	border-width: thin;
	padding: 3%;
}

td.login_name {
	text-align: center;
	font-family: sans-serif;
	font-weight: bold;
	font-size: 19px;
}

b.login_msg{
	font-family: sans-serif;
	color: olive;
}

td.login_btn_grp {
	padding-top: 30px;
	text-align: center;
}

input.login_btn {
	width: 100px;
	height: 50px;
}
</style>

<script type="text/javascript">
	window.onload = function () {
		var msg = [
		           '오늘은 날씨가 좋네요 ^_^',
		           '건강 조심하세요~♡',
		           '오늘도 행복하세요!!',
		           '힘내서 파이팅 하세요!',
		           '언제나 처럼 행복하게~♡',
		           '기적은 일어난답니다!!',
		           '자신을 믿어보세요!! 으쌰!!',
		           '자신을 사랑해주세요~♡',
		           ];
		var rnum = Math.floor(Math.random() * msg.length);
		
		document.getElementById("login_msg").innerHTML = "<b class='login_msg'>"+msg[rnum]+"</b>";
	}
</script>

</head>
<body>
	<br>
	<c:set var="savePageURI" value="${sessionScope.save_current_page_uri}"/>
	<table class="login_table" align=center>
	
		<tr>
			<td class="login_name">
				${sessionScope.session_m_name }님
			</td>
		</tr>
		<tr>
			<td id="login_msg" align="center" height="30"></td>
		</tr>
	
		<tr>
			<td class="login_btn_grp">
				<input class="login_btn" type="button" value="마이페이지" onclick="location.href='<c:url value="/mypageView"/>'">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="login_btn" type="button" value="메인으로" onclick="location.href='<c:url value="/meetings"/>'">
				<c:if test="${savePageURI != null }">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="login_btn" type="button" value="이전 페이지" onclick="location.href='<c:url value="${savePageURI}"/>'">
				</c:if>
			</td>
		</tr>
	
	</table>
	<br>
</body>
</html>
