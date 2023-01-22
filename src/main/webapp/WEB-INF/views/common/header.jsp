<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!--quick_wrap-->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	<div class="container-fluid">
		<a class="navbar-brand" href="${contextPath}/main.do">Simple Blog</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarColor01" aria-controls="navbarColor01"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarColor01">
			<ul class="navbar-nav me-auto">
				<c:choose>
					<c:when
						test="${isLogOn == true  && member!= null &&member.id=='admin'}">
						<li class="nav-item"><a class="nav-link active"
							href="${contextPath}/member/listMembers.do">회원관리 <span
								class="visually-hidden">(current)</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${contextPath}/board/listArticles.do">게시판 관리</a></li>
						<!-- <li class="nav-item"><a class="nav-link" href="#">상품 관리</a></li> -->
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link"
							href="${contextPath}/board/listArticles.do">게시판 관리</a></li>
						<!-- <li class="nav-item"><a class="nav-link" href="#">상품 관리</a></li> -->
					</c:otherwise>
				</c:choose>
			</ul>
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
		
		if(${isLogOn == false  && !(member.name =="admin")}){
			$(".nav-item").css("display","none");
		}
	});
</script>