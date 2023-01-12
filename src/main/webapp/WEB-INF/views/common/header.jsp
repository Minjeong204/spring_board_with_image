<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<script type="text/javascript">
	var loopSearch = true;
	function keywordSearch() {
		if (loopSearch == false)
			return;
		var value = document.frmSearch.searchWord.value;
		$.ajax({
			type : "get",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/keywordSearch.do",
			data : {
				keyword : value
			},
			success : function(data, textStatus) {
				var jsonInfo = JSON.parse(data);
				displayResult(jsonInfo);
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다." + data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");

			}
		}); //end ajax	
	}

	function displayResult(jsonInfo) {
		var count = jsonInfo.keyword.length;
		if (count > 0) {
			var html = '';
			for ( var i in jsonInfo.keyword) {
				html += "<a href=\"javascript:select('" + jsonInfo.keyword[i]
						+ "')\">" + jsonInfo.keyword[i] + "</a><br/>";
			}
			var listView = document.getElementById("suggestList");
			listView.innerHTML = html;
			show('suggest');
		} else {
			hide('suggest');
		}
	}

	function select(selectedKeyword) {
		document.frmSearch.searchWord.value = selectedKeyword;
		loopSearch = false;
		hide('suggest');
	}

	function show(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.style.display = 'block';
		}
	}

	function hide(elementId) {
		var element = document.getElementById(elementId);
		if (element) {
			element.style.display = 'none';
		}
	}

	$(document).ready(function() {

		$(".subm").css("visibility", "hidden");
		$("#sub_wrap li").hover(function() {
			$(this).children("ul .subm").css("visibility", "visible");
		}, function() {
			$(this).children("ul .subm").css("visibility", "hidden");
		});
	});
</script>
<style>
.quick {
	width: 1200px;
	height: 45px;
	margin: 0 auto;
	text-align: right;
	line-height: 45px;
	float: right;
	margin-right: 60px;
}

.quick li {
	display: inline-block;
	margin-left: 10px;
	padding-left: 10px;
	font-weight: bold;
	color: #999999;
}

.quick li:first-child:hover, .quick li:nth-child(2):hover {
	color: #000;
}

.quick li:first-child {
	margin-left: 0;
	background: none;
	padding-left: 0;
}

.quick li:last-child {
	background: none;
	padding-left: 0;
}

.quick li:last-child a {
	background-color: #aaaaaa;
	color: #ffffff;
	width: 65px;
	height: 22px;
	display: inline-block;
	line-height: 22px;
	text-align: center;
	border-radius: 20px;
}

.quick li:last-child a:hover {
	background-color: #373427;
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
</style>

<body>

	<!--quick_wrap-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Navbar</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarColor01"
				aria-controls="navbarColor01" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active"
						href="${contextPath}/member/listMembers.do">회원관리 <span
							class="visually-hidden">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${contextPath}/board/listArticles.do">게시판 관리</a></li>
					<li class="nav-item"><a class="nav-link" href="#">상품 관리</a></li>
				</ul>
				<%-- <div id="quick_wrap" class="d-flex">
					<ul class="quick">
						<c:choose>
							<c:when test="${isLogOn == true  && member!= null}">
								<li>${member.name }님!</li>
								<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
							</c:when>
							<c:otherwise>
								<li class="me-sm-2"><a href="${contextPath}/member/loginForm.do">로그인</a></li>
								<li><a href="${contextPath}/member/memberForm.do">회원가입</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div> --%>
				<form class="d-flex">
					<c:choose>
						<c:when test="${isLogOn == true  && member!= null}">
							<button class="btn btn-secondary my-2 my-sm-0 user" type="button">
								${member.name }님!</button>
							<button class="btn btn-secondary my-2 my-sm-0" type="button">
								<a href="${contextPath}/member/logout.do">로그아웃</a>
							</button>
						</c:when>
						<c:otherwise>
							<button class="btn btn-secondary my-2 my-sm-0" type="button">
								<a href="${contextPath}/member/loginForm.do">로그인</a>
							</button>
							<button class="btn btn-secondary my-2 my-sm-0" type="button">
								<a href="${contextPath}/member/memberForm.do">회원가입</a>
							</button>
						</c:otherwise>
					</c:choose>
				</form>
			</div>
		</div>
	</nav>
</body>
</html>