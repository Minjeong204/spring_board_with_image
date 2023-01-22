package com.myspring.pro30.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.pro30.board.dao.BoardDAO;
import com.myspring.pro30.board.vo.ArticleVO;
import com.myspring.pro30.board.vo.ImageVO;

@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO boardDAO;

	public List<ArticleVO> listArticles() throws Exception {
		List<ArticleVO> articleList = boardDAO.selectAllArticlesList();
		return articleList;
	}

	@Override
	public int addReply(Map articleMap) {
		return boardDAO.insertNewArticle(articleMap);
	}

	@Override
	public int addNewArticle(Map articleMap) throws Exception {
		int articleNO = boardDAO.insertNewArticle(articleMap);
		articleMap.put("articleNO", articleNO);
		boardDAO.insertNewImage(articleMap);
		return articleNO;
	}

	@Override
	public void modArticle(Map articleMap) throws Exception {
		boardDAO.updateArticle(articleMap);

		List<ImageVO> fileList = (List<ImageVO>) articleMap.get("imageFileList");
		List<ImageVO> modAddimageFileList = (List<ImageVO>) articleMap.get("modAddimageFileList");

		if (fileList != null && fileList.size() != 0) {
			int added_img_num = Integer.parseInt((String) articleMap.get("added_img_num"));
			int pre_img_num = Integer.parseInt((String) articleMap.get("pre_img_num"));

			if (pre_img_num < added_img_num) { // ���� �߰��� �̹����� �ִ� ���� ���� ��� ����� ó��
				boardDAO.updateImageFile(articleMap);
				boardDAO.insertModNewImage(articleMap);
			} else {
				boardDAO.updateImageFile(articleMap);
			}
		} else if (modAddimageFileList != null && modAddimageFileList.size() != 0) {
			boardDAO.insertModNewImage(articleMap);
		}
	}

	@Override
	public void removeArticle(int articleNO) throws Exception {
		boardDAO.deleteArticle(articleNO);
	}

	@Override
	public void removeModImage(ImageVO imageVO) throws Exception {
		boardDAO.deleteModImage(imageVO);

	}

	@Override
	public Map viewArticle(int articleNO) throws Exception {
		Map articleMap = new HashMap();
		ArticleVO articleVO = boardDAO.selectArticle(articleNO);
		List<ImageVO> imageFileList = boardDAO.selectImageFileList(articleNO);
		articleMap.put("article", articleVO);
		articleMap.put("imageFileList", imageFileList);
		return articleMap;
	}
}
