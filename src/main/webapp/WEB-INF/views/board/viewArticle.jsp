<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- 
<c:set var="article"  value="${articleMap.article}"  />
<c:set var="imageFileList"  value="${articleMap.imageFileList}"  />

 --%>
<%
request.setCharacterEncoding("UTF-8");
%>

<style>
#tr_file_upload {
	display: none;
}

#tr_btn_modify {
	display: none;
}

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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function backToList(obj) {
		obj.action = "${contextPath}/board/listArticles.do";
		obj.submit();
	}

	function fn_enable(obj) {
		document.getElementById("i_title").disabled = false;
		document.getElementById("i_content").disabled = false;
		document.getElementById("i_imageFileName").disabled = false;
		document.getElementById("tr_btn_modify").style.display = "block";
		document.getElementById("tr_file_upload").style.display = "block";
		document.getElementById("tr_btn").style.display = "none";
	}

	function fn_modify_article(obj) {
		obj.action = "${contextPath}/board/modArticle.do";
		obj.submit();
	}

	function fn_remove_article(url, articleNO) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var articleNOInput = document.createElement("input");
		articleNOInput.setAttribute("type", "hidden");
		articleNOInput.setAttribute("name", "articleNO");
		articleNOInput.setAttribute("value", articleNO);

		form.appendChild(articleNOInput);
		document.body.appendChild(form);
		form.submit();

	}

	function fn_reply_form(url, parentNO) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		var parentNOInput = document.createElement("input");
		parentNOInput.setAttribute("type", "hidden");
		parentNOInput.setAttribute("name", "parentNO");
		parentNOInput.setAttribute("value", parentNO);

		form.appendChild(parentNOInput);
		document.body.appendChild(form);
		form.submit();
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
<div class="wrap">
	<form name="frmArticle" method="post" action="${contextPath}"
		enctype="multipart/form-data">
		<div class="form-group">
			<label for="exampleInputNumber" class="form-label mt-4">글 번호</label>
			<input type="text" class="form-control" id="exampleInputNumber"
				aria-describedby="emailHelp" value="${article.articleNO }"
				disabled="disabled"> <input type="hidden"
				class="form-control" aria-describedby="emailHelp"
				value="${article.articleNO }" disabled="disabled" name="articleNO">
		</div>
		<div class="form-group">
			<label for="exampleInputWriter" class="form-label mt-4">작성자</label> <input
				type="text" class="form-control" id="exampleInputWriter"
				aria-describedby="emailHelp" value="${article.id }" name="writer"
				disabled="disabled">
		</div>
		<div class="form-group">
			<label for="i_title" class="form-label mt-4">글제목</label> <input
				type="text" class="form-control" id="i_title"
				aria-describedby="emailHelp" value="${article.title }" name="title"
				disabled="disabled">
		</div>
		<div class="form-group">
			<label for="i_content" class="form-label mt-4">글 내용</label>
			<textarea class="form-control" rows="20" cols="60" name="content"
				id="i_content" disabled>${article.content }</textarea>
		</div>
		<table>
			<c:choose>
				<c:when
					test="${not empty article.imageFileName && article.imageFileName!='null' }">

					<tr>
						<td colspan="2" align="center"><input type="hidden" name="originalFileName"
							value="${article.imageFileName }" /> <img
							src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}"
							id="preview" /><br></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div class="form-group">
								<label for="i_imageFileName" class="form-label mt-4">이미지
									파일 첨부</label> <input class="form-control" type="file"
									id="i_imageFileName" name="imageFileName"
									onchange="readURL(this);" disabled="disabled">
							</div>

						</td>
					</tr>
		</table>
		</c:when>
		<c:otherwise>
			<tr id="tr_file_upload">
				<td width="150" align="center" bgcolor="#FF9933" rowspan="2">
					이미지</td>
				<td><input type="hidden" name="originalFileName"
					value="${article.imageFileName }" /></td>
			</tr>
			<tr>
				<td></td>
				<td><img id="preview" /><br> <input type="file"
					name="imageFileName " id="i_imageFileName" disabled
					onchange="readURL(this);" /></td>
			</tr>
		</table>
		</c:otherwise>
		</c:choose>
		<br>

		<!-- 이미지파일 첨부: <input type="file" name="imageFileName"
		onchange="readURL(this);" /> <img id="preview" src="#" width=200
		height=200 /> 이미지파일 첨부 <input type="button" value="파일 추가"
		onClick="fn_addFile()" /> -->

		<div id="d_file"></div>

		<button type="submit" class="btn btn-secondary">글쓰기</button>
		<div class="d-grid gap-2">
			<button type="button" class="btn btn-lg btn-primary"
				onClick="backToList(this.form)">목록보기</button>
		</div>
		<!-- <input type="submit" value="글쓰기" /> -->
		<!-- <input type=button value="목록보기" onClick="backToList(this.form)" /> -->
	</form>
</div>
