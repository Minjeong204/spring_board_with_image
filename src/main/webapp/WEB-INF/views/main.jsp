<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<link href="${contextPath}/resources/css/styles.css" rel="stylesheet"
	type="text/css">
<%
request.setCharacterEncoding("UTF-8");
%>
<div class="container px-4 text-center">
	<h1 class="fw-bolder">Welcome to MyPage</h1>
	<p class="lead">간단한 기능들을 사용해보세요</p>
	<a class="btn btn-lg btn-light" href="#about">Start scrolling!</a>
</div>
<section id="about">
	<div class="container px-4">
		<div class="row gx-4 justify-content-center">
			<div class="col-lg-8">
				<h2>About this page</h2>
				<p class="lead">이미지가 첨부된 게시물의 업로드, 조회, 수정, 삭제가 가능한 간단한 페이지입니다.</p>
				<ul>
					<li>관리자만이 회원관리페이지를 열람할 수 있습니다.</li>
					<li>회원만이 글을 작성할 수 있습니다.(id: admin, password: 1234)</li>
					<li>이미지의 업로드 및 수정, 삭제가 가능합니다.</li>
				</ul>
			</div>
		</div>
	</div>
</section>
<!-- Services section-->
<section class="bg-light" id="services">
	<div class="container px-4">
		<div class="row gx-4 justify-content-center">
			<div class="col-lg-8">
				<h2>Services we offer</h2>
				<p class="lead">
					저희의 기능을 소개합니다.<br> <a
						href="${contextPath}/member/memberForm.do">- 회원가입</a><br> <a
						href="${contextPath}/member/loginForm.do">- 로그인</a><br> <a
						href="${contextPath}/board/listArticles.do">- 게시판으로 이동</a><br>
				</p>
			</div>
		</div>
	</div>
</section>
<!-- Contact section-->
<section id="contact">
	<div class="container px-4">
		<div class="row gx-4 justify-content-center">
			<div class="col-lg-8">
				<h2>Contact Me</h2>
				<p class="lead">
					<a href="https://github.com/Minjeong204">- 저의 깃주소:
						https://github.com/Minjeong204</a><br> - 저의 이메일
					:anjell1218@gmail.com<br>
				</p>
			</div>
		</div>
	</div>
</section>
<script src="${contextPath}/resources/js/scripts.js"></script>