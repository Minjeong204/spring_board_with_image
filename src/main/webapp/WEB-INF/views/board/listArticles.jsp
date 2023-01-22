<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style>
.wrap {
	margin-top: 50px;
	width: 70%;
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
</style>
<meta charset="UTF-8">
<title>글목록창</title>
</head>
<script>
	function fn_articleForm(isLogOn, articleForm, loginForm) {
		if (isLogOn != '' && isLogOn != 'false') {
			location.href = articleForm;
		} else {
			alert("로그인 후 글쓰기가 가능합니다.")
			location.href = loginForm + '?action=/board/articleForm.do';
		}
	}
</script>
<body>
	<div class="wrap">
		<table class="table table-hover">
			<tr class="table-primary" align="center">
				<th scope="row">글번호</th>
				<th scope="row">작성자</th>
				<th scope="row">제목</th>
				<th scope="row">작성일</th>
			</tr>
			<c:choose>
				<c:when test="${articlesList ==null }">
					<tr height="10">
						<td colspan="4">
							<p align="center">
								<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${articlesList !=null }">
					<c:forEach var="article" items="${articlesList}"
						varStatus="articleNum">
						<tr align="center">
							<td width="5%">${article.articleNO}</td>
							<td width="10%">${article.id}</td>
							<td align='center'><span></span> <c:choose>
									<c:when test='${article.level > 1 }'>
										<c:forEach begin="1" end="${article.level}" step="1">
											<span></span>
										</c:forEach>
										<span style="font-size: 12px;">[답변]</span>
										<a class='cls1'
											href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a>
									</c:when>
									<c:otherwise>
										<a
											href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a>
									</c:otherwise>
								</c:choose></td>
							<td width="10%">${article.writeDate}</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		<button class="btn btn-primary" type="button">
			<a
				href="javascript:fn_articleForm('${isLogOn}','${contextPath}/board/articleForm.do', 
                                                    '${contextPath}/member/loginForm.do')">글쓰기</a>
		</button>

	</div>
	<!-- <a  class="cls1"  href="#"><p class="cls2">글쓰기</p></a> -->



</body>
</html>