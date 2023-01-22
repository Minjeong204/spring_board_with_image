package com.myspring.pro30.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.pro30.board.vo.ArticleVO;
import com.myspring.pro30.board.vo.ImageVO;

public interface BoardService {

	int addNewArticle(Map articleMap) throws Exception;

	void modArticle(Map articleMap) throws Exception;

	void removeArticle(int articleNO) throws Exception;

	public Map viewArticle(int articleNO) throws Exception;

	int addReply(Map articleMap);

	void removeModImage(ImageVO imageVO) throws Exception;

	List<ArticleVO> listArticles() throws Exception;
}
