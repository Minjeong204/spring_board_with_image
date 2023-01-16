<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
	<form method="post" action="${contextPath}/member/addMember.do">
		<fieldset>
			<h2>회원 가입창</h2>
			<div class="form-group row">
				<div class="form-group">
					<label for="exampleInputId1" class="form-label mt-4">아이디</label> <input
						type="email" class="form-control" id="exampleInputId1"
						aria-describedby="emailHelp" placeholder="아이디를 입력하세요" name="id" />
				</div>
				<div class="form-group">
					<label for="exampleInputPassword1" class="form-label mt-4">비밀번호</label>
					<input type="password" class="form-control"
						id="exampleInputPassword1" placeholder="비밀번호를 입력하세요" name="pwd" />
				</div>
				<div class="form-group">
					<label for="exampleInputName" class="form-label mt-4">이름</label> <input
						type="email" class="form-control" id="exampleInputName"
						aria-describedby="emailHelp" placeholder="이름을 입력하세요" name="name" />
				</div>
				<div class="form-group">
					<label for="exampleInputEmail1" class="form-label mt-4">Email</label>
					<input type="email" class="form-control" id="exampleInputEmail1"
						name="email" />
				</div>
				<button type="submit" class="btn btn-primary">Join</button>
			</div>
		</fieldset>
	</form>