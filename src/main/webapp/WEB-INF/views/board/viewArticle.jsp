<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:set var="article" value="${articleMap.article}" />
<c:set var="imageFileList" value="${articleMap.imageFileList}" />


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

.tr_modEnable {
	visibility: hidden;
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
		$(".tr_modEnable").css('visibility', 'visible');
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

			<c:set var="img_index" />
			<c:choose>
				<c:when test="${not empty imageFileList && imageFileList!='null' }">
					<c:forEach var="item" items="${imageFileList}" varStatus="status">
						<tr>
							<td width="150" align="center" bgcolor="#FF9933">
								이미지${status.count }</td>
							<td><input type="hidden" name="oldFileName"
								value="${item.imageFileName }" /> <input type="hidden"
								name="imageFileNO" value="${item.imageFileNO }" /> <img
								src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${item.imageFileName}"
								id="preview${status.index }" /><br></td>
						</tr>
						<tr class="tr_modEnable">
							<td></td>
							<td><input type="file" class="form-control"
								name="imageFileName${status.index }"
								id="i_imageFileName${status.index }"
								onchange="readURL(this, ${status.index });" /> <input
								type="button" class="btn btn-danger" value="이미지 삭제하기"
								onclick="fn_removeModImage(${item.imageFileNO },  ${item.articleNO }, '${item.imageFileName }' )" />
							</td>
						</tr>
						<c:if test="${status.last eq true }">
							<c:set var="img_index" value="${status.count}" />
							<input type="hidden" name="pre_img_num" value="${status.count}" />
							<!-- 기존의 이미지수 -->
							<input type="hidden" id="added_img_num" name="added_img_num"
								value="${status.count}" />
							<!--   수정시 새로 추가된 이미지 수  -->
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:set var="img_index" value="${0}" />
					<input type="hidden" name="pre_img_num" value="${0}" />
					<!-- 기존의 이미지수 -->
					<input type="hidden" id="added_img_num" name="added_img_num"
						value="${0}" />
					<!--   수정시 새로 추가된 이미지 수  -->
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="2">
					<table id="tb_addImage" align="center">
					</table>
				</td>
			</tr>

			<tr class="tr_modEnable">
				<td colspan="2"><input type="button" value="이미지 추가"
					onclick="fn_addModImage(${img_index})" /></td>
			</tr>
			<br>
			<tr>
				<td><label for="tr_date" class="form-label mt-4">등록일자</label></td>
				<td><input type="text" class="form-control" id="tr_date"
					aria-describedby="emailHelp"
					value="<fmt:formatDate value="${article.writeDate}" />"
					disabled="disabled"></td>
			</tr>
			<tr id="tr_btn_modify" align="center">
				<td align="center"><button type=button id="tr_btn_modify"
						onClick="fn_modify_article(frmArticle)" class="btn btn-warning">수정반영하기</button>
				</td>
				<td align="center">
					<button type=button onClick="backToList(frmArticle)" id="tr_btn_modify"
						class="btn btn-danger">취소</button>
				</td>
			</tr>

			<!-- 이미지파일 첨부: <input type="file" name="imageFileName"
		onchange="readURL(this);" /> <img id="preview" src="#" width=200
		height=200 /> 이미지파일 첨부 <input type="button" value="파일 추가"
		onClick="fn_addFile()" /> -->

			<div id="d_file"></div>

			<!-- 			<button type="submit" class="btn btn-secondary">글쓰기</button>
			<div class="d-grid gap-2">
				<button type="button" class="btn btn-lg btn-primary"
					onClick="backToList(this.form)">목록보기</button>
			</div> -->
			<tr id="tr_btn">
				<td colspan="2" align="center"><c:if
						test="${member.id == article.id }">
						<%-- <input type=button value="수정하기" onClick="fn_enable(this.form)">
						<input type=button value="삭제하기"
							onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})"> --%>

						<button type="button" class="btn btn-lg btn-warning"
							onClick="fn_enable(this.form)" >수정하기</button>


						<button type="button" class="btn btn-lg btn-danger"
							onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})">삭제하기</button>



					</c:if>
					<div class="d-grid gap-2">
						<button type="button" class="btn btn-lg btn-secondary"
							onClick="backToList(frmArticle)">리스트로 돌아가기</button>
					</div> <!-- <input type=button value="리스트로 돌아가기"
						onClick="backToList(this.form)"> --> <%-- <input type=button
					value="답글쓰기"
					onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})"> --%>
				</td>
			</tr>


			<!-- <input type="submit" value="글쓰기" /> -->
			<!-- <input type=button value="목록보기" onClick="backToList(this.form)" /> -->
		</table>

	</form>
</div>
