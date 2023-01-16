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
<title>글보기</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
     function backToList(obj){
       obj.action="${contextPath}/board/listArticles.do";
       obj.submit();
     }
 
    function fn_enable(obj){
       document.getElementById("i_title").disabled=false;
       document.getElementById("i_content").disabled=false;
       document.getElementById("i_imageFileName").disabled=false;
       document.getElementById("tr_btn_modify").style.display="inline-block";
       document.getElementById("tr_file_upload").style.display="block";
       document.getElementById("tr_btn").style.display="none";
    }
    
    function fn_modify_article(obj){
       obj.action="${contextPath}/board/modArticle.do";
       obj.submit();
    }
    
    function fn_remove_article(url,articleNO){
       var form = document.createElement("form");
       form.setAttribute("method", "post");
       form.setAttribute("action", url);
        var articleNOInput = document.createElement("input");
        articleNOInput.setAttribute("type","hidden");
        articleNOInput.setAttribute("name","articleNO");
        articleNOInput.setAttribute("value", articleNO);
       
        form.appendChild(articleNOInput);
        document.body.appendChild(form);
        form.submit();
    
    }
    
    function fn_reply_form(url, parentNO){
       var form = document.createElement("form");
       form.setAttribute("method", "post");
       form.setAttribute("action", url);
        var parentNOInput = document.createElement("input");
        parentNOInput.setAttribute("type","hidden");
        parentNOInput.setAttribute("name","parentNO");
        parentNOInput.setAttribute("value", parentNO);
       
        form.appendChild(parentNOInput);
        document.body.appendChild(form);
       form.submit();
    }
    
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }  
 </script>
</head>
<body>
	<div class="wrap">
		<form name="frmArticle" method="post" action="${contextPath}"
			enctype="multipart/form-data">
			<table>
				<tr>
					<td width=150 align="center" bgcolor=#FF9933><label
						for="exampleInputNumber" class="form-label mt-4">글 번호</label></td>
					<td><input type="text" class="form-control"
						id="exampleInputNumber" aria-describedby="emailHelp"
						value="${article.articleNO }" disabled="disabled"> <input
						type="hidden" name="articleNO" value="${article.articleNO}" /></td>
				</tr>
				<tr>
					<td width="150" align="center" bgcolor="#FF9933">작성자 아이디</td>
					<td><input type=text value="${article.id }" name="writer"
						disabled class="form-control" /></td>
				</tr>
				<tr>
					<td width="150" align="center" bgcolor="#FF9933">제목</td>
					<td><input type=text value="${article.title }" name="title"
						id="i_title" disabled class="form-control" /></td>
				</tr>
				<tr>
					<td width="150" align="center" bgcolor="#FF9933">내용</td>
					<td><textarea rows="20" cols="60" name="content"
							id="i_content" disabled class="form-control" />${article.content }</textarea></td>
				</tr>

				<c:choose>
					<c:when
						test="${not empty article.imageFileName && article.imageFileName!='null' }">
						<tr>
							<td width="150" align="center" bgcolor="#FF9933" rowspan="2">
								이미지</td>
							<td><input type="hidden" name="originalFileName"
								value="${article.imageFileName }" /> <img
								src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}"
								id="preview" /><br></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div class="form-group">
									<label for="formFile" class="form-label mt-4">이미지 파일 첨부</label>
									<input class="form-control" type="file" name="imageFileName "
										id="i_imageFileName" disabled onchange="readURL(this);">
								</div>
							</td>
						</tr>
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
							<td><img id="preview" /><br>

								<div class="form-group">
									<label for="formFile" class="form-label mt-4">이미지 파일 첨부</label>
									<input class="form-control" type="file" name="imageFileName "
										id="i_imageFileName" disabled onchange="readURL(this);">
								</div> <br></td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr>
					<td width="150" align="center" bgcolor="#FF9933">등록일자</td>
					<td><input type=text
						value="<fmt:formatDate value="${article.writeDate}" />" disabled />
					</td>
				</tr>
				<tr id="tr_btn_modify" align="center">
					<td align="center"><button type=button
							onClick="fn_modify_article(frmArticle)" class="btn btn-warning">수정반영하기</button>
					</td>
					<td align="center">
						<button type=button onClick="backToList(frmArticle)"
							class="btn btn-danger">취소</button>
					</td>
				</tr>

				<tr id="tr_btn">
					<td colspan="2" align="center"><c:if
							test="${member.id == article.id }">
							<button type=button onClick="fn_enable(this.form)"
								class="btn btn-warning">수정하기</button>
							<button type=button value="삭제하기"
								onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})"
								class="btn btn-danger">삭제하기</button>
						</c:if>
						<button type=button value="리스트로 돌아가기"
							onClick="backToList(this.form)" class="btn btn-primary">리스트로
							돌아가기</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>