package com.myspring.pro30.board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.pro30.board.vo.ArticleVO;
import com.myspring.pro30.board.vo.ImageVO;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List selectAllArticlesList() throws Exception {
		List<ArticleVO> articleList = sqlSession.selectList("mapper.board.selectAllArticlesList");
		return articleList;
	}

	@Override
	public int insertNewArticle(Map articleMap) throws DataAccessException {
		int articleNO = selectNewArticleNO();
		articleMap.put("articleNO", articleNO);
		sqlSession.insert("mapper.board.insertNewArticle", articleMap);
		return articleNO;
	}

	private int selectNewArticleNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewArticleNO");
	}

	@Override
	public void insertNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> imageFileList = (ArrayList) articleMap.get("imageFileList");
		int articleNO = (Integer) articleMap.get("articleNO");
		int imageFileNO = selectNewImageFileNO();
		for (ImageVO imageVO : imageFileList) {
			imageVO.setImageFileNO(++imageFileNO);
			imageVO.setArticleNO(articleNO);
		}
		sqlSession.insert("mapper.board.insertNewImage", imageFileList);
	}

	private int selectNewImageFileNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewImageFileNO");
	}

	@Override
	public List selectImageFileList(int articleNO) throws DataAccessException {
		List<ImageVO> imageFileList = null;
		imageFileList = sqlSession.selectList("mapper.board.selectImageFileList", articleNO);
		return imageFileList;
	}

	@Override
	public ArticleVO selectArticle(int articleNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectArticle", articleNO);
	}

	@Override
	public void updateArticle(Map articleMap) throws DataAccessException {
		sqlSession.update("mapper.board.updateArticle", articleMap);
	}

	@Override
	public void deleteArticle(int articleNO) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteArticle", articleNO);

	}

	@Override
	public void updateImageFile(Map articleMap) throws DataAccessException {

		List<ImageVO> imageFileList = (ArrayList) articleMap.get("imageFileList");
		int articleNO = Integer.parseInt((String) articleMap.get("articleNO"));
		for (int i = imageFileList.size() - 1; i >= 0; i--) {
			ImageVO imageVO = imageFileList.get(i);
			String imageFileName = imageVO.getImageFileName();
			if (imageFileName == null) { // ������ �̹����� �������� �ʴ� ��� ���ϸ��� null �̹Ƿ� ������ �ʿ䰡 ����.
				imageFileList.remove(i);
			} else {
				imageVO.setArticleNO(articleNO);
			}
		}

		if (imageFileList != null && imageFileList.size() != 0) {
			sqlSession.update("mapper.board.updateImageFile", imageFileList);
		}

	}

	@Override
	public void deleteModImage(ImageVO imageVO) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteModImage", imageVO);

	}

	@Override
	public void insertModNewImage(Map articleMap) throws DataAccessException {
		List<ImageVO> modAddimageFileList = (ArrayList<ImageVO>) articleMap.get("modAddimageFileList");
		int articleNO = Integer.parseInt((String) articleMap.get("articleNO"));

		int imageFileNO = selectNewImageFileNO();

		for (ImageVO imageVO : modAddimageFileList) {
			imageVO.setArticleNO(articleNO);
			imageVO.setImageFileNO(++imageFileNO);
		}

		sqlSession.delete("mapper.board.insertModNewImage", modAddimageFileList);

	}
}
