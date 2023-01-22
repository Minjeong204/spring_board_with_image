<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- Footer -->
<div class="footer-basic">
	<footer>
		<div class="social">
			<a href="#"><i class="icon ion-social-instagram"></i></a><a href="#"><i
				class="icon ion-social-snapchat"></i></a><a href="#"><i
				class="icon ion-social-twitter"></i></a><a href="#"><i
				class="icon ion-social-facebook"></i></a>
		</div>
		<ul class="list-inline">
			<li class="list-inline-item"><a href="${contextPath}/main.do">Home</a></li>
			<li class="list-inline-item"><a
				href="${contextPath}/member/memberForm.do">Join</a></li>
			<li class="list-inline-item"><a href="#">About</a></li>
			<li class="list-inline-item"><a href="#">Terms</a></li>
			<li class="list-inline-item"><a href="#">Privacy Policy</a></li>
		</ul>
		<p class="copyright">Company Name © 2023</p>
	</footer>
</div>

</html>