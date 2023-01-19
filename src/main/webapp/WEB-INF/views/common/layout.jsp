<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link href="${contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">

<link href="${contextPath}/resources/css/footer.css" rel="stylesheet"
	type="text/css">
<link href="${contextPath}/resources/css/reset.css" rel="stylesheet"
	type="text/css">
<script src="${contextPath}/resources/js/bootstrap.bundle.min.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/jquery-1.6.2.min.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/jquery.easing.1.3.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/stickysidebar.jquery.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/basic-jquery-slider.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/tabs.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/jquery/carousel.js"
	type="text/javascript"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>
<!-- Footer -->
<script src="${contextPath}/resources/js/scripts.js"></script>
<style>
@font-face {
	font-family: nanum;
	src: url(../font/NanumGothic.eot);
	src: url("../font/NanumGothic.eot?#lefix") format("embaded-opentype");
	src: url("../font/NanumGothic.ttf") format("truetype");
	src: url("../font/NanumGothic.woff") format("woff");
}

* {
	font-family: 'Noto Sans KR', sans-serif;
}

a {
	color: #333333;
}

fieldset {
	width: 250px;
	margin-left: auto;
	margin-right: auto;
	margin-top: 50px;
	margin-bottom: 50px;
}

button[type=submit] {
	width: 100%;
	margin-top: 25px;
}

h2 {
	font-weight: bold;
	font-size: 20px;
}

a {
	text-decoration: none;
}

.btn-secondary {
	margin-right: 10px;
}

.user {
	border: none;
	background-color: transparent;
	width: 100px;
	pointer-events: none;
}

.user:hover {
	background-color: transparent;
	cusor: default;
}

.btn-secondary a {
	color: #fff;
}

.wrap {
	margin-top: 50px;
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	margin-bottom: 50px;
}

.btn-primary {
	width: 100%;
	margin-top: 30px;
}

.btn-primary a {
	color: #fff;
}

#tr_file_upload {
	display: none;
}

#tr_btn_modify {
	display: none;
}

#tr_btn button {
	margin-top: 15px;
}

#tr_btn button:first-child {
	margin-left: 150px;
}

#tr_btn_modify {
	width: 315%;
	margin-top: 15px;
}

#tr_btn_modify button {
	margin-left: 10px;
}

table {
	margin-left: auto;
	margin-right: auto;
}

.reply {
	width: 100%;
	margin-left: 150px;
}
</style>
<title><tiles:insertAttribute name="title" /></title>
</head>
<body>
	<div id="container">
		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>
		<%-- 		<div id="sidebar-left">
			<tiles:insertAttribute name="side" />
		</div> --%>
		<div id="content">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>