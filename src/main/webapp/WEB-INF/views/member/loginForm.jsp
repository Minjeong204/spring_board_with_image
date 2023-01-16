<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>



	<form name="frmLogin" method="post"
		action="${contextPath}/member/login.do">
		<fieldset>
			<h2>로그인</h2>
			<div class="form-group">
				<label for="exampleInputName" class="form-label mt-4">아이디</label> <input
					type="text" class="form-control" id="exampleInputName"
					placeholder="아이디를 입력하세요" name="id">
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1" class="form-label mt-4">비밀번호</label>
				<input type="password" class="form-control"
					id="exampleInputPassword1" placeholder="비밀번호를 입력하세요" name="pwd">
			</div>
			<!--wrap-->
			<button type="submit" class="btn btn-primary">로그인</button>

		</fieldset>

	</form>