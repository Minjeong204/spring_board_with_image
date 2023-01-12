package com.myspring.pro30.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.pro30.board.service.BoardService;
import com.myspring.pro30.board.vo.ArticleVO;
import com.myspring.pro30.board.vo.ImageVO;
import com.myspring.pro30.member.vo.MemberVO;

@Controller("boardController")
public class BoardControllerImpl implements BoardController {
	private static final String ARTICLE_IMAGE_REPO = "c:\\board\\article_image";
	@Autowired
	private BoardService boardService;
	@Autowired
	private ArticleVO articleVO;

	@Override
	@RequestMapping(value = "/board/listArticles.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		List articlesList = boardService.listArticles();
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("articlesList", articlesList);
		return mav;
	}

	@Override
	@RequestMapping(value = "/board/addNewArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		String imageFileName = null;

		Map articleMap = new HashMap();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			articleMap.put(name, value);
		}

		// �α��� �� ���ǿ� ����� ȸ�� �������� �۾��� ���̵� ���ͼ� Map�� �����մϴ�.
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		String id = memberVO.getId();
		articleMap.put("id", id);

		List<String> fileList = upload(multipartRequest);
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		if (fileList != null && fileList.size() != 0) {
			for (String fileName : fileList) {
				ImageVO imageVO = new ImageVO();
				imageVO.setImageFileName(fileName);
				imageFileList.add(imageVO);
			}
			articleMap.put("imageFileList", imageFileList);
		}
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			int articleNO = boardService.addNewArticle(articleMap);
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImageFileName();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
					File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
					// destDir.mkdirs();
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}
			}

			message = "<script>";
			message += " alert('������ �߰��߽��ϴ�.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/board/listArticles.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			if (imageFileList != null && imageFileList.size() != 0) {
				for (ImageVO imageVO : imageFileList) {
					imageFileName = imageVO.getImageFileName();
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
					srcFile.delete();
				}
			}

			message = " <script>";
			message += " alert('������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/board/articleForm.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	@RequestMapping(value = "/board/*Form.do", method = RequestMethod.GET)
	private ModelAndView form(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		return mav;
	}

	/*
	 * @RequestMapping(value = "/board/addReply.do", method = RequestMethod.POST)
	 * private ResponseEntity InsertReply(MultipartHttpServletRequest
	 * multipartRequest, HttpServletResponse response) throws Exception {
	 * HttpSession session; ResponseEntity resEnt = null; HttpHeaders
	 * responseHeaders = new HttpHeaders(); session = multipartRequest.getSession();
	 * String message; int parentNO = (Integer) session.getAttribute("parentNO");
	 * session.removeAttribute("parentNO"); Map<String, String> articleMap =
	 * upload(multipartRequest, response); String title = articleMap.get("title");
	 * String content = articleMap.get("content"); String imageFileName =
	 * articleMap.get("imageFileName"); articleVO.setParentNO(parentNO);
	 * articleVO.setId("lee"); articleVO.settitle(title);
	 * articleVO.setContent(content); articleVO.setImageFileName(imageFileName); int
	 * articleNO = boardService.addReply(articleVO); if (imageFileName != null &&
	 * imageFileName.length() != 0) { File srcFile = new File(ARTICLE_IMAGE_REPO +
	 * "\\" + "temp" + "\\" + imageFileName); File destDir = new
	 * File(ARTICLE_IMAGE_REPO + "\\" + articleNO); destDir.mkdirs();
	 * FileUtils.moveFileToDirectory(srcFile, destDir, true); } message =
	 * "<script>"; message += " alert('������ �߰��߽��ϴ�.');"; message +=
	 * " location.href='" + multipartRequest.getContextPath() +
	 * "/board/listArticles.do'; "; message += " </script>"; resEnt = new
	 * ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
	 * 
	 * return resEnt; }
	 */

	@RequestMapping(value = "/board/modArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity modArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> articleMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();

			if (name.equals("imageFileNO")) {
				String[] values = multipartRequest.getParameterValues(name);
				articleMap.put(name, values);
			} else if (name.equals("oldFileName")) {
				String[] values = multipartRequest.getParameterValues(name);
				articleMap.put(name, values);
			} else {
				String value = multipartRequest.getParameter(name);
				articleMap.put(name, value);
			}

		}

		List<String> fileList = uploadModImageFile(multipartRequest);

		int added_img_num = Integer.parseInt((String) articleMap.get("added_img_num"));
		int pre_img_num = Integer.parseInt((String) articleMap.get("pre_img_num"));
		List<ImageVO> imageFileList = new ArrayList<ImageVO>();
		List<ImageVO> modAddimageFileList = new ArrayList<ImageVO>();

		if (fileList != null && fileList.size() != 0) {
			String[] imageFileNO = (String[]) articleMap.get("imageFileNO");
			for (int i = 0; i < added_img_num; i++) {
				String fileName = fileList.get(i);
				ImageVO imageVO = new ImageVO();
				if (i < pre_img_num) {
					imageVO.setImageFileName(fileName);
					imageVO.setImageFileNO(Integer.parseInt(imageFileNO[i]));
					imageFileList.add(imageVO);
					articleMap.put("imageFileList", imageFileList);
				} else {
					imageVO.setImageFileName(fileName);
//						imageVO.setImageFileNO(Integer.parseInt(imageFileNO[i]));
					modAddimageFileList.add(imageVO);
					articleMap.put("modAddimageFileList", modAddimageFileList);
				}
			}
		}

//	articleMap.put("fileList", fileList);

		String articleNO = (String) articleMap.get("articleNO");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.modArticle(articleMap);
			if (fileList != null && fileList.size() != 0) { // ������ ���ϵ��� ���ʴ�� ���ε��Ѵ�.
				for (int i = 0; i < fileList.size(); i++) {
					String fileName = fileList.get(i);
					if (i < pre_img_num) {
						if (fileName != null) {
							File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
							File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);

							String[] oldName = (String[]) articleMap.get("oldFileName");
							String oldFileName = oldName[i];

							File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + oldFileName);
							oldFile.delete();
						}
					} else {
						if (fileName != null) {
							File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileName);
							File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
							FileUtils.moveFileToDirectory(srcFile, destDir, true);
						}
					}
				}
			}

			message = "<script>";
			message += " alert('���� �����߽��ϴ�.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/board/viewArticle.do?articleNO="
					+ articleNO + "';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {

			if (fileList != null && fileList.size() != 0) { // ���� �߻� �� temp ������ ���ε�� �̹��� ���ϵ��� �����Ѵ�.
				for (int i = 0; i < fileList.size(); i++) {
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + fileList.get(i));
					srcFile.delete();
				}

				e.printStackTrace();
			}

			message = "<script>";
			message += " alert('������ �߻��߽��ϴ�.�ٽ� �������ּ���');";
			message += " location.href='" + multipartRequest.getContextPath() + "/board/viewArticle.do?articleNO="
					+ articleNO + "';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	@RequestMapping(value = "/board/viewArticle.do", method = RequestMethod.GET)
	public ModelAndView viewArticle(@RequestParam("articleNO") int articleNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		Map articleMap = boardService.viewArticle(articleNO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		mav.addObject("articleMap", articleMap);
		return mav;
	}

	@RequestMapping(value = "/board/removeModImage.do", method = RequestMethod.POST)
	@ResponseBody
	public void removeModImage(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();

		try {
			String imageFileNO = (String) request.getParameter("imageFileNO");
			String imageFileName = (String) request.getParameter("imageFileName");
			String articleNO = (String) request.getParameter("articleNO");

			System.out.println("imageFileNO = " + imageFileNO);
			System.out.println("articleNO = " + articleNO);

			ImageVO imageVO = new ImageVO();
			imageVO.setArticleNO(Integer.parseInt(articleNO));
			imageVO.setImageFileNO(Integer.parseInt(imageFileNO));
			boardService.removeModImage(imageVO);

			File oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" + imageFileName);
			oldFile.delete();

			writer.print("success");
		} catch (Exception e) {
			writer.print("failed");
		}

	}

	private List<String> uploadModImageFile(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			if (originalFileName != "" && originalFileName != null) {
				fileList.add(originalFileName);
				File file = new File(ARTICLE_IMAGE_REPO + "\\" + fileName);
				if (mFile.getSize() != 0) { // File Null Check
					if (!file.exists()) { // ��λ� ������ �������� ���� ���
						file.getParentFile().mkdirs(); // ��ο� �ش��ϴ� ���丮���� ����
						mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + originalFileName)); // �ӽ÷�
																													// �����
																													// multipartFile��
																													// ����
																													// ���Ϸ�
																													// ����
					}
				}
			} else {
				fileList.add(null);
			}

		}
		return fileList;
	}

	/*
	 * @RequestMapping(value = "/board/modArticle.do", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public ResponseEntity modArticle(MultipartHttpServletRequest
	 * multipartRequest, HttpServletResponse response) throws Exception {
	 * multipartRequest.setCharacterEncoding("utf-8"); Map<String, Object>
	 * articleMap = new HashMap<String, Object>(); Enumeration enu =
	 * multipartRequest.getParameterNames(); while (enu.hasMoreElements()) { String
	 * name = (String) enu.nextElement(); String value =
	 * multipartRequest.getParameter(name); articleMap.put(name, value); }
	 * 
	 * String imageFileName = upload(multipartRequest); HttpSession session =
	 * multipartRequest.getSession(); MemberVO memberVO = (MemberVO)
	 * session.getAttribute("member"); String id = memberVO.getId();
	 * articleMap.put("id", id); articleMap.put("imageFileName", imageFileName);
	 * 
	 * String articleNO = (String) articleMap.get("articleNO"); String message;
	 * ResponseEntity resEnt = null; HttpHeaders responseHeaders = new
	 * HttpHeaders(); responseHeaders.add("Content-Type",
	 * "text/html; charset=utf-8"); try { boardService.modArticle(articleMap); if
	 * (imageFileName != null && imageFileName.length() != 0) { File srcFile = new
	 * File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName); File destDir
	 * = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
	 * FileUtils.moveFileToDirectory(srcFile, destDir, true);
	 * 
	 * String originalFileName = (String) articleMap.get("originalFileName"); File
	 * oldFile = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO + "\\" +
	 * originalFileName); oldFile.delete(); } message = "<script>"; message +=
	 * " alert('���� �����߽��ϴ�.');"; message += " location.href='" +
	 * multipartRequest.getContextPath() + "/board/viewArticle.do?articleNO=" +
	 * articleNO + "';"; message += " </script>"; resEnt = new
	 * ResponseEntity(message, responseHeaders, HttpStatus.CREATED); } catch
	 * (Exception e) { File srcFile = new File(ARTICLE_IMAGE_REPO +
	 * "\\" + "temp" + "\\" + imageFileName); srcFile.delete(); message =
	 * "<script>"; message += " alert('������ �߻��߽��ϴ�.�ٽ� �������ּ���');"; message +=
	 * " location.href='" + multipartRequest.getContextPath() +
	 * "/board/viewArticle.do?articleNO=" + articleNO + "';"; message +=
	 * " </script>"; resEnt = new ResponseEntity(message, responseHeaders,
	 * HttpStatus.CREATED); } return resEnt; }
	 */
	private List<String> upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		List<String> fileList = new ArrayList<String>();
		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			String originalFileName = mFile.getOriginalFilename();
			fileList.add(originalFileName);
			File file = new File(ARTICLE_IMAGE_REPO + "\\" + fileName);
			if (mFile.getSize() != 0) { // File Null Check
				if (!file.exists()) { // ��λ� ������ �������� ���� ���
					if (file.getParentFile().mkdirs()) { // ��ο� �ش��ϴ� ���丮���� ����
						file.createNewFile(); // ���� ���� ����
					}
				}
				mFile.transferTo(new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" + originalFileName)); // �ӽ÷� �����
																											// multipartFile��
																											// ���� ���Ϸ� ����
			}
		}
		return fileList;
	}

	@Override
	@RequestMapping(value = "/board/removeArticle.do", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity removeArticle(@RequestParam("articleNO") int articleNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			boardService.removeArticle(articleNO);
			File destDir = new File(ARTICLE_IMAGE_REPO + "\\" + articleNO);
			FileUtils.deleteDirectory(destDir);

			message = "<script>";
			message += " alert('���� �����߽��ϴ�.');";
			message += " location.href='" + request.getContextPath() + "/board/listArticles.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			message = "<script>";
			message += " alert('�۾��� ������ �߻��߽��ϴ�.�ٽ� �õ��� �ּ���.');";
			message += " location.href='" + request.getContextPath() + "/board/listArticles.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "utf-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("�Ķ���͸�:" + fileItem.getFieldName());
					// System.out.println("���ϸ�:" + fileItem.getName());
					System.out.println("����ũ��:" + fileItem.getSize() + "bytes");
					// articleMap.put(fileItem.getFieldName(), fileItem.getName());
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}

						String fileName = fileItem.getName().substring(idx + 1);
						System.out.println("���ϸ�:" + fileName);
						articleMap.put(fileItem.getFieldName(), fileName); // �ͽ��÷η����� ���ε� ������ ��� ���� �� map�� ���ϸ� ����
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);

					} // end if
				} // end if
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleMap;
	}

}
