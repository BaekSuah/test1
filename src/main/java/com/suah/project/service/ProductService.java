package com.suah.project.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import com.suah.project.domain.ProductVO;
import com.suah.project.repository.ProductDAO;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class ProductService {
	
	@Autowired
	ProductDAO dao;
	
	@Autowired
	TransactionTemplate txTemplate;
	
	@Autowired
	DataSourceTransactionManager txManager;
	
	@Transactional(readOnly=true)
	public List<ProductVO> listBestProduct() {
		
		return txTemplate.execute(txStatus-> { 
			return dao.listBestProduct(); 
		});
		
	}
	
//	@Transactional(readOnly=true)
//	public List<ProductVO> listBestProduct() {
//		
//		TransactionDefinition def = new DefaultTransactionDefinition();
//		TransactionStatus status = txManager.getTransaction(def);
//		
//		List<ProductVO> list = new ArrayList<>();
//		
//		try {
//			list = dao.listBestProduct();
//			txManager.commit(status);
//		} catch (Exception e) {
//			txManager.rollback(status);
//			log.error("ProductService.listBestProduct error");
//		} //
//		
//		return list;
//	}
	
//	@Transactional(readOnly=true, rollbackFor=Exception.class)
//	public List<ProductVO> listBestProduct() {
//		
//		return dao.listBestProduct();
//	}

	@Transactional(readOnly=true)
	public List<ProductVO> listNewProduct() {
		
		return txTemplate.execute(txStatus-> { 
			return dao.listNewProduct(); 
		});
		
	}
	
	@Transactional(readOnly=true)
	public List<ProductVO> listKindProduct(int kind) {
		
		return txTemplate.execute(txStatus-> { 
			return dao.listKindProduct(kind); 
		});
		
	}
	
	@Transactional(readOnly=true)
	public ProductVO getProduct(int pseq) {
		
		return txTemplate.execute(txStatus-> { 
			return dao.getProduct(pseq); 
		});
		
	}
	
}
