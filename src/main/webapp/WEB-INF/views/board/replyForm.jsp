<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function backToList(obj) {
		obj.action = "${contextPath}/board/listArticles.do";
		obj.submit();
	}

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
<title>답글쓰기 페이지</title>
</head>
<body>
	<div class="wrap">
		<h2>답글쓰기</h2>
		<form name="articleForm" method="post"
			action="${contextPath}/board/addReply.do"
			enctype="multipart/form-data">
			<div class="form-group">
				<label for="exampleInputWriter" class="form-label mt-4">작성자</label>
				<input type="text" class="form-control" id="exampleInputWriter"
					aria-describedby="emailHelp" value="${member.name }" size="20"
					maxlength="100" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="exampleInputTitle" class="form-label mt-4">글제목</label> <input
					type="text" class="form-control" id="exampleInputTitle"
					aria-describedby="emailHelp" placeholder="제목을 입력하세요" size="67"
					maxlength="500" name="title">
			</div>
			<div class="form-group">
				<label for="exampleTextarea" class="form-label mt-4">글 내용</label>
				<textarea class="form-control" id="exampleTextarea" rows="10"
					cols="65" maxlength="4000" name="content"></textarea>
			</div>
			<div class="form-group">
				<label for="formFile" class="form-label mt-4">이미지 파일 첨부</label> <input
					class="form-control" type="file" id="formFile" name="imageFileName"
					onchange="readURL(this);">
			</div>
			<br>

			<!-- 이미지파일 첨부: <input type="file" name="imageFileName"
		onchange="readURL(this);" /> <img id="preview" src="#" width=200
		height=200 /> 이미지파일 첨부 <input type="button" value="파일 추가"
		onClick="fn_addFile()" /> -->

			<div id="d_file"></div>

			<button type="button" class="btn btn-info" onClick="fn_addFile()">파일추가</button>
			<button type="submit" class="btn btn-secondary btn-lg">답글쓰기</button>
			<div class="d-grid gap-2">
				<button type="button" class="btn btn-lg btn-primary"
					onClick="backToList(this.form)">목록보기</button>
			</div>
			<!-- <input type="submit" value="글쓰기" /> -->
			<!-- <input type=button value="목록보기" onClick="backToList(this.form)" /> -->


		</form>
	</div>
</body>
</html>