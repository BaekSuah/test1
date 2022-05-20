package com.suah.project.service;

import static org.junit.Assert.*;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.suah.project.domain.ProductVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/resources/spring/db-context.xml"})
@Slf4j
public class MemberServiceIsMemberTest {

	@Autowired
	MemberService memberService;

	@Test
	public void test() {
		log.info("MemberService isMember unit test");
		
		assertTrue(memberService.isMember("qortndk123"));
	}
	
	@Test
	public void test2() {
		log.info("MemberService isMember unit test");
		
		assertFalse(memberService.isMember("qortndk"));
	}

}