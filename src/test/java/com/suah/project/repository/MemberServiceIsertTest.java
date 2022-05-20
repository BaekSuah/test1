package com.suah.project.repository;

import static org.junit.Assert.*;

import java.sql.Timestamp;

import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suah.project.domain.MemberVO;
import com.suah.project.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/resources/spring/db-context.xml"})
@Slf4j
public class MemberServiceIsertTest {

	@Autowired
	MemberService memberSvc;
	
	MemberVO member;
	
	@Before
	public void setup() {
		
		member = new MemberVO ("dksalrud123", "dksalrud123!", "안미경", "dksalrud@naver.com", "010-3333-4444", 
				"07714", "서울특별시 강서구 화곡동 149(화곡동)", "심당빌딩 404호", "y", new Timestamp(System.currentTimeMillis()));
	}

//	@Transactional(propagation=Propagation.REQUIRED)
//	@Rollback(true)
	@Test
	public void test() {
		log.info("MemberService.insertMember unit test");
				
//		assertTrue(memberSvc.insertMember(member));
	}

}