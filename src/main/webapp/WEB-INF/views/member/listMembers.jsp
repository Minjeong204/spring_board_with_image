<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
request.setCharacterEncoding("UTF-8");
%>


<html>
<head>
<meta charset=UTF-8">
<title>회원 정보 출력창</title>
<style type="text/css">
.wrap {
	margin-top: 50px;
	width: 70%;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	margin-bottom: 50px;
}
</style>
</head>
<body>
	<div class="wrap">
		<table class="table table-hover">
			<tr class="table-primary" align="center">
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>가입일</th>
				<th>삭제</th>
			</tr>

			<c:forEach var="member" items="${membersList}">
				<tr align="center">
					<td>${member.id}</td>
					<td>${member.pwd}</td>
					<td>${member.name}</td>
					<td>${member.email}</td>
					<td>${member.joinDate}</td>
					<td><a
						href="${contextPath}/member/removeMember.do?id=${member.id }">삭제하기</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>
