package com.suah.project.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suah.project.domain.ProductVO;

// import lombok.extern.log4j.Log4j2;
// import lombok.extern.slf4j.Slf4j;

@Repository
// @Slf4j
// @Log4j2
public class ProductDAO {
	
	private static final Logger log
		= LoggerFactory.getLogger(ProductDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	public List<ProductVO> listBestProduct() {
		
		log.info("ProductDAO.listBestProduct");
		return sqlSession.selectList("com.suah.project.mapper.Product.listBestProduct");
	}

	public List<ProductVO> listNewProduct() {
		
		log.info("ProductDAO.listNewProduct");
		return sqlSession.selectList("com.suah.project.mapper.Product.listNewProduct");
	}
	
	public List<ProductVO> listKindProduct(int kind) {
		
		log.info("ProductDAO.listKindProduct");
		return sqlSession.selectList("com.suah.project.mapper.Product.listKindProduct", kind);
	}
	
	public ProductVO getProduct(int pseq) {
		
		log.info("ProductDAO.getProduct");
		return sqlSession.selectOne("com.suah.project.mapper.Product.getProduct", pseq);
		
	}
}
